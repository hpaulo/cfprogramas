unit uListaItensPorNota;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ADODB,
  TFlatButtonUnit, StdCtrls, adLabelEdit, adLabelComboBox,
  Dialogs, Buttons, Grids, DBGrids, SoftDBGrid, DB,
  fCtrls, ScktComp;

type
  TfmListaItensNota = class(TForm)
    cbLoja: TadLabelComboBox;
    edSerie: TadLabelEdit;
    edNNota: TadLabelEdit;
    btPesq: TFlatButton;
    grid: TSoftDBGrid;
    qrNota: TADOQuery;
    DataSource1: TDataSource;
    btOk: TfsBitBtn;
    fsBitBtn2: TfsBitBtn;
    procedure btPesqClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure getIsNota();
    procedure btOkClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmListaItensNota: TfmListaItensNota;

implementation

uses cf, funcoes, funcsql;

{$R *.dfm}

procedure TfmListaItensNota.FormCreate(Sender: TObject);
begin
   cf.getListaLojas(cbLoja, false, false, '');
end;

procedure TfmListaItensNota.getIsNota;
var
   i:integer;
begin
   qrNota := cf.getDadosNota('', funcoes.getCodUO(cbLoja), edSerie.Text, edNNota.Text );

   DataSource1.DataSet := qrNota;

   for i:=0 to grid.Columns.Count -1 do
      grid.Columns[i].Visible := false;

   grid.Columns[qrNota.FieldByname('dt_emis').Index].Visible := true;
   grid.Columns[qrNota.FieldByname('Serie').Index].Visible := true;
   grid.Columns[qrNota.FieldByname('Tipo').Index].Visible := true;
   grid.Columns[qrNota.FieldByname('Situacao').Index].Visible := true;
   grid.Columns[qrNota.FieldByname('Num').Index].Visible := true;
   grid.Columns[qrNota.FieldByname('Num').Index].Width := 50;
   grid.Columns[qrNota.FieldByname('Emissor/Destino').Index].Visible := true;
   grid.Columns[qrNota.FieldByname('Emissor/Destino').Index].Width := 150;
   grid.Columns[qrNota.FieldByname('Loja').Index].Visible := true;
   grid.Columns[qrNota.FieldByname('Valor').Index].Visible := true;
end;

procedure TfmListaItensNota.btPesqClick(Sender: TObject);
var
   erro:String;
begin
   erro := '';
   if (edSerie.Text = '') or (edNNota.text  = '') then
      erro := erro + ' - Preencha serie e numero da nota.'  +#13;
   if (erro <> '') then
   begin
      erro := '   Corrija antes esses erros     ' +#13 + erro;
      msgTela('',erro,MB_ICONERROR + mb_ok);
   end
   else
      getIsNota();
   edSerie.SetFocus();
end;

procedure TfmListaItensNota.btOkClick(Sender: TObject);
begin
  if (qrNota.IsEmpty = false) then
  begin
    fmListaItensNota.Caption := qrNota.FieldByname('is_nota').asString;
    btOk.ModalResult := mrOk;
    fmListaItensNota.ModalResult := mrOk
  end
  else
    fmListaItensNota.ModalResult := mrCancel;
end;

procedure TfmListaItensNota.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
   if (ModalResult = 2 ) then
   begin
      CanClose := false;

      if (edSerie.Text = '') then
        edSerie.setFocus()
      else if (edNNota.Text = '') then
        edNNota.setFocus()
      else
         btPesqClick(nil);
   end;
end;

procedure TfmListaItensNota.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   action := CaFree;
end;

end.
