object frmPrincipal: TfrmPrincipal
  Left = 199
  Top = 142
  Width = 696
  Height = 487
  Caption = 'Menu Principal - Academia'
  Color = clBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Shape1: TShape
    Left = 0
    Top = 0
    Width = 680
    Height = 393
    Brush.Color = clGreen
    Brush.Style = bsDiagCross
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 412
    Width = 680
    Height = 19
    AutoHint = True
    Panels = <
      item
        Width = 700
      end
      item
        Alignment = taCenter
        Width = 100
      end
      item
        Alignment = taCenter
        Width = 250
      end>
  end
  object MainMenu1: TMainMenu
    Images = ImageList1
    Left = 328
    Top = 168
    object Arquivo1: TMenuItem
      Caption = '&Arquivo'
      object CadastrodeAlunos1: TMenuItem
        Caption = '&Cadastro de Alunos'
        Hint = 'Exibe tela de cadastro de Alunos'
        OnClick = CadastrodeAlunos1Click
      end
      object CadastrodeModalidades1: TMenuItem
        Caption = 'C&adastro de Modalidades'
        Hint = 'Exibe tela de cadastro de Modalidades'
        OnClick = CadastrodeModalidades1Click
      end
      object CadastrodeMedidas1: TMenuItem
        Caption = 'Ca&dastro de Medidas'
        Hint = 'Exibe tela de cadastro de medidas dos Alunos'
        OnClick = CadastrodeMedidas1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Fechar1: TMenuItem
        Caption = '&Fechar'
        Hint = 'Sai da aplica'#231#227'o/Sistema'
        ShortCut = 49222
        OnClick = Fechar1Click
      end
    end
    object Impressos1: TMenuItem
      Caption = '&Impressos'
      object RelatriodeAniversriantes1: TMenuItem
        Caption = 'Relat'#243'rio de Anivers'#225'riantes'
        object Janeiro1: TMenuItem
          Caption = '&Janeiro'
          Hint = 'Exibe aniversariantes do m'#234's de Janeiro'
          OnClick = Janeiro1Click
        end
        object Fevereiro1: TMenuItem
          Caption = '&Fevereiro'
          Hint = 'Exibe aniversariantes do m'#234's de Fevereiro'
          OnClick = Fevereiro1Click
        end
        object Maro1: TMenuItem
          Caption = '&Mar'#231'o'
          Hint = 'Exibe aniversariantes do m'#234's de Mar'#231'o'
          OnClick = Maro1Click
        end
        object Abril1: TMenuItem
          Caption = '&Abril'
          Hint = 'Exibe aniversariantes do m'#234's de Abril'
          OnClick = Abril1Click
        end
        object Maio1: TMenuItem
          Caption = 'Ma&io'
          Hint = 'Exibe aniversariantes do m'#234's de Maio'
          OnClick = Maio1Click
        end
        object Junho1: TMenuItem
          Caption = 'J&unho'
          Hint = 'Exibe aniversariantes do m'#234's de Junho'
          OnClick = Junho1Click
        end
        object Julho1: TMenuItem
          Caption = 'Ju&lho'
          Hint = 'Exibe aniversariantes do m'#234's de Julho'
          OnClick = Julho1Click
        end
        object Agosto1: TMenuItem
          Caption = 'A&gosto'
          Hint = 'Exibe aniversariantes do m'#234's de Agosto'
          OnClick = Agosto1Click
        end
        object Setembro1: TMenuItem
          Caption = '&Setembro'
          Hint = 'Exibe aniversariantes do m'#234's de Setembro'
          OnClick = Setembro1Click
        end
        object Outubro1: TMenuItem
          Caption = '&Outubro'
          Hint = 'Exibe aniversariantes do m'#234's de Outubro'
          OnClick = Outubro1Click
        end
        object Novembro1: TMenuItem
          Caption = '&Novembro'
          Hint = 'Exibe aniversariantes do m'#234's de Novembro'
          OnClick = Novembro1Click
        end
        object Dezembro1: TMenuItem
          Caption = '&Dezembro'
          Hint = 'Exibe aniversariantes do m'#234's de Dezembro'
          OnClick = Dezembro1Click
        end
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object RelatriodeMensalidades1: TMenuItem
        Caption = 'Relat'#243'rio de Mensalidades'
        Hint = 'Exibe preview do relat'#243'rio com mensalidades e seus Valores'
        OnClick = RelatriodeMensalidades1Click
      end
    end
    object Exibir1: TMenuItem
      Caption = '&Exibir'
      object Barradestatus1: TMenuItem
        Caption = '&Barra de status'
        Checked = True
        Hint = 'Exibe/Oculta a barra de Status'
        OnClick = Barradestatus1Click
      end
      object Calendrio1: TMenuItem
        Caption = '&Calend'#225'rio'
        Hint = 'Exibe calend'#225'rio'
        OnClick = Calendrio1Click
      end
    end
    object Movimento1: TMenuItem
      Caption = '&Movimento'
      object PagamentosdeMensalidades1: TMenuItem
        Caption = '&Pagamentos de Mensalidades'
        Hint = 'Exibe tela de pagamentos de Mensalidades'
        OnClick = PagamentosdeMensalidades1Click
      end
    end
    object Ajuda1: TMenuItem
      Caption = 'A&juda'
      object Opes1: TMenuItem
        Caption = 'Op'#231#245'es'
        object CordeFundo1: TMenuItem
          Caption = '&Alterar cor de Fundo'
          Hint = 'Altera cor de fundo do sistema'
          OnClick = CordeFundo1Click
        end
        object CordaslinhasdeFundo1: TMenuItem
          Caption = 'A&lterar cor das linhas de Fundo'
          Hint = 'Altera cor das linhas de fundo do sistema'
          OnClick = CordaslinhasdeFundo1Click
        end
        object LigarproteodeTela1: TMenuItem
          Caption = '&Ligar prote'#231#227'o de Tela'
          Hint = 'Ativa a prote'#231#227'o de tela do Windows'
          OnClick = LigarproteodeTela1Click
        end
      end
      object SobreoSistema1: TMenuItem
        Caption = '&Sobre o Sistema'
        Hint = 'Informa'#231#245'es sobre o sistema'
        ImageIndex = 0
        ShortCut = 112
        OnClick = SobreoSistema1Click
      end
      object SobreoProgramador1: TMenuItem
        Caption = '&Sobre o Programador'
        Hint = 'Inforna'#231#245'es sobre o programador'
        ImageIndex = 1
        ShortCut = 113
        OnClick = SobreoProgramador1Click
      end
    end
  end
  object ImageList1: TImageList
    Left = 264
    Top = 168
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF007B7B7B000000FF007B7B7B00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00FFFFFF0000FFFF000000FF000000FF000000FF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF007B7B7B000000FF007B7B7B00FFFFFF0000FFFF00FFFF
      FF0000FFFF00000000000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000BDBDBD0000000000BDBDBD00FF000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF0000000000000000000000000000000000BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00000000007B7B7B0000000000BDBDBD00BDBDBD00BDBD
      BD00BDBDBD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF000000FF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF00000000000000000000000000FFFFFF00000000007B7B
      7B007B7B7B0000000000FFFFFF007B7B7B00FFFFFF00000000007B7B7B007B7B
      7B0000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF000000FF007B7B7B0000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF00000000007B7B7B0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF007B7B7B00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF000000FF000000FF00FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00000000007B7B7B0000000000FFFFFF000000
      00000000000000000000FFFFFF007B7B7B00FFFFFF0000000000000000000000
      0000FFFFFF00000000007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF000000FF000000FF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF007B7B7B00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF00FFFFFF0000FFFF00FFFF
      FF007B7B7B007B7B7B0000FFFF00FFFFFF007B7B7B000000FF000000FF00FFFF
      FF0000FFFF00FFFFFF0000FFFF0000000000000000007B7B7B0000000000FFFF
      FF000000000000000000FFFFFF007B7B7B00FFFFFF000000000000000000FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000FFFF00FFFFFF0000FF
      FF000000FF000000FF00FFFFFF0000FFFF007B7B7B000000FF000000FF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000000000000000007B7B7B0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF007B7B7B00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF000000FF000000FF007B7B7B00FFFFFF007B7B7B000000FF000000FF00FFFF
      FF0000FFFF00FFFFFF000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF000000FF000000FF000000FF000000FF000000FF00FFFFFF0000FF
      FF00FFFFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF000000FF000000FF000000FF00FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000F83FFFFF00000000
      E00FF83F00000000C00700010000000080030001000000008003000100000000
      0001000100000000000100010000000000018003000000000001800300000000
      00018003000000008003C107000000008003E38F00000000C007FFFF00000000
      E00FFFFF00000000F83FFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object Database1: TDatabase
    AliasName = 'Academia'
    DatabaseName = 'Banco de Dados Academia'
    LoginPrompt = False
    Params.Strings = (
      'USER NAME=SA')
    SessionName = 'Default'
    Left = 392
    Top = 168
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 448
    Top = 168
  end
  object dlcFundo: TColorDialog
    Left = 208
    Top = 168
  end
end