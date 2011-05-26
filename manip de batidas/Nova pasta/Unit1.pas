unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl;

type
  TForm1 = class(TForm)
    listFile: TFileListBox;
    Button1: TButton;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
   listFile.Directory := 'C:\_Ponto\Data';
end;

procedure TForm1.Button1Click(Sender: TObject);
var
   j, i:integer;
   saida, arq:tStringList;
begin
   screen.Cursor := crHourGlass;
   arq:= TStringlist.create();
   saida := TStringlist.create();
   for i:=0 to listFile.Items.Count -1 do
   begin
      listFile.ItemIndex := i ;
      arq.LoadFromFile(listFile.Items[listFile.ItemIndex]);

      for j:=0 to arq.Count -1 do
         if (pos(edit1.text, copy(arq[j],21,08))>0 ) then
            saida.Add(arq[j]);
   end;
   saida.Sort();
   saida.SaveToFile('c:\saida.txt');
   screen.Cursor := crDefault;
end;

end.
