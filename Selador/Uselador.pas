unit Uselador;

interface

uses
  SHELLAPI, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls,  Menus, ComCtrls,IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdFTP,funcoes;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    BitBtn3: TBitBtn;
    Edit5: TEdit;
    OpenDialog1: TOpenDialog;
    ComboBox1: TComboBox;
    Label5: TLabel;
    Label7: TLabel;
    CheckBox1: TCheckBox;
    Label3: TLabel;
    MainMenu1: TMainMenu;
    Editarosselos1: TMenuItem;
    edArqSelos: TEdit;
    lsSelosForm: TListBox;
    Edit7: TEdit;
    Label8: TLabel;
    lb2: TListBox;
    Edit8: TEdit;
    Label9: TLabel;
    EditarNumeracoes1: TMenuItem;
    ListBox1: TListBox;
    SaveDialog1: TSaveDialog;
    Selarporarquivo1: TMenuItem;
    lb3: TListBox;
    NMFTP1: TIdFTP;
    mmLog: TMemo;
    function  AjustaTam(tam,i:integer):string;
    function  EstaNoIntervalo(linha:string):boolean;
    procedure AlteraCPF(Sender: TObject);
    procedure Sela_NFVC(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure NMFTP1Error(Sender: TComponent; Errno: Word; Errmsg: String);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure SelarNf1_Formularios(sender:tobject);
    procedure SelarNf1_Normal(Sender: TObject);
    procedure Editarosselos1Click(Sender: TObject);
    procedure edArqSelosDblClick(Sender: TObject);
    procedure Edit5DblClick(Sender: TObject);
    procedure GravarNumSelosFormularios(sender:tobject;NumNota:string;DIfForm:integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtn2Click(Sender: TObject);
    procedure LimparCampos(sender:tobject);
    procedure EditarNumeracoes1Click(Sender: TObject);
    function  AjTamanho(Preenchimento:string;tam:integer;text:string):string;
    procedure Selarporarquivo1Click(Sender: TObject);
    function  TiraEspacos(Str:string):string;
    procedure Edit5Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LimpaCampos(Sender: TObject);
    procedure AjustaDadosReducao(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    function  insEspacoCol21(Str:String):String;
    procedure logar(Str:String);
    procedure ajustarCodDIBGE(arquivo:String);
    function isNotaDeEntrada(linha:String):boolean;
    function ajustaEmissorNotaEntrada(str:String):String;
    procedure ajustarEmissorNotaEntrada(arquivo:String);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
   TamNumLinha = 8;
   PATH = 'c:\sefaz-ce\';
   TITULO = '10.12.06 Selador ';
var
  Form1: TForm1;
  NumLinha:integer;
implementation
{$R *.DFM}

uses
 CadstroFormuarios, Unumeracao;

function TForm1.isNotaDeEntrada(linha: String): boolean;
begin
   // verifica se o cfo da nota � um dos cfos da String
   result := (pos( copy(linha, 24, 04), '1152, 2152, 1102, 2102, 2949, 2910, 2202') > 0)
end;

function TForm1.ajustaEmissorNotaEntrada(str: String): String;
begin
    delete(str,03,02);
    insert('02', str, 03);
    result := str;
end;



function TForm1.insEspacoCol21(Str: String): String;
begin
    while length(Str) < 292 do
       insert(' ', str,21);
    result := str;
end;

function tform1.TiraEspacos(Str:string):string;
begin
   while pos(' ',Str) > 0 do
      delete(Str, pos(' ',Str),01);
   TiraEspacos := Str;
end;

function tform1.AjTamanho(Preenchimento:string;tam:integer;text:string):string;
begin
   while length(text) < tam do
      insert(preenchimento,text,01);

   AjTamanho:= text;
end;

procedure TForm1.EditarNumeracoes1Click(Sender: TObject);
begin
  Application.CreateForm(tFnumeracao, Fnumeracao);
  Fnumeracao.show;
end;


function  tform1.EstaNoIntervalo(linha:string):boolean;
begin
   EstaNoIntervalo := false;
   logar('entrando no metodo de verficando nota: ' + linha);
   linha := funcoes.SohNumerosPositivos(linha);
   if (StrtoInt(linha) >= strToint(edit1.text)) and (StrtoInt(linha) <= strToint(edit3.text)) then
   begin
      EstaNoIntervalo := true;
   end;
   logar('saindo do metodo de verificar se esta no intervalo: ' + linha);
end;

function Tform1.AjustaTam(tam,i:integer):string;
var
   Str:string;
begin
   Str := IntToStr(i);
   while pos(' ',Str) > 0 do
      delete(Str, pos(' ',Str),01);

   while length(Str) < Tam do
      insert('0',Str,01);
   AjustaTam := Str;

end;

function TamArquivo(Arquivo: string): Integer;
begin
   with TFileStream.Create(Arquivo, fmOpenRead or fmShareExclusive) do
   try
      Result := Size;
   finally
      Free;
   end;
end;


procedure tform1.LimparCampos(sender:tobject);
begin
   edit1.text:='';
   edit2.text:='';
   edit3.text:='';
   edit4.text:='';
   edit7.text:='';
   edit8.text:='';
   edit1.setfocus;
end;


procedure TForm1.AlteraCPF(Sender: TObject);
var
   aux,linha:string;
   arq,arq2:textFile;
   auxPosicao:integer;
begin
    assignFile(arq,edit5.text);
    assignFile(arq2,PATH +'\sisif2.TXT');
    reset(arq);
    rewrite(arq2);

    while eof(arq) = false do
    begin
        readln(arq,linha);

/// retirar os numeros de selos negativcos
        aux := copy(linha,11,10);
        if pos ('-',aux) > 0 then
        begin
           aux := funcoes.SohNumerosPositivos(aux);
           aux := funcoes.preencheCampo(10,'0','e',aux);
           delete(linha,11,10);
           insert(aux,linha,11);
        end;



// retirar os selos ja existentes
        if copy(linha,01,04) = '6602' then
           readln(arq,linha);

// retirar os campos 'nf1'
        if pos('NF1',linha) > 0 then
        Begin
           auxPosicao := pos('NF1',linha);
           delete(linha, auxPosicao,03);
           Insert('   ',linha, auxPosicao  );
        end;


        
        if copy(linha,07,01) = '-' then
        begin
           delete(linha,07,01);
           insert(' ',linha,07);
        end;

        if (copy(linha,1,7) = '6203000') or (copy(linha,99,3) = '  0') then
        begin
           if copy(linha,1,7) = '6203000' then
           begin
              delete(linha,1,15);
              linha:='620314789632121' + linha;
           end;

           if copy(linha,99,3) = '  0' then
           begin
              delete(linha,99,02);
              insert('CE',linha,99);
           end;
        end;

        if copy (linha,1,3) = '200' then
        begin
           delete(linha,117,20);
           insert('00000000000000000000'{20 zeros},linha,117);
        end;

        if copy (linha,21,01) = '.' then
        begin
           while pos('.', linha) > 0 do delete(linha,pos('.', linha), 01);
           while pos('-', linha) > 0 do delete(linha,pos('-', linha), 01);
           while length(linha) < 300 do insert(' ',linha, 19);
        end;

        if copy (linha,27,01) = '-' then
        begin
           while pos('-', linha) > 0 do delete(linha,pos('-', linha), 01);
           while length(linha) < 300 do insert(' ',linha, 19);
        end;


        writeln(arq2,linha);

    end;
    CloseFile(arq);
    CloseFile(arq2);
    DeleteFile(edit5.text);
    renameFile(PATH+ 'sisif2.txt',edit5.text);
    DeleteFile(PATH+'sisif2.txt');
    listbox1.items.add ('Altera��o do CPF Feito!');
    form1.Refresh
end;
//*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*---*-*-*-*-*-
//*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*---*-*-*-*-*-
//*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*---*-*-*-*-*-
//*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*---*-*-*-*-*-
//*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*---*-*-*-*-*-
//*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*---*-*-*-*-*-

procedure TForm1.Sela_NFVC(Sender: TObject);
var
   arq2,arq:textFile;
   SeloForm,p4,serie,linha:string;

   Nlinha:integer;
   selar:boolean;

begin
    assignFile(arq,edit5.text);
    assignFile(arq2,PATH + 'sisif2.TXT');
    reset(arq);

    selar:=true;
    while eof(arq) = false do
    begin
       readln(arq,linha);
       if copy(linha,1,5)= '6601D' then
       begin
          selar:=false;
          break;
       end;
    end;
    CloseFile(arq);

    if selar = false then
    begin
       showmessage('O arquivo J� est� Selado para NFVC.');
    end
    else
    begin
       reset(arq);
       rewrite(arq2);
       Nlinha:=0;
       while eof(arq) = false do
       begin
           inc(Nlinha);
           readln(arq,linha);
           if (copy(linha,1,6) = '400302') or (copy(linha,1,7) = '400802D') then
           begin



              delete(linha,05,03);
              insert('02D',linha,05);

               Serie:= 'D';//copy(linha,7,1);
               SeloForm := copy(linha,13,10);
               delete(linha,293,8);
               p4:= IntToStr(Nlinha);
               while (length(p4) < 8) do insert('0',p4,1);
               insert(p4,linha,293);
               delete(linha,69,09);
               insert(edit8.text,linha,69);

               writeln(arq2,linha);

               readln(arq, linha);
               inc(Nlinha);
{               p4:= IntToStr(Nlinha);
               while (length(p4) < 8) do insert('0',p4,1);
               linha:='6601'+ serie + '     '+ seloform + p4;
}
               while length(linha) < 300 do insert(' ',linha,21);
               writeln(arq2,linha);

               inc(Nlinha);
               p4:= IntToStr(Nlinha);
               while (length(p4) < 8) do insert('0',p4,1);
               linha:='6604'+ '      '+ seloform + p4;
               while length(linha) < 300 do insert(' ',linha,21);
               writeln(arq2,linha);
           end
           else  if copy (linha,1,3)= '950' then
           begin
              p4:= IntToStr(Nlinha-2);
              while length(p4) < 8 do insert('0',p4,1);
              SeloForm:=IntToStr(nlinha);
              while length(SeloForm) < 8 do insert('0',seloform,1);
              linha:=copy(linha,1,13) + p4 + seloform;
              while length(linha) < 300 do insert(' ',linha,22);
              writeln(arq2,linha);
           end
           else if copy (linha,1,3) = '990' then
           begin
               p4:= IntToStr(Nlinha);
               while length(p4) < 8 do insert('0',p4,1);
               linha:= '9900'+ p4 + p4;
               while length(linha) < 300 do insert(' ',linha,13);
               writeln(arq2,linha);
           end
           else
           begin
              delete(linha,293,8);
              p4:= IntToStr(Nlinha);
              while length(p4) < 8 do insert('0',p4,1);
              insert(p4,linha,293);
              writeln(arq2,linha);
           end;
       end;
       closeFile(arq);
       closeFile(arq2);
       DeleteFile(edit5.text);
       renameFile(PATH + 'sisif2.txt',edit5.text);
       DeleteFile(PATH +'\Validador\sisif2.txt');
       edit1.setfocus;
       LimparCampos(sender);

       listbox1.items.add ('Selagem NFVC ');
       form1.Refresh
    end;
end;


procedure tform1.SelarNf1_Normal(Sender: TObject);
var
   arq,arq2:TextFile;
   p3, p4, linha,linha2:string;
   dif,Nlinha:integer;
   Nnota, nselo:integer;
begin
   logar('Inicio Selar NF1 blocos.' );
    assignFile(arq,edit5.text);
    assignFile(arq2,PATH+'sisif2.TXT');
    if edit2.text = '' then edit2.text := edit1.text;
    if edit4.text = '' then edit2.text := edit1.text;

    if checkbox1.Checked = false  then
       if (StrToInt(edit4.text) - StrToInt(edit3.text)) <> (StrToInt(edit2.text)-StrToInt(edit1.text)) then
       begin
          showmessage('A numera��o est� errada, verifique.')
       end
    else
    begin
       reset(arq);
       rewrite(arq2);

       Nlinha:=0;
       dif:=  Strtoint(edit2.text) - strToint(edit1.text);
       while eof(arq) = false do
       begin
          readln(arq,linha);
          if (copy(linha,1,6) = '400301') then // 4003 � ECF
          begin
             if (StrtoInt(copy(linha,13,10)) >= strToint(edit1.text)) and (StrtoInt(copy(linha,13,10)) <= strToint(edit3.text)) then
             begin
                Nnota:=StrToint(copy(linha,13,10));
                inc(Nlinha);
                delete(linha,293,8);
                p4:=IntToStr(Nlinha);
                while length (p4) <8 do insert('0',p4,1);
                insert(p4,linha,293);
                if copy(linha,24,4) = '6102' then
                begin
                   delete(linha,24,4);
                   insert('6108',linha,24);
                end;
                delete(linha,69,09);
                insert(edit8.text,linha,69);
                if copy(linha,07,01) = '-' then
                begin
                   delete(linha,07,01);
                   insert(' ',linha,07);
                end;

                writeln(arq2,linha);

                readln(arq,linha);
                inc(Nlinha);
                delete(linha,293,8);
                p4:=IntToStr(Nlinha);
                while length (p4) <8 do insert('0',p4,1);
                insert(p4,linha,293);
                writeln(arq2,linha);

                inc(Nlinha);
                Nselo:=  (nnota + dif);
                p4:=IntToStr(Nlinha);
                while length (p4) <8 do insert('0',p4,1);
                p3:=inttostr(nselo);
                while length (p3) < 10 do insert('0',p3,1);
                linha:='6601AC    '{4} + p3 + p4;
                while length(linha) < 300 do insert(' ',linha,21);
                writeln(arq2,linha);

                inc(Nlinha);
                p4:=IntToStr(Nlinha);
                while length (p4) <8 do insert('0',p4,1);
                p3:=inttostr(nnota);
                while length (p3) < 10 do insert('0',p3,1);
                linha:='6604      '{6} + p3 +p4;
                while length(linha) < 300 do insert(' ',linha,21);
                writeln(arq2,linha);

                readln(arq,linha);
                inc(Nlinha);
                delete(linha,293,8);
                p4:=IntToStr(Nlinha);
                while length (p4) <8 do insert('0',p4,1);
                insert(p4,linha,293);
                writeln(arq2,linha);
             end
             else
             begin
                inc(Nlinha);
                delete(linha,293,8);
                p4:=IntToStr(Nlinha);
                while length (p4) <8 do insert('0',p4,1);
                insert(p4,linha,293);
                writeln(arq2,linha);
             end
{4403}    end
          else if (copy(linha,1,6) = '400801') then  // 4008 documento cancelado
          begin
             if (StrtoInt(copy(linha,13,10)) >= strToint(edit1.text)) and (StrtoInt(copy(linha,13,10)) <= strToint(edit3.text)) then
             begin
                Nnota:=StrToint(copy(linha,13,10));
                inc(Nlinha);
                delete(linha,293,8);
                p4:=IntToStr(Nlinha);
                while length (p4) <8 do insert('0',p4,1);
                insert(p4,linha,293);
                writeln(arq2,linha);

                inc(Nlinha);
                Nselo:=  (nnota + dif);
                p4:=IntToStr(Nlinha);
                while length (p4) <8 do insert('0',p4,1);
                p3:=inttostr(nselo);
                while length (p3) <10 do insert('0',p3,1);
                linha:='6601AC    '{4} + p3 + p4;
                while length(linha) < 300 do insert(' ',linha,21);
                writeln(arq2,linha);

                inc(Nlinha);
                p4:=IntToStr(Nlinha);
                while length (p4) <8 do insert('0',p4,1);
                p3:=inttostr(nnota);
                while length (p3) < 10 do insert('0',p3,1);
                linha:='6602      '{6} + p3 +p4;
                while length(linha) < 300 do insert(' ',linha,21);
                writeln(arq2,linha);

                readln(arq,linha);
                inc(Nlinha);
                p4:=IntToStr(Nlinha);
                delete(linha,293,8);
                while length (p4) <8 do insert('0',p4,1);
                insert(p4,linha,293);
                writeln(arq2,linha);
             end
             else
             begin
                inc(Nlinha);
                delete(linha,293,8);
                p4:=IntToStr(Nlinha);
                while length (p4) <8 do insert('0',p4,1);
                insert(p4,linha,293);
                writeln(arq2,linha);
             end
{4408 }   end
          else if (copy(linha,1,3) = '950') then
          begin
             inc(Nlinha);
             linha2:=copy(linha,1,11);
             p3:=IntToStr(Nlinha-2);
             while length (p3) <10 do insert('0',p3,1);
             p4:=IntToStr(Nlinha);
             while length (p4) <8 do insert('0',p4,1);
             linha2:=linha2+p3+p4;
             while length (linha2) <300 do insert(' ',linha2,22);
             writeln(arq2,linha2);
{950}     end
          else if copy(linha,1,4) = '9900' then
          begin
             inc(Nlinha);
             p4:=IntToStr(Nlinha);
             while length (p4) <8 do insert('0',p4,1);
             linha:='9900'+p4+p4;
             while length (linha) <300 do insert(' ',linha,13);
             writeln(arq2,linha);
{9900}    end
          else
          begin
             Inc(Nlinha);
             delete(linha,293,8);
             p4:=inttostr(nlinha);
             while length(p4) <8 do insert('0',p4,1);
             insert(p4,linha,293);
             writeln(arq2,linha);
          end
       end; {while eof}
       closeFile(arq2);
       closeFile(arq);
       DeleteFile(edit5.text);
       renameFile(PATH+'SISIF2.txt',edit5.text);
       DeleteFile(PATH+'SISIF2.txt');
       LimparCampos(sender);
       listbox1.items.add('Selado NF/MR de ' + edit1.text + ' at� ' + edit3.text);
       form1.Refresh;
   end; {if a numeracao esta correta}
end;


procedure TForm1.BitBtn4Click(Sender: TObject);
begin
   if opendialog1.execute then
   begin
     edit5.text:=(opendialog1.filename);
     opendialog1.initialdir:= PATH+'Validador';
     bitbtn1.enabled:=true;
     bitbtn2.enabled:=true;
     bitbtn3.enabled:=true;

   end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
   form1.top := -1;
   form1.left := 400;
   bitbtn1.enabled:=false;
   bitbtn2.enabled:=false;
   bitbtn3.enabled:=false;
   combobox1.itemindex:=0;
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
    application.terminate;
end;


procedure TForm1.ComboBox1Change(Sender: TObject);
var
   linha:string;
begin
    screen.cursor :=crhourglass;
    linha:='SISIF'+combobox1.text+'.TXT';
    nmftp1.host:= funcoes.lerParam(ExtractFilePath(ParamStr(0)) +'Pselador.ini',00);
    nmftp1.port:= 21;
    nmftp1.userName:=funcoes.lerParam(ExtractFilePath(ParamStr(0)) +'Pselador.ini',01);
    nmftp1.password:=funcoes.lerParam(ExtractFilePath(ParamStr(0)) +'Pselador.ini',02);
    try
       nmftp1.connect;
    except
    on e:exception do
       if e.message <> ''then
          Showmessage('Erro '+ e.message);
    end;
    if nmftp1.Connected  then
    begin
       nmftp1.ChangeDir(funcoes.lerParam(ExtractFilePath(ParamStr(0)) +'Pselador.ini',03));  // <- DIRETORIO DO ARQUIVO
       nmftp1.get(linha,PATH+linha,true);
       nmftp1.Disconnect;
       messagebeep (MB_OK);
       edit5.text :=PATH+linha;
       bitbtn1.enabled := true;
       bitbtn2.enabled := true;
       bitbtn3.enabled := true;
    end;
    listbox1.items.clear;
    screen.cursor :=crdefault;
end;


procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
{  if key = vk_F1 then
  showmessage('o');
  if key = 13 then
  begin
     Perform (CM_DialogKey, VK_TAB, 0);
     key:=0;
  end;
  }
end;

procedure TForm1.NMFTP1Error(Sender: TComponent; Errno: Word;
  Errmsg: String);
begin
     showmessage('Erro '+ errmsg + ' Numero '+ FloatTostr(errno));
end;

procedure TForm1.Edit1Exit(Sender: TObject);
begin
   if edit2.Focused then
      edit2.text:= edit1.text;
end;

procedure TForm1.Edit3Exit(Sender: TObject);
begin
   if edit4.focused  then
      edit4.text:= edit3.text;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if checkbox1.Checked = true then
  begin
     edArqSelos.visible := true;
     label8.visible := true;
     edit7.visible := true;
  end
  else
  begin
     edArqSelos.visible := false;
     label8.visible := false;
     edit7.visible := false;
  end;
end;

function  TamLinha(tam:integer;str:string):string;
begin
   while length(str) < tam do
      insert('0',str,01);
   TamLinha := str;
end;


procedure TForm1.Editarosselos1Click(Sender: TObject);
begin
  Application.CreateForm(TForm2, Form2);
  form2.show;
end;

procedure TForm1.edArqSelosDblClick(Sender: TObject);
begin
   opendialog1.filename:='';
   opendialog1.initialdir :=PATH+'_Selos_de_formularios';
   opendialog1.Filter := 'Arquivos dos selos de formularios (.NOT)|*.not';
   opendialog1.title := 'Selecione o arquivo das numera��es de selos dos formularios.';
   if opendialog1.Execute then
   begin
      edArqSelos.text := opendialog1.FileName;
   end;
end;

procedure TForm1.Edit5DblClick(Sender: TObject);
begin
   opendialog1.Filter := 'Arquivos SISIF (SIS*.TXT) | SIS*';
   opendialog1.initialdir := PATH;
   if opendialog1.Execute then
   begin
      edit5.text := opendialog1.FileName;
       bitbtn1.enabled := true;
       bitbtn2.enabled := true;
       bitbtn3.enabled := true;
       listbox1.items.clear;       
   end;
end;

procedure  Tform1.GravarNumSelosFormularios(Sender: TObject;NumNota:string;DifForm:Integer);
var
   numForm, numAux,i:integer;
   linha:String;
begin
   for i:=0 to lsSelosForm.items.count -1 do
   begin
      numAux := StrToInt(funcoes.SohNumeros(copy(lsSelosForm.items[i],01,06)))  ;
      logar('peguei NumAux:');
      if StrToInt(NumNota) = numAux  then
      begin
         inc(NumLinha);
         linha := '6601AC    ' +   funcoes.preencheCampo(10,'0','e',  copy(lsSelosForm.items[i],11,09) );
         linha := insEspacoCol21(linha);
         lb2.items.add( linha + AjustaTam(08,NumLinha) );
         inc(NumLinha);
         numForm := StrToInt(copy(lsSelosForm.items[i],11,09)) - DifForm;
         if numForm < 0 then numForm := numForm * -1;
         Logar('DifForn: '   + copy(lsSelosForm.items[i],11,09) +'  ' + inttostr( DifForm ) );
         linha := '6602      ' +  AjustaTam(10, numForm );
         linha := insEspacoCol21(linha);
         lb2.items.add( linha + AjustaTam(08,NumLinha) );
     end;
   end;
end;


procedure tform1.SelarNf1_Formularios(Sender: TObject);
var
  origem:textFile;
  DifForm:integer;
  NumNota,linha:string;
  i:integer;
begin
   logar('Inicio Selar Formularios' );
   screen.Cursor :=crHourGlass;
   DifForm := StrToInt(edit2.text) - StrToInt(edit7.text);
   logar('Vari�vel DifFormulario: ' + intToStr(DifForm));

   NumLinha := 0;
   lsSelosForm.Items.loadfromFile(edArqSelos.text);
   lb2.items.clear;


   AssignFile(Origem,edit5.text);
   Reset(origem);
   while not(eof(origem)) do
   begin //1
      readln(origem,linha);
      inc(NumLinha);

// retirar os dados nf1 ou NF1
     i := pos('NF1',   uppercase(linha) );

     if ( i  > 0 ) then
     begin
        delete(linha,i,03);
        insert('   ',linha,i);
     end;

      if ( (copy(linha,1,6) = '400301') or (copy(linha,1,6) = '401137')  ) and (EstaNoIntervalo(copy(linha,13,10))) then
      begin //2
         NumNota := copy(linha,13,10);

         if copy(linha,07,01) = '-' then
         begin
            delete(linha,07,01);
            insert(' ',linha,07);
         end;

         delete (linha,67,11);
         insert('00'+edit8.text,linha,67); //aidf

         lb2.items.add( copy(linha,01,292) + AjustaTam(TamNumLinha,NumLinha));

         readln(origem,linha);
         inc(NumLinha);
         lb2.items.add( copy(linha,01,292) + AjustaTam(TamNumLinha,NumLinha));


         GravarNumSelosFormularios(sender,NumNota,DifForm);

// retirar o fomulario que o well grava no arquivo
         readln(origem,linha);

         inc(NumLinha);
         lb2.items.add( copy(linha,01,292) + AjustaTam(TamNumLinha,NumLinha));

      end; //2
      lb2.items.add( copy(linha,01,292) + AjustaTam(TamNumLinha,NumLinha));
   end;  //1
   CloseFile(origem);
   lb2.Items.SaveToFile(PATH + 'Saida.txt');

   DeleteFile(edit5.text);
   RenameFile(PATH + 'Saida.txt',edit5.text);

   screen.Cursor := crdefault;
   LimparCampos(sender);
   listbox1.items.add('Selado Formularios de ' + edit1.text + ' at� ' + edit3.text);
   form1.Refresh;
end;


procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if (Form2 <> nil ) or (fnumeracao <>nil)then
   begin
      msgTela('', ' Feche as outras janelas abertas', mb_ok + mb_iconerror);
      canclose := false;
   end;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
    if length(edit8.text) < 09 then
       application.messagebox('Falta o num da AIDF',pchar(form1.caption),mb_ok+ MB_ICONERROR)
    else
    begin
       Sela_NFVC(Sender);
    end;
end;


procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  if checkbox1.Checked = true then
      SelarNf1_Formularios(sender)
  else
     SelarNf1_Normal(Sender);
end;

procedure Tform1.LimpaCampos(Sender: TObject);
begin
    checkbox1.Checked:= false;
    edit1.text:='';
    edit2.text:='';
    edit4.text:='';
    edit3.text:='';
    edit8.text:='';
    edit7.text:='';
end;

procedure TForm1.Selarporarquivo1Click(Sender: TObject);
var
   i:integer;
begin
   form1.opendialog1.filename:='';
   form1.opendialog1.Filter := 'Arquivos de selagem *.SNF | *.snf';
   form1.openDialog1.InitialDir:=PATH+'_AIDFS';
   form1.openDialog1.Title :=' Selecione o arquivo da AIDF correspondente � loja.';

   if form1.openDialog1.execute then
   begin
      screen.cursor := crhourglass;

      ajustarCodDIBGE(Edit5.Text);
      ajustarEmissorNotaEntrada(Edit5.Text);



      AlteraCPF(Sender);
      lb3.items.LoadFromFile(form1.openDialog1.filename);
      for i := 1 to lb3.items.Count -1 do
      begin
         LimpaCampos(Sender);
         if copy(lb3.items[i],01,10) = 'FORMULARIO' then
         begin
            edit1.text := TiraEspacos( copy(lb3.items[i],11,10));
            edit2.Text := TiraEspacos( copy(lb3.items[i],21,10));
            edit3.Text := TiraEspacos( copy(lb3.items[i],31,10));
            edit4.Text := TiraEspacos( copy(lb3.items[i],41,10));
            edit7.text := TiraEspacos( copy(lb3.items[i],51,10));
            edit8.Text := TiraEspacos( copy(lb3.items[i],61,10));
            checkBox1.Checked:= true;
            edArqSelosDblClick(Sender); //carrega o arquivo dos selos/formuarios
            bitbtn3click(sender);
         end;

         if pos('NF1', copy(lb3.items[i],01,10) ) > 0  then
         begin
            edit1.text := TiraEspacos( copy(lb3.items[i],11,10));
            edit2.Text := TiraEspacos( copy(lb3.items[i],21,10));
            edit3.Text := TiraEspacos( copy(lb3.items[i],31,10));
            edit4.Text := TiraEspacos( copy(lb3.items[i],41,10));
            edit8.Text := TiraEspacos( copy(lb3.items[i],61,10));
            checkBox1.Checked:= false;
//            showmessage('SelarNotas');
            bitbtn3click(sender);
         end;
         if copy(lb3.items[i],01,10) = '      NFVC' then
         begin
            edit8.Text := TiraEspacos( copy(lb3.items[i],61,10));
            BitBtn2Click(sender);
         end;
      end;
      screen.cursor := crDefault;
   end;
end;


procedure TForm1.Edit5Change(Sender: TObject);
begin
  if fileExists(edit5.text) then
    Selarporarquivo1.enabled := true;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  Selarporarquivo1.Enabled:= false;
  form1.caption:=TITULO;
  funcoes.limparLog();
end;


procedure TForm1.AjustaDadosReducao(Sender: TObject);
var
   arq,arq2:TextFile;
   p3, p4, linha,linha2:string;
   dif,Nlinha:integer;
   Nnota, nselo:integer;
begin
   assignFile(arq,edit5.text);
   assignFile(arq2,PATH+'sisif2.TXT');
   reset(arq);
   rewrite(arq2);

   Nlinha:=0;
   while eof(arq) = false do
   begin
     readln(arq,linha);
     inc(Nlinha);
     if copy(linha,01,09) = '401137ECF' then
     begin
        delete(linha,07,03);
        insert('   ',linha,07);
        delete(linha,293,08);
        insert( funcoes.preencheCampo(08,'0','E',IntToStr(Nlinha)), linha,293 );
        writeln(arq2,linha);
        readln(arq,linha);
     end
     else
     begin
        delete(linha,293,08);
        insert( funcoes.preencheCampo(08,'0','E',IntToStr(Nlinha)), linha,293 );
        writeln(arq2,linha);
     end;
   end;

   closeFile(arq2);
   closeFile(arq);
   DeleteFile(edit5.text);
   renameFile(PATH+'SISIF2.txt',edit5.text);
   DeleteFile(PATH+'SISIF2.txt');
   LimparCampos(sender);
   listbox1.items.add('Ajuste de redu��o.');
   form1.Refresh;
end;


procedure TForm1.BitBtn1Click(Sender: TObject);
begin
   form1.AlteraCPF(sender);
   form1.AjustaDadosReducao(sender);
end;


procedure TForm1.logar(Str: String);
begin
   funcoes.gravaLog(str);
end;

procedure TForm1.ajustarCodDIBGE(arquivo:String);
var
  dest, arq:TStringList;
  i:integer;
  aux:String;
begin
   listbox1.items.add('Ajuste de cod IBGE.');
   arq:= TStringList.Create();
   dest := TStringList.Create();
   arq.LoadFromFile(arquivo);

   for i:= 0 to 15 do
   begin
      aux := arq[i];
      if ( pos('2304400',aux) > 0 )then
      begin
         delete(aux, pos('2304400',aux)+5, 02);
         funcoes.gravaLog(arq[i]);
         dest.Add(aux);
   end
   else
      dest.Add( arq[i]);
   end;
   for i:=16 to ARQ.Count-1 do
      dest.Add( arq[i]);
   dest.SaveToFile(Edit5.Text);
end;

procedure TForm1.ajustarEmissorNotaEntrada(arquivo:String);
var
  dest, arq:TStringList;
  i:integer;
  aux:String;
begin
   listbox1.items.add('Ajusta emissor nota entrada');
   arq:= TStringList.Create();
   dest := TStringList.Create();
   arq.LoadFromFile(arquivo);

   for i:= 0 to arq.Count -1 do
   begin
      aux := arq[i];
      if (copy(aux,01,02) = '40') then
         if (isNotaDeEntrada(aux) = true) then
            aux := ajustaEmissorNotaEntrada(aux);
         dest.Add(aux);
   end;
   arq.Destroy();
   dest.SaveToFile(arquivo);
   dest.Destroy();
end;

end.

