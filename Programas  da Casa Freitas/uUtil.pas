unit uUtil;

interface
   uses ADODB,Classes,funcoes,sysutils, Dialogs, forms, DBGrids,
        ComCTRLs, funcDatas, mxExport, adLabelComboBox, windows, QStdCtrls, DB, DBCtrls, Controls, messages, funcsql,
        uMain, uListaFornecedores;

{   function getDadosNota(isNota, is_uo, sr_docf, nr_docf:String):TADOQuery;
   function getTotaisVendaAvaria(lojas:TadLabelComboBox; datai, dataf:Tdate; tabela:String):String;
   procedure getTotaIsPorTipoDeAvaria(var tbTotais:TadoTAble; nmTabela:String);
   procedure getTotaisAvariasPorFornecedor(var tbTotais:TadoTAble; nmTabela:String);
   procedure calculaTotaisAvariasPorLoja(var tb:TADOTable; lojas:TadLabelComboBox; datai, dataf:Tdate);
   procedure calculaTotaisAvariasPorFornecedor(var tb:TADOTable; lojas:TadLabelComboBox; datai, dataf:Tdate);
   procedure calCulaPercentualDoFornecedor(var tb:TADOTable);
   procedure criaTabelaDosTotaisDeAvarias(var tb: TADOTable);
   procedure getCRUCBaseNota(conexao:TADOConnection; var query:TADOquery; is_ref:String);
   function recalcularCmuItem(is_ref:String):String;
   function getItensDeUmaNota(isNota:String):TDataSet;
   function getItensParaCadastroNCM(var tabela:TADOTable; isNota:String):boolean;
   function ajustaCodigoNCM(isRef, ncm_sh:String):boolean;
   function getDadosPessoa(cd_pes, nm_pes:String):TDataSet;
   function getFmDadosPessoa(codPerfil: char):String;
   function getDadosPedidoDeCompra(conexao: TADOconnection; numPedido:String):TdataSet;

}
implementation

