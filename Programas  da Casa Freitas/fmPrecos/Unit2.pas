unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelEdit, Grids,funcoes, Buttons,Clipbrd, funcSQL,
  adLabelNumericEdit, mxExport, DB, ADODB, TFlatButtonUnit, DBGrids,
  SoftDBGrid, fCtrls;

type
  TForm2 = class(TForm)
    Edit1: TadLabelEdit;
    edit2: TadLabelNumericEdit;
    edit4: TadLabelNumericEdit;
    edit3: TadLabelNumericEdit;
    edIPI: TadLabelNumericEdit;
    FlatButton1: TFlatButton;
    FlatButton2: TFlatButton;
    FlatButton3: TFlatButton;
    FlatButton4: TFlatButton;
    Edit5: TadLabelNumericEdit;
    tbPedido: TADOTable;
    DataSource1: TDataSource;
    gdPedido: TSoftDBGrid;
    CheckBox1: TfsCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FlatButton1Click(Sender: TObject);
    procedure FlatButton2Click(Sender: TObject);
    procedure FlatButton3Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LimpaTabela(Sender:Tobject);
    procedure FlatButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Uprecoswell, uCadFornecedor, uMain;

{$R *.dfm}
function FloatSqlToStr(str:string):string;
begin
   if pos(',',str) = 0 then str := str +',00';
   if pos(',',str) = length(str)-1 then str:= str + '0';
   if pos(',',str) = 0 then str:= str + ',00';
   FloatSqlToStr := str;
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  nmTabela:String;
  i:smallint;
begin
   screen.Cursor := crHourglass;

   nmTabela := '#Pedido'+ funcoes.SohNumeros(timeToStr(now));
   funcSQL.GetValorWell( 'E',
                        'Create Table ' + nmTabela + ' ( is_ref int, CODIGO varchar(07), DESCRICAO varchar(30), QUANT int, [PRECO UND] money, IPI int ) ',
                        '@@error', fmMain.Conexao);

   tbPedido.TableName := nmTabela;
   tbPedido.Active := true;

   gdPedido.Columns[0].Visible := false;
   gdPedido.Columns[1].Width := 50;
   gdPedido.Columns[2].Width := 200;
   gdPedido.Columns[3].Width := 50;
   gdPedido.Columns[4].Width := 80;
   gdPedido.Columns[5].Width := 50;


   for i:=0 to tbPedido.FieldCount -1 do
     gdPedido.Columns[i].Title.Font.Style := [fsBold];

//   edit2.text := funcoes.lerParam( ARQ_INI ,10);
//   edit3.text := funcoes.lerParam( ARQ_INI ,11);
//   edit4.text := funcoes.lerParam( ARQ_INI ,12);
   screen.Cursor := crDefault;
end;

procedure TForm2.FlatButton3Click(Sender: TObject);
var
  i:integer;
  Query:TADoQuery;
begin
   query := TADOQuery.Create(form2);
   Query.Connection := fmMain.Conexao;

   query.SQL.clear;
   query.SQL.Add('select prod.is_ref, Prod.cd_ref as CODIGO, Prod.ds_ref AS DESCRICAO, CAST ( item.qt_ped as int) as QUANT, item.pr_uni AS UND, item.pc_ipi AS IPI ');
   query.SQL.Add('from crefe prod, dsipe item where prod.is_ref = item.is_ref');
   query.SQL.Add(' and item.is_pedf = '+ quotedStr(edit1.text) );
   query.Open;
   query.First;

   LimpaTabela(sender);
   while query.Eof = false do
   begin
      tbPedido.AppendRecord([
                            query.FieldByName('is_ref').AsString,
                            query.FieldByName('CODIGO').AsString,
                            query.FieldByName('DESCRICAO').AsString,
                            query.FieldByName('QUANT').AsString,
                            FloatToStr(query.FieldByName('UND').AsFloat) ,
                            query.FieldByName('IPI').AsString
      ]);
      query.Next;
   end;
end;

procedure TForm2.FlatButton1Click(Sender: TObject);
var
  i:integer;
  VlVenda,desconto,ipi,frete,margem01,margem02:real;
  arq:TstringList;
