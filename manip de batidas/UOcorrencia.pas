unit UOcorrencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Grids, Buttons,funcoes, DB, ADODB, DBGrids,
  TFlatCheckBoxUnit, ExtCtrls;
type
  TFmOcorrencia = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    cbLojas: TComboBox;
    Edit1: TEdit;
    cb1: TComboBox;
    sg1: TStringGrid;
    BitBtn2: TBitBtn;
    GroupBox3: TGroupBox;
    dtf: TDateTimePicker;
    dti: TDateTimePicker;
    Label1: TLabel;
    Memo1: TMemo;
    Connection: TADOConnection;
    qJustificativa: TADOQuery;
    GroupBox4: TGroupBox;
    Flatbatidas: TFlatCheckBox;
    FlatFaltas: TFlatCheckBox;
    FlatAtrasos: TFlatCheckBox;
    chBox: TFlatCheckBox;
    Panel1: TPanel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbLojasChange(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure CalcOcorrenciaLoja(sender:TObject);
    procedure CalcOcorrenciaEmpregado(sender:TObject);
    procedure FormCreate(Sender: TObject);
    procedure LimparStringGrid(sender: Tobject);
    procedure PreparaParaReceberBatidas(sender:TObject);
    procedure CapturaBatidas(Sender:Tobject);
    procedure Edit1Change(Sender: TObject);
    function ConectarAoBd(sender:Tobject;Bd:string):boolean;
    procedure verOcorQtBatIncompativel(Sender:Tobject);
    procedure verOcorFaltas(Sender:Tobject);
    procedure verOcorAtrasos(Sender:Tobject);
    procedure insereNomeEmpregadoNaOcorrencia(sender:Tobject);
    procedure InsereJustificativaNaOcorrencia(sender:Tobject);
    function  ehJustificadoNaEmpresa(sender: Tobject; Mat, data,ocorrencia, bd: string;MostraJus:smallint): boolean;
    function  ehJustificado(sender: Tobject; Mat, data, ocorrencia: string;MostraJus:smallint): boolean;
    function  EhFeriado(sender:TObject; data:String):boolean;
    function  calculaAtraso(Sender:TObject; batida,data,horarios:String):integer;
    function  FormatoDahora(x:integer):String;
    function verHorarioPrevisto(data:string):string;
    procedure ImprimirOcorrencias(sender:TObject);
    procedure FlatbatidasClick(Sender: TObject);
//    procedure mostraPainel(mensagem:string;tsleep:integer);
    procedure mostraPainel(mensagem: string; tsleep:integer;EmpAtual,Total:integer);

    function intToHora(x:integer):String;
    function HoraToInt(hora:string):integer;
    procedure BitBtn1Click(Sender: TObject);
    procedure Memo1Click(Sender: TObject);
    function  NomedoDia(diasem:string):string;
    function  carregaCbox(edit3:string):integer;
    procedure selecionaBatidasDoDia(sender:Tobject; Dia:string; Batidas: TStringList; indice:smallInt);
    function  DataRegistroEmpregado(Mat,bd:string):TDateTime;
    function  EstaAtivo(sender:Tobject; mat,data:string):boolean;
    procedure FormShow(Sender: TObject);

    { Private declarations }
  public
    { Public declarations }
  end;
const
{
   WALTER FREIRE DE CARVALHO         00010830      080008000800080008000800     00010830102
}

   BATVAZIA = '  :  ';
   pos_HorarioI = 49;
   pos_HorarioT = 24;
   pos_Bd_I = 86;  // posicao de define o bd
   pos_Bd_T = 01;
var
  FmOcorrencia: TFmOcorrencia;
  OpenDialog: TOpenDialog;
  naoBuscaArqBatidas:boolean;
  arqBatidas:string;
  Oco_nome:boolean;
  PortaImpressao:string;
implementation

uses UmanBat;

{$R *.dfm}

function TfmOcorrencia.NomedoDia(diasem:string):string;
var
  ADate: TDateTime;
  days: array[1..7] of string;
begin
  days[1] := 'DOM';
  days[2] := 'SEG';
  days[3] := 'TER';
  days[4] := 'QUA';
  days[5] := 'QUI';
  days[6] := 'SEX';
  days[7] := 'SAB';
  ADate := StrToDate(diasem);
  NomeDoDia:=(days[DayOfWeek(ADate)]);
end;

function TFmOcorrencia.HoraToInt(hora: string): integer;
begin //
   if hora <> '    'then
      result := (StrToInt(copy(hora,01,02)) * 60 )+ ( StrToInt(copy(hora,04,02))  )
   else
      result := 480;
end;

function TFmOcorrencia.intToHora(x:integer):String;
var
   aux,h, m :String;
begin
   h := inttoStr( x div 60 );
   m := IntToStr( x mod 60 );
   if length(h) < 2 then insert('0',h,1);
   if length(m) < 2 then insert('0',m,1);
   aux := h +':'+ m;
   if aux = '00:00' then
      aux := '  :  ' ;
   result := aux;
end;


procedure TFmOcorrencia.mostraPainel(mensagem: string; tsleep:integer;EmpAtual,Total:integer);
var
   aux:string;
begin
   panel1.Visible := true;

   aux:='';
   if total > 0 then
     aux := inttostr(empAtual) + ' de ' + inttostr(total);

   label2.caption:= aux +' - '+ copy(cb1.items[cb1.itemindex],01,30) + mensagem;
   panel1.refresh;
   fmOcorrencia.Refresh;
   sleep(tsleep);
end;



function TFmOcorrencia.FormatoDahora(x:integer):String;
var
   aux,h, m :String;
begin
   h := inttoStr( x div 60 );
   m := IntToStr( x mod 60 );
   if length(h) < 2 then insert('0',h,1);
   if length(m) < 2 then insert('0',m,1);
   aux := h +':'+ m;
   if aux = '00:00' then
      aux := '  :  ' ;
   FormatoDaHora := aux;
end;

function TFmOcorrencia.verHorarioPrevisto(data: string): string;
var
  Adate: Tdatetime;
  pos:integer;
begin
   pos:=0;
   adate := StrToDate(data);
   case DayOfWeek(ADate) of
      2: pos:= 01;  3: pos:= 05;  4: pos:= 09;
      5: pos:= 13;  6: pos:= 17;  7: pos:= 21;
      1: pos:= 21;
   end;
   pos := pos + pos_HorarioI-1;

   if copy(fmocorrencia.cb1.items[fmocorrencia.cb1.itemindex],pos,04) <> '    ' then
       verHorarioPrevisto := copy(fmocorrencia.cb1.items[fmocorrencia.cb1.itemindex],pos,02) + ':' + copy(fmocorrencia.cb1.items[fmocorrencia.cb1.itemindex],pos+2,02)
   else
       verHorarioPrevisto := '00:00';
end;

function TFmOcorrencia.calculaAtraso(Sender:TObject; batida,data,horarios:String):integer;
var
  dif,  Prev, h, m :integer;
begin
   prev := 0;
   dif :=0;

   if verHorarioPrevisto(data)  <> '    ' then
      prev := HoraToint(verHorarioPrevisto(data))
   else
     result := 0 ;
   if batida  <> '  :  ' then
   begin
      h := StrToInt( copy(batida, 01, 02) );
      m := StrToInt( copy(batida, 04, 02) );

      if ( (h * 60) + m  ) > prev then
      begin
         dif :=  ( (h *60) + m  ) - prev  ;
         result := dif ;
      end;
   end
   else
     result := dif;
end;


procedure TFmOcorrencia.InsereNomeEmpregadoNaocorrencia(sender: Tobject);
begin
   if oco_nome = false then
   begin
      oco_nome := true;
      memo1.Lines.Add('Empregado: '+ copy(cb1.Items[cb1.ItemIndex],01,30));
   end;
end;

function TFmOcorrencia.EhFeriado(sender: TObject; data: String): boolean;
var
  Query:TADOQuery;
begin
   query := TADOQuery.Create(qjustificativa);
   query.Connection := connection;
   query.SQL.Add('Select * from feriados where FER_DATA = ' +  funcoes.StrToSqlDate(data) );
   query.open;

   if query.isEmpty = true then
     result := false
   else
     result := true;
   query.destroy;
end;

procedure TFmOcorrencia.InsereJustificativaNaOcorrencia(sender: Tobject);
begin
{   memo1.Lines.Add('      Justificativa: '+ funcoes.preencheCampo(30,' ','d', copy(qjustificativa.fieldByName('opc_descricao').AsString,01,30) )+
                   ' Data: '+ DateToStr(qjustificativa.fieldByName('jus_datahora').AsDateTime) + ' Loja: ' + qjustificativa.fieldByName('jus_usuario').AsString);
   memo1.Lines.Add('      Observa��o: '+ qjustificativa.fieldByName('jus_observacao').asString );
   memo1.Lines.Add('');
}
end;

function TFmOcorrencia.ehJustificadoNaEmpresa(sender: Tobject; Mat, data,ocorrencia, bd: string;MostraJus:smallint): boolean;
var
  aux:string;
begin
   ConectarAoBd(sender,bd);
   qjustificativa.Connection := connection;
   aux:='';
   qjustificativa.SQL.Clear;
   aux:='Exec Z_CF_VerificarJustificativas ' + quotedStr(Mat) +', '+ funcoes.StrToSqlDate(data) +','+ quotedStr(ocorrencia);
   qjustificativa.SQl.add(aux);

   qjustificativa.Open;

   if qjustificativa.IsEmpty = false then
   begin
      if mostraJus = 1 then
      begin
          memo1.Lines.Add('      Justificativa: '+ funcoes.preencheCampo(30,' ','d', copy(qjustificativa.fieldByName('opc_descricao').AsString,01,30) )+                   ' Data: '+ DateToStr(qjustificativa.fieldByName('jus_datahora').AsDateTime) + ' Loja: ' + qjustificativa.fieldByName('jus_usuario').AsString);
          memo1.Lines.Add('      Observa��o: '+ qjustificativa.fieldByName('jus_observacao').asString );
          memo1.Lines.Add('');
      end;
      result := true;
   end;
end;

function TFmOcorrencia.ehJustificado(sender: Tobject; Mat, data, ocorrencia: string;MostraJus:smallint): boolean;
begin
   if  (  ehJustificadoNaEmpresa(sender,mat,data,ocorrencia,'1',MostraJus) = false) and ( ehJustificadoNaEmpresa(sender,mat,data,ocorrencia,'2',MostraJus) = false) then
      result := false
   else
      result := true;
end;

procedure TFmOcorrencia.VerOcorQtBatIncompativel(Sender: Tobject);
var
  i:smallint;
begin
   for i := 1 to sg1.RowCount -1 do
   begin
      if ( ( sg1.Cells[1,i] = '  :  ' ) and ( sg1.Cells[2,i] <> '  :  ' )  ) or ( ( sg1.Cells[2,i] = '  :  ' ) and ( sg1.Cells[1,i] <> '  :  ' )  )   then
      begin
         if  pos ('DOM', sg1.Cells[0,i]) = 0  then
         begin
            if ( ehJustificado(sender, copy(cb1.items[cb1.itemindex],78,08),  copy(sg1.Cells[0,i],01,10), 'E01',0) = false ) and ( EstaAtivo(sender, copy(cb1.items[cb1.itemindex],78,08), copy(sg1.Cells[0,i],01,10) ) = true ) then
            begin
               InsereNomeEmpregadoNaOcorrencia(sender);
               memo1.Lines.Add('   -- Dia: ' + sg1.Cells[0,i] + ' - Quantidade de batidas incompat�veis' );
               memo1.Lines.Add('           ' + 'Entrada: ' + sg1.Cells[1,i] + '      Saida: ' + sg1.Cells[2,i]);
               memo1.Lines.Add('          ');
            end
            else
            begin
               if chBox.Checked = true then
               begin
                  InsereNomeEmpregadoNaocorrencia(sender);
                  memo1.Lines.Add('   -- Dia: ' + sg1.Cells[0,i] + ' - Quantidade de batidas incompat�veis' );

                   // chama a verificacao das justificativas, e com o ultim parametro 1 manda incluir a justificativa NO MEMO
                  if ehJustificado(sender, copy(cb1.items[cb1.itemindex],78,08),  copy(sg1.Cells[0,i],01,10), 'E01',1) = true then
                     memo1.Lines.Add('          ');
                end;
            end;
          end;
      end;
   end;
end;


procedure TFMOcorrencia.verOcorAtrasos(Sender:Tobject);
var
  i:smallint;
begin
   for i := 1 to sg1.RowCount -1 do
   begin
      if  pos ('DOM', sg1.Cells[0,i]) = 0  then
      begin
         if calculaAtraso( sender, sg1.Cells[1,i], copy( sg1.Cells[0,i],01,10), copy(cb1.items[cb1.itemindex],49,24)) > 5 then
         begin
            if ( ehJustificado(sender, copy(cb1.items[cb1.itemindex],78,08),  copy(sg1.Cells[0,i],01,10), 'A02',0) = false) and ( EstaAtivo(sender, copy(cb1.items[cb1.itemindex],78,08), copy(sg1.Cells[0,i],01,10) ) = true ) then
            begin
               insereNomeEmpregadoNaocorrencia(sender);
               memo1.Lines.Add('   -- Dia: ' + sg1.Cells[0,i] + ' - Atraso na entrada.      Previsto: ' +  verHorarioPrevisto( copy(sg1.Cells[0,i],01,10) )+ '      Batida: ' + sg1.Cells[1,i]  );
               memo1.Lines.Add('          ');
            end
            else
            begin
               if chBox.Checked = true then
               begin
                   insereNomeEmpregadoNaocorrencia(sender);
                   memo1.Lines.Add('   -- Dia: ' + sg1.Cells[0,i] + ' - Atraso na entrada.      Previsto: ' +  verHorarioPrevisto(copy(sg1.Cells[0,i],01,10) )+ '      Batida: ' + sg1.Cells[1,i]  );

                  // chama a verificacao das justificativas, e com o ultim parametro 1 manda incluir a justificativa  NO MEMO
                  if ehJustificado(sender, copy(cb1.items[cb1.itemindex],78,08),  copy(sg1.Cells[0,i],01,10), 'A02',1) = true then
                     memo1.Lines.Add('          ');
                end;
            end;
         end;
      end;
   end;
end;

procedure TFmOcorrencia.verOcorFaltas(Sender: Tobject);
var
  i:smallint;
begin
   for i := 1 to sg1.RowCount -1 do
   begin
//      showmessage( ( sg1.Cells[1,i] = '  :  ' ) and ( sg1.Cells[2,i] = '  :  ' )
      if ( ( sg1.Cells[1,i] = '  :  ' ) and ( sg1.Cells[2,i] = '  :  ' )  )  and  (pos ('DOM', sg1.Cells[0,i]) = 0 ) and( EhFeriado(sender, copy(sg1.Cells[0,i],01,10)) = false ) and ( verHorarioPrevisto(copy(sg1.Cells[0,i],01,10)) <> '00:00' ) then
      begin
         if ( ehJustificado(sender, copy(cb1.items[cb1.itemindex],78,08),  copy(sg1.Cells[0,i],01,10), 'A01',0) = false )
         and (  EstaAtivo(sender, copy(cb1.items[cb1.itemindex],78,08), copy(sg1.Cells[0,i],01,10) ) = true ) then
         begin
            InsereNomeEmpregadoNaocorrencia(sender);
            memo1.Lines.Add('   -- Dia: ' + sg1.Cells[0,i] + ' - Falta ' );
            memo1.Lines.Add('          ');
         end
         else
         begin
            if chBox.Checked = true then
            begin
               InsereNomeEmpregadoNaOcorrencia(sender);
               memo1.Lines.Add('   -- Dia: ' + sg1.Cells[0,i] + ' -  Falta ' );
               // chama a verificacao das justificativas, e com o ultim parametro 1 manda incluir a justificativa  NO MEMO
               if ehJustificado(sender, copy(cb1.items[cb1.itemindex],78,08),  copy(sg1.Cells[0,i],01,10), 'A01',1) = true then
                  memo1.Lines.Add('          ');
            end;
         end;
      end;
   end;
end;

function TFmOcorrencia.ConectarAoBd(sender: Tobject;Bd:string): boolean;
var
  bco:string;
begin
   if bd = '1' then
      bco := 'Fluxus001'
   else
      bco := 'Fluxus002';
   if connection.Connected = true then
      connection.Connected := false;

   connection.ConnectionString := 'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=adm;Initial Catalog='+ bco +';Data Source=125.4.4.200;Workstation ID=' + funcoes.GetNomeDoMicro();
   try
     connection.Connected := true;
   except
      showMessage('N�o consigo Conectar ao Bd');
   end;
     result := connection.Connected;
end;

function TFmOcorrencia.carregaCbox(edit3:string):integer;
var
  i,j:integer;
begin
   j := -1 ;
   for i:=0 to cb1.Items.count do
      if pos(edit3,cb1.Items[i]) > 0 then
         j:=i;
   carregaCbox := j;
end;

procedure TFmOcorrencia.Edit1Change(Sender: TObject);
begin
  cb1.itemindex:= carregaCbox(edit1.text);
end;

procedure TFmOcorrencia.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   deletefile('Imprime.bat');
   deletefile('Impressao.txt');
   deletefile('ocorrenciaPonto.txt' );
   form2.show;
   action:=CaFree;

   funcoes.WParReg('ProgramasCF\ManipuladorBatidas','Calcula_dti', dateTostr(dti.Date ) );
   funcoes.WParReg('ProgramasCF\ManipuladorBatidas','Calcula_dtF', dateTostr(dtf.Date ) );
end;

procedure TFmOcorrencia.cbLojasChange(Sender: TObject);
begin
   if cbLojas.ItemIndex > 0 then
   begin
      edit1.text:='';
      cb1.itemIndex := -1;
   end;
end;

procedure TFmOcorrencia.FormCreate(Sender: TObject);
begin
//   PortaImpressao := form2.CBox2.Items[form2.cbox2.itemIndex];
//   cb1.Items := form2.cbox1.Items;
   dti.date := StrToDate('01/' + copy( dateTostr(dti.Date),04,07)) ;
   DTf.Date := now;
   Fmocorrencia.top := 01;
   Fmocorrencia.left := 100;

   if funcoes.RParReg('ProgramasCF\ManipuladorBatidas','Calcula_dtF') <> '' then
      dti.date := strToDate( funcoes.RParReg('ProgramasCF\ManipuladorBatidas','Calcula_dtI'));

   if funcoes.RParReg('ProgramasCF\ManipuladorBatidas','Calcula_dti') <> '' then
      dtf.date := strToDate( funcoes.RParReg('ProgramasCF\ManipuladorBatidas','Calcula_dtF'));
end;

procedure TFmOcorrencia.PreparaParaReceberBatidas(sender: TObject);
var
  i:SmallInt;
begin
   sg1.RowCount := 1;
   for i:=1 to 32 do // limpa  as batidas o stringGrid
   begin
       SG1.cells[1,i]:='  :  ';
       SG1.cells[2,i]:='  :  ';
       SG1.cells[3,i]:='  :  ';
       SG1.cells[4,i]:='  :  ';
       SG1.cells[5,i]:='';
   end;
// Na primeira coluna coloca o dia a dia
   for i:=0 to StrToInt(FloatToStr(dtf.date - dti.date)) do
   begin
       sg1.RowCount := sg1.RowCount+1;
       SG1.cells[0,i+1]:= DateToStr(dti.date + i)  + ' - ' +  form2.NomeDoDia( DateToStr(dti.date + i) );
       if length(SG1.cells[0,i+1]) < 6 then
          SG1.cells[0,i+1]:='0'+SG1.cells[0,i+1];
   end;
end;

procedure TFmOcorrencia.LimparStringGrid(sender: Tobject);
var
  i:SmallInt;
begin
   for i:=1 to 32 do // limpa  as batidas o stringGrid
   begin
       SG1.cells[0,i]:= '';
       SG1.cells[1,i]:='';// '  :  ';
       SG1.cells[2,i]:='';// '  :  ';
       SG1.cells[3,i]:='';// '  :  ';
       SG1.cells[4,i]:='';// '  :  ';
       SG1.cells[5,i]:='';
   end;
end;


procedure TFmOcorrencia.CapturaBatidas(Sender: Tobject);
var
  arq: textfile;
  {qd,}i,j{k} :integer;
  linha:string;
  bat: TStringList;
begin
   Bat:= TstringList.Create();
// inicio da leitura do arquivo de batidas
   assignFile(arq, arqbatidas );
   Reset(arq);
   While eof(arq) = false do
   begin
      readln(arq,linha);
      if copy(linha,21,08) = copy(cb1.items[cb1.itemindex],35,08) then
      begin
//         memo1.lines.Add(' Capturada Batida,  lendo arquivo de batidas, linha -  ' + linha+  '
         if ( StrToDate(copy(linha,01,10) ) >= dti.Date ) and ( StrToDate(copy(linha,01,10) ) <= dtf.Date )then
         begin
//             memo1.lines.Add('batda no intervalo calculado DATA INICIO: '+ DATETOSTR(dti.Date) + ' FIM: '+ dateTostr(dtf.date)  );
             bat.Add(linha);
         end;
       end;
    end;//fim da leitura dos registros
    CloseFile(arq);
    bat.Sort;
//    bat.SaveToFile('c:\BatidasDoperiodo.txt');

    for i:=1 to bat.Count-1 do
        for j:=i+1 to bat.Count-2 do
           if bat[i] = bat[j] then
              bat.Delete(j);

    for i:=1 to sg1.RowCount -1 do
    begin
//       showmessage( 'chamando a procedure para selecionar o dia ' + copy(sg1.Cells[0,i],01,10));
       selecionaBatidasDoDia(sender, copy(sg1.Cells[0,i],01,10), bat, i );
    end;
end;

procedure TFmOcorrencia.CalcOcorrenciaEmpregado(sender: TObject);
begin
   memo1.enabled := false;
   oco_nome:= false;
   limparStringGrid(sender);
   preparaParaReceberBatidas(sender);
   mostraPainel('Capturar Batidas',200,0,0);
   capturaBatidas(Sender);

   mostraPainel('Conectar ao BD',0,0,0);
   conectarAoBd(sender, copy(cb1.Items[cb1.itemIndex],86,01));

   if flatBatidas.Checked = true then
   begin
      mostraPainel('Verificando batidas incompat�veis',200,0,0);
      verOcorQtBatIncompativel(Sender);
   end;
   if flatFaltas.Checked = true then
   begin
      mostraPainel('Verificando faltas',200,0,0);
      verOcorFaltas(Sender);
   end;

   if flatAtrasos.Checked = true then
   begin
      mostraPainel('Verificando atrasos',200,0,0);
      verOcorAtrasos(Sender);
   end;

   panel1.Visible := false;

   memo1.enabled := true;
   if memo1.Lines.Count -1 < 1 then
      application.MessageBox('Nenhuma ocorr�ncia. ', pchar(''), mb_iconwarning + mb_ok)
end;


procedure TFmOcorrencia.CalcOcorrenciaLoja(sender: TObject);
var
  numEmpregados, NumEmpAtual, i:integer;
begin
   numEmpregados := 0;
   NumEmpAtual := 0;
   for i:=0 to cb1.Items.Count -1 do
     if copy(cb1.Items[i],87,02) = copy(cbLojas.Items[cbLojas.itemIndex],01,02) then
        NumEmpregados := numempregados +1;

   memo1.enabled := false;
   cb1.ItemIndex := 0 ;
   for i:=0 to cb1.Items.Count -1 do
   begin
      cb1.ItemIndex := i;
      oco_nome:= false;
      if copy(cb1.Items[cb1.ItemIndex],87,02) = copy(cbLojas.Items[cbLojas.itemIndex],01,02) then
      begin
         inc(NumEmpAtual);
         limparStringGrid(sender);
         preparaParaReceberBatidas(sender);
         mostraPainel(' Capturar Batidas',200, numEmpAtual, numEmpregados );
         capturaBatidas(Sender);
         mostraPainel('Conectar ao BD',200, numEmpAtual, numEmpregados );
         conectarAoBd(sender, copy(cb1.Items[cb1.itemIndex],86,01));

         if flatBatidas.Checked = true then
         begin
            mostraPainel('Verificar batidas incompat�veis',200, numEmpAtual, numEmpregados );
            verOcorQtBatIncompativel(Sender);
         end;

         if flatFaltas.Checked = true then
         begin
            mostraPainel('Verificar faltas. ',200, numEmpAtual, numEmpregados );
            verOcorFaltas(Sender);
         end;
         if flatAtrasos.Checked = true then
         begin
            mostraPainel('Verificar atrasos',200, numEmpAtual, numEmpregados );
            verOcorAtrasos(Sender);
         end;

         if Oco_nome = true then
            memo1.lines.Add('--------------------------------------------------------------------------------');
      end;
   end;
   panel1.Visible := false;
   if memo1.Lines.Count -1 < 1 then
      application.MessageBox('Nenhuma ocorr�ncia. ', pchar(''), mb_iconwarning + mb_ok);
   memo1.enabled := true;
end;

procedure TFmOcorrencia.BitBtn2Click(Sender: TObject);
var
   erro:string;
begin

   memo1.lines.Clear;

   if (dtf.Date - dti.Date) > 31 then
      erro := erro + '- Periodo maior que 31 dias ' + #13;

   if (dtf.Date < dti.Date) then
      erro := erro + '- A data final n�o pode ser menor que a inicial ' + #13;

   if (cbLojas.itemindex <= 0) and (cb1.ItemIndex < 0 ) then
      erro := erro + '- Nenhum empregado ou loja escolhido';

   if erro <> '' then
   begin
      application.MessageBox(pchar(erro), pchar(form2.Caption), mb_iconError + mb_OK);
   end
   else
   begin
      if naoBuscaArqBatidas = false then
      begin
         Opendialog := Topendialog.Create(Opendialog);
         with Opendialog do
         begin
            title := 'Informe o arquivo de batidas';
            filter := 'Arquivos de Texto|*.txt';
            initialDir := 'c:\';
         end;
         if OpenDialog.Execute then
            arqbatidas :=OpenDialog.FileName
         else
            arqbatidas :='';
      end;

      if arqbatidas <> '' then
      begin
         Screen.Cursor := crHourGlass;
         if cbLojas.ItemIndex <= 0 then
            CalcOcorrenciaEmpregado(sender)
         else
            CalcOcorrenciaLoja(sender);
         Screen.Cursor := CrDefault;
      end;
   end;
end;

procedure TFmOcorrencia.ImprimirOcorrencias(sender: TObject);
var
   origem, dest: textFile;
   linha:string;
   itemsPorPg,fl,l:integer;
begin
   memo1.lines.SaveToFile('ocorrenciaPonto.txt' );
   ItemsPorPg := 55;
   fl:=0; l := 0;
   assignFile( origem, 'ocorrenciaPonto.txt');
   Reset(origem);
   assignFile( dest, ExtractFilePath(ParamStr(0))+ 'Impressao.txt' );
   rewrite( dest );

   while eof( origem ) = false do
   begin
      inc(fl);
      writeln(dest,'                         CONSULTA A OCORRENCIAS     '  );
      if cbLojas.ItemIndex <= 0 then
         writeln(dest,'Tipo de consulta : Por empregado.'  )
      else
         writeln(dest,'Tipo de consulta : Por loja.'  );

      writeln(dest,'Data :' + DateToStr(now));
      writeln(dest,'Per�odo : '+ DateToStr(dti.date) + ' ate ' + dateToStr(dtf.date) );
      writeln(dest,'');
      writeln(dest,'------------------------------------------------------------------------------------------------------------------------');
      writeln(dest,'');

      while ( l < ItemsPorPg ) and ( eof(origem) = false ) do
      begin
         inc(l);
         readln(origem, linha);
         writeln(dest, linha);
      end;
      if  eof(origem) = false  then
      begin
         l := 0;
         writeln(dest,'------------------------------------------------------------------------------------------------------------------------');
         writeln(dest,'');
      end
      else
      begin
         while  l < ItemsPorPg do
         begin
            inc(l);
            writeln(dest, '');
         end;
         writeln(dest,'------------------------------------------------------------------------------------------------------------------------');
         writeln(dest,'');
      end;
   end;
   closeFile(origem);
   closeFile(Dest);

   Assignfile(origem, ExtractFilePath(ParamStr(0)) + 'Imprime.bat');
   rewrite(origem);
//   writeln(origem, 'cmd /c print /d:' + funcoes.lerParam(PortaImpressao,5) +' '+ ExtractFilePath(ParamStr(0))+ 'Impressao.txt' );
//   writeln(origem, 'cmd /c print /d:' + form2.Cbox2.Items[form2.Cbox2.ItemIndex] +' '+ ExtractFilePath(ParamStr(0))+ 'Impressao.txt' );
   closeFile(Origem);
   Winexec(pchar(ExtractFilePath(ParamStr(0))+'Imprime.bat'), sw_normal);
//   deletefile( ExtractFilePath(ParamStr(0)) + 'Imprime.bat');
end;

procedure TFmOcorrencia.FlatbatidasClick(Sender: TObject);
begin
  if (flatBatidas.Checked = false) and  (flatAtrasos.Checked = false) and  (flatFaltas.Checked = false) then
  begin
      application.MessageBox(pchar('Ao menos uma ocorr�ncia deve ser verificada'), pchar(form2.Caption), mb_iconError + mb_OK);
      flatBatidas.checked := true;
  end;
end;


procedure TFmOcorrencia.selecionaBatidasDoDia(sender: Tobject; Dia: string; Batidas: TStringList; indice:smallInt);
var
  BatDia:TstringList;
  i:integer;
begin
   batDia := Tstringlist.Create();
   for i:= 0 to batidas.count-1 do
   begin
      if copy(batidas[i],01,10) = dia then
      begin
         BatDia.Add(batidas[i]);
      end;
   end;

   if batDia.Count = 1 then
   begin
      if horatoInt(copy(BatDia[0],12,05)) <= HoraToInt(verHorarioPrevisto(copy(batDia[0],01,10))) + 240 then
         sg1.Cells[1, indice] := copy(BatDia[0],12,05)
      else
         sg1.Cells[2, indice] := copy(BatDia[0],12,05);
   end;
   if batDia.Count = 2 then
   begin
      sg1.Cells[1, indice] := copy(BatDia[0],12,05);
      sg1.Cells[2, indice] := copy(BatDia[1],12,05);
   end;
   if batDia.Count > 2 then
   begin
      sg1.Cells[1, indice] := copy(BatDia[0],12,05);
      sg1.Cells[2, indice] := copy(BatDia[BatDia.count-1],12,05);
   end;
   BatDia.Destroy();
end;

procedure TFmOcorrencia.BitBtn1Click(Sender: TObject);
begin
   if memo1.Lines.Count -1 > 1 then
      if application.MessageBox(' Deseja imprimir essas ocorr�ncia ? ', pchar(form2.caption), mb_YesNo + Mb_Iconquestion) = mrYes then
         ImprimirOcorrencias(sender);
end;

procedure TFmOcorrencia.Memo1Click(Sender: TObject);
begin
  edit1.setFocus;
end;

function TFmOcorrencia.DataRegistroEmpregado(Mat, bd: string): TDateTime;
var
   query:TAdoQuery;
begin
   Query := TadoQuery.Create(qjustificativa);
   query.Connection := Connection;
   query.SQL.Clear;

   query.sql.add('Select top 01 emp_dataAdmissao from empregados where emp_matricula = '+ QuotedStr(mat));
   query.open;
   Result := query.Fields[0].AsDateTime;
   Query.Destroy;
end;

function TFmOcorrencia.EstaAtivo(Sender:Tobject; mat, data: string): boolean;
var
   query:TAdoQuery;
   EhAtivo,EstaAfastado,EhDeFerias :boolean;

begin
   ConectarAoBd(sender, copy(cb1.Items[cb1.ItemIndex], pos_Bd_I, pos_Bd_T));

   Query := TadoQuery.Create(qjustificativa);

   query.Connection := Connection;
   query.SQL.Clear;
   query.sql.add(' Select top 01 emp_dataAdmissao from empregados where emp_matricula = '+ QuotedStr(mat) + ' and emp_status = ''1'' order by emp_dataAdmissao desc '  );
   query.open;
   EhAtivo := not(query.Fields[0].AsDateTime > StrToDate(data));

   query.SQL.Clear;
   query.sql.add(' Select afa_matricula from afastamentos where afa_matricula = ' + quotedStr(mat) + ' and '+ FUNCOES.StrToSqlDate(data) + ' >= afa_dataafastamento  and '+FUNCOES.StrToSqlDate(data) +' <= afa_dataretorno');
   query.open;
   EstaAfastado := NOT(query.IsEmpty);

   query.SQL.Clear;
   query.sql.add(' Select Rel_Matricula from Relatorios where Rel_Matricula = ' + quotedStr(mat) + ' and REL_GRUPO =''F�rias'' AND '+ FUNCOES.StrToSqlDate(data)+ ' >= REL_DATAREF1 AND  '+ FUNCOES.StrToSqlDate(data)+' <= REL_DATAREF2' );
   query.open;
   EhDeFerias := NOT(query.IsEmpty);


   if ( ehAtivo = false ) or ( EstaAfastado = true ) or (EhDeFerias = true )  then
      EstaAtivo := false
   else
      EstaAtivo := true;
   query.Destroy;
end;

procedure TFmOcorrencia.FormShow(Sender: TObject);
begin
   edit1.setfocus;
end;

end.