{
procedure calCulaPercentualDoFornecedor(var tb:TADOTable);
var
  vPercentual, valorTotal:Real;
begin//
   valorTotal := funcsql.somaColunaTable(tb, 'valorTotalVenda');
   tb.First();
   while (tb.Eof = false) do
   begin
      vPercentual := (tb.fieldByName('valorTotalVenda').AsFloat * 100) / valorTotal ;
      tb.Edit();
      tb.FieldByName('fornecedor').asString := funcoes.floatToDinheiro(vPercentual) + '%';
      tb.Post();
      tb.Next();
   end;
end;

procedure criaTabelaDosTotaisDeAvarias(var tb: TADOTable);
var
   cmd:String;
begin
    if (tb.Active = true) then
       tb.Close();
    cmd := 'is_uo varchar(08), ds_uo varchar(30), TipoAvaria varchar(20), qtItens int, valorTotalCusto money, valorTotalPcVarejo money,  TotalVendido money, Fornecedor varchar(30)';
    funcsql.getTable(fmMain.Conexao, tb, cmd);
end;

procedure getTotaisAvariasPorFornecedor(var tbTotais:TadoTAble; nmTabela:String);
var
   cmd:String;
begin
   if (tbTotais.Active = true) then
       tbTotais.Close();
   cmd := 'tipoAvaria varchar(30), qtItens int, valorTotalCusto money, valorTotalVenda money, fornecedor varchar(30) ';
   getTable(fmMain.Conexao, tbtotais, cmd);

   cmd :=
      ' insert ' + tbTotais.TableName +
      ' select Fornecedor, sum(qtItens), sum(valorTotalCusto) as valorTotalCusto, sum(ValorTotalPcVarejo)as ValorTotalPcVarejo, '''' from ' + nmTabela +' group by fornecedor ';

   funcsql.execSQL(cmd, fmMain.Conexao);
   tbTotais.Close();
   tbTotais.Open();
end;


procedure getTotaisPorTipoDeAvaria(var tbTotais:TadoTAble; nmTabela:String);
var
   cmd:String;
begin
   if (tbTotais.Active = true) then
       tbTotais.Close();

   cmd := 'tipoAvaria varchar(30), qtItens int, valorTotalCusto money, valorTotalVenda money, fornecedor varchar(30) ';
   getTable(fmMain.Conexao, tbtotais, cmd);

   cmd :=
      ' insert ' + tbTotais.TableName +
      ' select tipoAvaria, sum(qtItens), sum(valorTotalCusto) as valorTotalCusto, sum(ValorTotalPcVarejo)as ValorTotalPcVarejo, '''' as Fornecedor from ' + nmTabela +' group by tipoAvaria '+
      ' union '+
      ' select ''Totalização: '' , sum(qtItens), sum(valorTotalCusto) as valorTotalCusto, sum(ValorTotalPcVarejo)as ValorTotalPcVarejo, '''' as Fornecedor from ' + nmTabela ;

   funcsql.execSQL(cmd, fmMain.Conexao);
   tbTotais.Close();
   tbTotais.Open();
end;


function getTotaisVendaAvaria(lojas:TadLabelComboBox; datai, dataf:Tdate; tabela:String):String;
var
   uo,cmd:String;
begin
   uo := fmMain.getCodUO(lojas);
   cmd := 'Select isNull(sum(qt*und),0) as valorVenda from zcf_avariasDescontos  (nolock) '+
          'where data between '+funcDatas.dateToSqlDate(datai)+' and '+funcDatas.dateToSqlDate(dataf)+
          ' and is_uo in (select distinct is_uo from ' + tabela +')';

   result := funcsql.openSQL( cmd, 'valorVenda', fmMain.Conexao);
end;

procedure calculaTotaisAvariasPorFornecedor(var tb:TADOTable; lojas:TadLabelComboBox; datai, dataf:Tdate);
var
   uo, cmd:String;
begin
   criaTabelaDosTotaisDeAvarias(tb);

   uo := fmMain.getCodUO(lojas);
   cmd := ' insert ' + tb.TableName +
   ' select UO.is_uo, UO.ds_uo, Par.valor, ' +
   'sum(I.quant) as totalQuantItens, '+
   'sum(quant*pco) as TotalCustoItens, '+
   'sum(quant*pcoVarejo) as TotalVendaItens, '+
   '0 as totalVendido, ' +#13+
   'F.nm_fantasi ' +#13+
   'from zcf_AvariasItens I ' +#13+
   'inner join zcf_avarias A on A.loja = I.loja and I.numAvaria = A.numAvaria '+#13+
   'inner join crefe P on I.is_ref = P.is_ref '+#13+
   'inner join dspes F on P.cd_pes = F.cd_pes '+#13+
   'inner join zcf_tbuo UO on I.loja = UO.is_uo '+#13+
   'left join zcf_paramGerais Par on Par.uo = A.TipoAvaria  and par.nm_Param = ''avarias.tpOrigem''  '+#13+
   'where a.data between ' + funcDatas.dateToSqlDate(datai) +' and '+ funcDatas.dateToSqlDate(dataf) +#13;

   if (uo <> '') then
   cmd :=  cmd + ' and I.loja = ' + uo;

   cmd := cmd +   ' group by UO.is_uo, UO.ds_uo, P.cd_pes, F.nm_fantasi, A.tipoAvaria, Par.Valor ' +
                  ' order by UO.is_uo, F.nm_fantasi, PAR.valor';

    funcsql.execSQL(cmd, fmMain.Conexao);

    tb.close();
    tb.Open();
end;

procedure calculaTotaisAvariasPorLoja(var tb:TADOTable; lojas:TadLabelComboBox; datai, dataf:Tdate);
var
  uo, cmd:String;
begin

    criaTabelaDosTotaisDeAvarias(tb);

    uo := fmMain.getCodUO(lojas);

    cmd := ' insert ' + tb.TableName +
    ' select A.loja, UO.ds_uo,  P.valor as TipoAvaria, ' +#13+
    'sum(i.quant) as qtItens, ' +#13+
    'sum(i.quant*I.pco) as [valorCusto Total], '+#13+
    'sum(i.quant*I.pcoVarejo) as [valorVenda Total], '+#13+
    'totalVenda = ( select isNull(sum(qt*und),0) as valorVenda from zcf_avariasDescontos D (nolock) where D.is_uo = A.loja and data between ' + funcDatas.dateToSqlDate(datai) +' and '+ funcDatas.dateToSqlDate(dataf) + '), '+#13+
    ' '''' as fornecedor ' + #13+
    'from zcf_avariasitens I (nolock) '+#13+
    'inner join zcf_avarias A (nolock) on i.numAvaria = A.numAvaria and I.loja = A.loja and a.ehAtiva = 1 ' +#13+
    'inner join zcf_tbuo UO (nolock) on UO.is_uo = A.loja ' +#13+
    'left join zcf_paramGerais P (noLock) on P.nm_Param = ''avarias.tpOrigem'' and A.tipoAvaria = p.uo ' +#13+
    'where a.data between ' + funcDatas.dateToSqlDate(datai) +' and '+ funcDatas.dateToSqlDate(dataf) +#13;

    if (uo <> '' )then
      cmd := cmd + ' and A.Loja = ' + uo;

    cmd := cmd +
    'group by '+
    'A.loja,  A.TipoAvaria, p.valor, UO.ds_uo ' +

    'order by A.loja, P.valor ' ;

    funcsql.execSQL(cmd, fmMain.Conexao);
    tb.Close();
    tb.Open();
end;


function recalcularCmuItem(is_ref:String):String;
var
   cmd:String;
   ds:TdataSet;
begin
// Obtm a lista de todas as entradas do produto e calcula o custo do produto.
   cmd := 'select dnota.is_nota, '+
          '(( dnota.vl_dspextra * ((dmovi.vl_item * 100) /  dnota.vl_nota) /100) / dmovi.qt_mov ) as [ValorExtraPorUnidade], '+
          ' pr_tabela + (ValorIPI/qt_mov) - (valorIcms/qt_mov) +  (( dnota.vl_dspextra * ((dmovi.vl_item * 100) /  dnota.vl_nota) /100) / dmovi.qt_mov ) as [custoMaisDespaExtra] '+
          'from dmovi ' +
          'inner join dnota on dmovi.is_nota = dnota.is_nota '+
          'inner join toper on dnota.is_oper = toper.is_oper '+
          'where dmovi.is_ref = ' + is_ref +
          'and toper.codTransacao = 1 ';
   ds := funcSQL.getDataSetQ(cmd, fmMain.Conexao);

   cmd := funcSQL.getMediaDeUmaColuna(fmMain.Conexao, ds,'custoMaisDespaExtra');

   ds.Destroy();
   result := cmd;
end;

function getItensDeUmaNota(isNota:String):TDataSet;
var
   cmd:String;
begin
   cmd := 'Select dmovi.is_ref, crefe.cd_ref, crefe.ds_ref, crefe.ncm_sh from dmovi (nolock)'+
          'inner join crefe (nolock) '+
          'on dmovi.is_Ref = crefe.is_ref where dmovi.is_Nota = ' + isNota;
   result := funcSql.getDataSetQ( cmd, fmMain.Conexao);
end;

function getItensParaCadastroNCM(var tabela:TADOTable; isNota:String):boolean;
var
  ds:TdataSet;
begin
   ds:= getItensDeUmaNota(isNota);
   ds.First();
   while (ds.Eof = false) do
   begin
      tabela.AppendRecord([
                           ds.FieldByName('is_ref').asString,
                           ds.FieldByName('cd_ref').asString,
                           ds.FieldByName('ds_ref').asString,
                           ds.FieldByName('ncm_sh').asString
                         ]);
      ds.Next();
   end;
   ds.Destroy();
end;

function ajustaCodigoNCM(isRef, ncm_sh:String):boolean;
begin
   result := executeSQLint( 'update crefe set NCM_SH = ' + ncm_sh + ' where is_ref = ' + isRef, fmMain.Conexao) > 0 ;
end;


function getDadosNota(isNota, is_uo, sr_docf, nr_docf:String):TADOQuery;
var
   cmd :String;
   qr:TADOQuery;
begin
   cmd :=
   ' select case when topi.fl_entrada=1 then ''Entrada'' else ''Saida'' end as Tipo, ' +
   ' case when dnota.st_nf=''C'' then ''Cancelada'' else ''Normal'' end as Situacao, ' +
   ' dnota.is_nota, '+
   ' dnota.sr_docf as Serie, dnota.nr_docf Num, dnota.cd_cfo, dnota.dt_entsai as [Entrada/Saida], ' +
   ' dnota.VL_DSPEXTRA, dnota.cd_pes, dspes.nm_pes [Emissor/Destino] , vl_nota as Valor, ' +
   ' dnota.codigo_nfe, ' +
   ' zcf_tbuo.ds_uo as Loja, ' +
   ' dnota.dt_emis, dnota.is_estoque, dnota.st_nf, dnota.observacao, topi.sq_opf, ' +
   ' dnota.codigo_nfe, ' +
   ' nf_eletronica.chave_acesso_nfe'+
   ' from dnota (nolock) ' +
   ' inner join toper (nolock) on dnota.is_oper = toper.is_oper ' +
   ' inner join topi (nolock) on toper.sq_opf = topi.sq_opf ' +
   ' inner join dspes (nolock) on dnota.cd_pes = dspes.cd_pes ' +
   ' inner join zcf_tbuo (nolock) on dnota.is_estoque = zcf_tbuo.is_uo ' +
   ' left  join nf_eletronica on dnota.codigo_nfe = nf_eletronica.codigo_nfe' +
   ' where ' ;

   if ( isNota <> '') then
      cmd := cmd + ' is_nota = ' + isNota

   else
   begin
      cmd := cmd + ' dnota.sr_docf = '+ quotedStr(sr_docf) + ' and nr_docf = ' + nr_docf ;

      if (is_uo <> '') then
         cmd := cmd + ' and is_estoque = ' + is_uo;
   end;
   qr := TADOQuery.Create(nil);
   funcsql.getQuery(fmMain.Conexao, qr, cmd);
   result := qr;
end;


function getDadosPessoa(cd_pes, nm_pes:String):TDataSet;
var
   cmd:String;
begin
   if (cd_pes = '') then
      cmd := 'Select is_cred, cd_pes as codigo, nm_razsoc as fornecedor from dscre where  nm_razsoc like ' + quotedstr( nm_pes +'%')
   else
      cmd := 'Select is_cred, cd_pes as codigo, nm_razsoc as fornecedor from dscre where  is_cred = ' +  cd_pes + ' or cd_pes = ' + cd_pes;
   result := funcSQL.getDataSetQ(CMD, fmMain.Conexao);
end;


function getFmDadosPessoa(codPerfil: char):String;
begin
   Application.CreateForm(TfmListaFornecedores, fmListaFornecedores);
   fmListaFornecedores.setPerfil(codPerfil);
   fmListaFornecedores.ShowModal;

   if (fmListaFornecedores.ModalResult = mrOk) then
      result := fmListaFornecedores.dsPes.DataSet.fieldByName('codigo').asString
   else
      result := '';
end;


function getDadosPedidoDeCompra(conexao: TADOconnection; numPedido:String):TdataSet;
var
  cmd:String;
begin
   cmd :=' select prod.is_ref, Prod.cd_ref as CODIGO, Prod.ds_ref AS DESCRICAO, CAST ( item.qt_ped as int) as QUANT, item.pr_uni AS UND, item.pc_ipi AS IPI' +
         ' from crefe prod (NOLOCK), dsipe item (NOLOCK) where prod.is_ref = item.is_ref'+
         ' and item.is_pedf = '+ quotedStr(numPedido);
   funcSQL.getDataSetQ(cmd, fmMain.Conexao);
   result := funcSQL.getDataSetQ(cmd, fmMain.Conexao);
end;


procedure getCRUCBaseNota(conexao:TADOConnection; var query:TADOquery; is_ref:String);
var
   cmd:String;
begin
   cmd :=
   ' begin ' +#13+
   ' declare @is_oper int' +#13+
   ' set @is_oper = ' +
   ' isnull( (select top 01 is_oper from zcf_dsdei where is_ref = ' +is_ref+ ' and codTransacao = 1 AND DT_MOV <' + funcDatas.dateToSqlDate('01/01/2011') + ' order by dt_mov desc ),0)' +
   ' select ' + #13+
   ' dnota.sr_docf as Serie' +#13+
   ' ,dnota.nr_docf as Nota' +#13+
   ' ,tbuo.ds_uo as Loja' +#13+
   ' , ceiling( (dnota.VL_DSPEXTRA / (dnota.VL_DSPEXTRA + dnota.vl_tot)) * 100) as [% extra nota]' +#13+
   ' ,dmovi.pr_tabela  as [Vl de Nota]'+#13+
   ' ,dmovi.PC_IPI as [% IPI]'+#13+
   ' ,(dmovi.pR_TABELA * (PC_IPI/100)) as [(+) Vl IPI]'+#13+
   ' ,dmovi.Pc_icm as[ %ICMS]'+#13+
   ' ,(dmovi.pR_TABELA * (PC_ICM/100)) as [(-) Vl ICMS]'+#13+
   ' , dmovi.pr_tabela / (1 - (dnota.VL_DSPEXTRA / (dnota.VL_DSPEXTRA + dnota.vl_tot))) + (dmovi.pR_TABELA * (PC_IPI/100))  as [Custo +IPI]' +#13+
   ' , dmovi.pr_tabela / (1 - (dnota.VL_DSPEXTRA / (dnota.VL_DSPEXTRA + dnota.vl_tot))) + (dmovi.pR_TABELA * (PC_IPI/100)) - (dmovi.pR_TABELA * (PC_ICM/100))  as [Custo +IPI -ICMS]' +#13+
   ' from dnota (nolock)' +#13+
   ' inner join dmovi (nolock) on dnota.is_nota = dmovi.is_nota'+#13+
   ' left join zcf_tbuo tbuo on dnota.is_estoque = tbuo.is_uo'+#13+
   ' where'+#13+
   '     dnota.is_oper = @is_oper'+#13+
   ' and dmovi.is_ref = ' + is_ref + ' end';
   funcsql.getQuery(conexao, query, cmd);
end;
}
end.