begin
   arq := tStringList.Create();

   tbPedido.First;
   while tbPedido.Eof = false do
   begin
      desconto :=  ( StrtoFloat(edit2.text)   * ( tbPedido.fieldByName('PRECO UND').asFloat ) / 100  );
      frete :=    ( ( StrtoFloat(edit3.text)  * ( tbPedido.fieldByName('PRECO UND').asFloat - desconto ) ) / 100  );
      ipi := ( ( tbPedido.FieldByName('IPI').asFloat )  * ( tbPedido.fieldByName('PRECO UND').asFloat - desconto ) ) / 100  ;

      margem01 :=   ( ( StrtoFloat(edit4.text)  * ( tbPedido.fieldByName('PRECO UND').asFloat - desconto ) ) / 100  );

      if StrtoFloat(edit5.text) <> 0 then
         margem02 :=   (  ( StrtoFloat(edit5.text) * margem01 ) - desconto )  / 100  ;

      VlVenda := ( tbPedido.fieldByName('PRECO UND').asFloat - desconto ) + frete + ipi + margem01 + margem02  ;

      FloatToStrF(vlvenda,ffFixed,18,02);

      arq.add( IntToStr(i+1)+ '- '+ tbPedido.fieldByName('codigo').AsString+' '+tbPedido.fieldByName('descricao').AsString );
      arq.add( '     PC Ped: ' + FloatToStrF( tbPedido.fieldByName('PRECO UND').asFloat ,ffFixed,18,02)  );
      arq.add( '     Desc: '+floatToStr(desconto) );
      arq.add( '     Frete: '+ floatToStr(frete) );
      arq.add( '     Margem01: '+ floatToStr(margem01) );
      arq.add( '     Margem02: '+ floatToStr(margem02) );
      arq.add( '     IPI: '+floatToStr(ipi)  );
      arq.add( '     PC Gerado: '+FloatToStrF(vlvenda,ffFixed,18,02));
      arq.add( '');

{      form1.Table.AppendRecord([
                                tbPedido.fieldByName('codigo').AsString,
                                tbPedido.fieldByName('DESCRICAO').AsString,
                                funcSQL.GetValorWell('O','Select dbo.funObterPrecoProduto('+ form1.getCodigoPreco+ ' , '+ tbPedido.FieldByname('is_ref').AsString+ ' , 10033586, 10033585    ) as pco ', 'pco', form1.Connection),
                                FloatToStrF(vlvenda,ffFixed,18,02),
                                form1.AjustaPreco( FloatToStrF(vlvenda,ffFixed,18,02) , '1,'+form1.EDIT4.TEXT ),
                                form1.AjustaPreco( FloatToStrF(vlvenda,ffFixed,18,02) , '1,'+form1.EDIT5.TEXT ),
                                tbPedido.fieldByName('is_ref').AsString,
                                tbPedido.fieldByName('PRECO UND').AsString
                               ]);
}      tbPedido.Next;
   end;

   if checkBox1.Checked = true then
   begin
      arq.SaveToFile(funcoes.getDirExe() + 'memDeCaculo.txt');
      Winexec(pchar('notepad.exe '+funcoes.getDirExe()+ 'memDeCaculo.txt'),sw_normal);
   end;
   FlatButton2Click(Sender);
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := cafree;
end;


procedure TForm2.FlatButton2Click(Sender: TObject);
begin
   form2.Close;
end;


procedure TForm2.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key = VK_return then
      FlatButton3Click(Sender);
end;


procedure TForm2.LimpaTabela(Sender: Tobject);
begin
   while tbPedido.IsEmpty = false do
      tbPedido.Delete;
end;

procedure TForm2.FlatButton4Click(Sender: TObject);
begin
   tbPedido.First;
   while tbPedido.Eof = false do
   begin
     tbPedido.Edit;
     tbPedido.FieldByName('ipi').asFloat := strToFloat(edIPI.text);
     tbPedido.Post;
     tbPedido.Next;
   end;
end;

end.
