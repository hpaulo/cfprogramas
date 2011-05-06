unit uPermissoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelComboBox, Menus,  Grids, DBGrids,
  SoftDBGrid, funcoes, funcsql, DB, ADODB, TFlatButtonUnit, ComCtrls,
  adLabelListBox, adLabelEdit, Buttons, fCtrls;

type
  TfmPermissoes = class(TForm)
    grid: TSoftDBGrid;
    tb: TADOTable;
    DataSource1: TDataSource;
    Tree: TTreeView;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    edUser: TadLabelEdit;
    btIncluiXML: TfsBitBtn;
    SoftDBGrid1: TSoftDBGrid;
    dsuser: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListarMenus(Sender: TObject;  item:TmenuItem);
    procedure gridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure gridDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function liberaMenu(lst:Tstringlist; tag:string):boolean;
    procedure CarregaMenu(menu:TMenu);
    procedure InsertNodeChild(menuItem:TMenuItem; noPai:TTreeNode);
    function getMenuName(Str:String):String;
    procedure TreeClick(Sender: TObject);
    procedure criarTabela();
    procedure inserirGruposNaTabela();
    procedure mostraPermissoes(cod:String);
    procedure btIncluiXMLClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPermissoes: TfmPermissoes;
  flagAlteracoes:Boolean;
  lista:TStringList;
  menuSelecionado:String;
implementation
uses uMain, uAvarias;
{$R *.dfm}

procedure TfmPermissoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   fmCadAvarias.Close();
   fmPermissoes := nil;
   action := caFree;
end;

procedure TfmPermissoes.ListarMenus(Sender: TObject;  item:TmenuItem);
var
   i:integer;
begin
   tb.Open;
   if item.Count > 0 then
   begin
      if item.parent = nil then
      begin
          tb.InsertRecord(['','',item.Caption,'']);
      end
      else
      begin
          tb.InsertRecord(['','',item.Caption,'']);
      end ;


      for i:=0 to item.Count -1 do
         ListarMenus(nil, item.Items[i]);
    end
    else
    begin
       if item.Tag <> 0 then
          tb.InsertRecord(['','x','',item.Caption, inttostr(item.Tag)]);
    end;
end;
{
procedure TfmPermissoes.chamaListaMenus(sender: TObject);
var
   i:integer;
begin
   grid.Visible := false;
   for i:=0 to fmMain.menuP.Items.Count -1 do
      ListarMenus(nil, fmMain.menuP.Items[i]);
   grid.Visible := true;
end;
}

procedure TfmPermissoes.gridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if Column.Field.FieldName = 'Menu' then
      column.Font.Style := [fsbold];

   if Column.Field.FieldName = 'Acessa' then
   begin
      column.Font.Style := [fsbold];
      Column.Font.Color := clred;
   end;
end;

procedure TfmPermissoes.gridDblClick(Sender: TObject);
begin
   if (tb.IsEmpty = false) then
   begin
      tb.Edit;
      if tb.FieldByName('Acessa').asString = 'X' then
         tb.FieldByName('Acessa').asString := ''
       else
          tb.FieldByName('Acessa').asString := 'X';
       tb.Post();

       flagAlteracoes := true;

       if ( tb.FieldByName('acessa').AsString = '' ) then
          funcsql.execSQL( 'Delete from zcf_telasPermitidas where codTela  =  ' +  menuSelecionado +' and grupo = ' + tb.FieldByName('codGrupo').AsString, fmMain.Conexao)
       else
          funcsql.execSQL( ' if not exists( select * from zcf_telasPermitidas where grupo = ' + tb.fieldByname('codGrupo').asString + ' and codTEla = ' + menuSelecionado  +')'+
                           ' insert zcf_telasPermitidas (codTela, grupo) values ( ' + menuSelecionado + ' , ' + tb.fieldByname('codGrupo').asString + ')', fmMain.Conexao  );
   end;                           
end;

