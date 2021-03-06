unit uRRANA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRelGeral, DB, ADODB, StdCtrls, fCtrls, ComCtrls,
  TFlatButtonUnit, adLabelComboBox, adLabelEdit;

type
    TfmRelGeral1 = class(TfmRelGeral)
    edCodigo: TadLabelEdit;
    procedure FormCreate(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRelGeral1: TfmRelGeral1;

implementation

{$R *.dfm}
uses uMain, uCF, funcoes, funcDatas, funcSQL, cf;


procedure TfmRelGeral1.FormCreate(Sender: TObject);
begin
   inherited;
   cbCaixas.Visible := false;
   cbDetAvaForn.Visible := false;
   di.date := funcSQL.getDateBd(fmMain.Conexao);
   df.Date := di.Date;
end;

procedure TfmRelGeral1.btOkClick(Sender: TObject);
var
  dsItens:TdataSet;
  tbMov,tbItens:TADOTable;
  params, itens:TStringList;
begin
//  inherited;
  if ( length(edCodigo.Text) >= 3) then
  begin
     itens := TSTringlist.Create();
     tbItens := TADOTable.create(nil);
     tbItens.Connection := fmMain.Conexao;

     tbMov := TADOTable.create(nil);
     tbMov.Connection := fmMain.Conexao;
     dsItens:= cf.getIsrefPorFaixaCodigo(edCodigo.Text, '0','0', true);

     if (dsItens.IsEmpty = false) then
     begin
        while (dsItens.Eof = false) do
        begin
           itens.Add(dsItens.fieldByName('is_ref').AsString);
           dsItens.Next();
        end;
     end;
     dsItens.free();
     uCF.calculaRRANA( tbItens, tbMov, itens, funcoes.getCodUO(cbLojas), di.Date, df.Date);



    if (tbMov.IsEmpty = false) then
     begin
        Params:= TStringlist.create();
        params.Add(dateToStr(di.Date));
        params.Add(dateToStr(df.date));
        params.Add(funcoes.getNomeUO(cbLojas));
        params.Add(fmMain.getNomeUsuario()) ;

        fmMain.impressaoRaveQr4(tbItens, tbMov, nil, nil, 'rpRRANA', params )
     end
     else
        msgTela('','Sem movimenta��o no per�odo.', MB_ICONERROR + MB_OK);
     tbItens.Close();
     tbMov.Close();
  end;
end;

procedure TfmRelGeral1.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   inherited;
   action := CaFree;
   fmRelGeral1 := nil;
end;

end.