function TfmPermissoes.liberaMenu(lst: Tstringlist; tag: string): boolean;
var
  i:integer;
  achou:boolean;
begin
   achou := false;
   for i:=0 to lst.Count-1 do
      if tag = lst[i] then
      begin
         achou := true;
         break;
      end;
    result := achou;
end;


procedure TfmPermissoes.InsertNodeChild( menuItem: TMenuItem; noPai: TTreeNode);
var
   i:integer;
   nodoFilho:TTreeNode;
begin
   for i:=0 to menuItem.Count-1 do
      if menuItem.Items[i].Count > 0 then
      begin
          nodoFilho := tree.Items.AddChild(noPai, getMenuName(menuItem.Items[i].Caption));
          InsertNodeChild(menuItem.Items[i], nodoFilho );
      end
      else
         lista.AddObject( intToStr( menuItem.Items[i].tag) ,  tree.Items.AddChild(noPai, getMenuName(  menuItem.Items[i].Caption) ) )
end;

procedure TfmPermissoes.carregaMenu(menu:TMenu);
var
  nod:TTreeNode;
begin
   nod := tree.Items.Add(nil,menu.Name);
   InsertNodeChild(menu.Items, nod);
end;



function TfmPermissoes.getMenuName(Str: String): String;
begin
   while pos('&',str) > 0 do
      delete(str, pos('&',str) , 1);
   result := str;
end;

procedure TfmPermissoes.mostraPermissoes(cod: String);
begin
   grid.Visible := false;
   tb.First;
   while tb.Eof = false do
   begin
      tb.Edit;
      if funcSQl.openSQL('Select grupo from zcf_telasPermitidas where codTela = ' + cod + ' and grupo = ' + tb.fieldByname('codGrupo').asString, 'grupo', fmMain.Conexao )<> '' then
        tb.FieldByName('Acessa').asString := 'X'
      else
        tb.FieldByName('Acessa').asString := '';
      tb.Post;
      tb.Next();
   end;
   grid.Visible := true;
end;


procedure TfmPermissoes.TreeClick(Sender: TObject);
begin
   if lista.IndexOfObject( tree.Selected ) > -1 then
   begin
      menuSelecionado := lista[lista.IndexOfObject(tree.Selected)];
      mostraPermissoes(menuSelecionado );
   end;
end;

procedure TfmPermissoes.criarTabela();
var
   cmd:String;
begin
   cmd := ' seq int primary key identity, Acessa varchar(02), Grupo varchar(50), codGrupo int ';
   funcsql.getTable( fmMain.Conexao, tb, cmd );
   DataSource1.DataSet := tb;
end;

procedure TfmPermissoes.inserirGruposNaTabela();
var
   cmd : String;
begin
   cmd := 'insert ' + tb.TableName + ' Select '''', nm_grusu, cd_grusu from dsgrusu order by nm_grusu';
   funcsql.execSQL(cmd,fmMain.Conexao);
   tb.Close();
   tb.open();

   grid.Fields[ tb.Fields.IndexOf( tb.fieldByname('seq') )  ].Visible := false;
   grid.Fields[ tb.Fields.IndexOf( tb.fieldByname('grupo') )  ].Visible := false;
end;


procedure TfmPermissoes.FormCreate(Sender: TObject);
begin
   criarTabela();
   inserirGruposNaTabela();
   lista := TStringList.Create();

// carrega o menu principal
   CarregaMenu(fmMain.menuPrincipal);


// inica o menu de avarias para aplicar as permissoes a ele
   Application.CreateForm( TfmCadAvarias  , fmCadAvarias);
   fmCadAvarias.Enabled := false;

   CarregaMenu(fmCadAvarias.menuAvarias);
end;



procedure TfmPermissoes.btIncluiXMLClick(Sender: TObject);
begin
   dsuser.DataSet := funcSql.getDataSetQ('select top 10  * from crefe', fmMain.Conexao);
end;

end.
