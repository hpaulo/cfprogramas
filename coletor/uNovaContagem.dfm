object fmNovaContagem: TfmNovaContagem
  Left = 463
  Top = 223
  Width = 262
  Height = 183
  BorderIcons = [biSystemMenu]
  Caption = 'fmNovaContagem'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object cbCritQt: TfsCheckBox
    Left = 6
    Top = 48
    Width = 158
    Height = 17
    Caption = 'Aceita EAN n'#227'o cadastrado'
    TabOrder = 0
    FlatFont.Charset = DEFAULT_CHARSET
    FlatFont.Color = clWindowText
    FlatFont.Height = -11
    FlatFont.Name = 'MS Sans Serif'
    FlatFont.Style = []
  end
  object cbContund: TfsCheckBox
    Left = 6
    Top = 65
    Width = 165
    Height = 17
    Caption = 'Contagem unit'#225'ria'
    TabOrder = 1
    FlatFont.Charset = DEFAULT_CHARSET
    FlatFont.Color = clWindowText
    FlatFont.Height = -11
    FlatFont.Name = 'MS Sans Serif'
    FlatFont.Style = []
  end
  object cbLimpaDados: TfsCheckBox
    Left = 7
    Top = 106
    Width = 165
    Height = 20
    Caption = 'Limpa os dados armazenados'
    TabOrder = 2
    FlatFont.Charset = DEFAULT_CHARSET
    FlatFont.Color = clWindowText
    FlatFont.Height = -11
    FlatFont.Name = 'MS Sans Serif'
    FlatFont.Style = []
  end
  object ednColetor: TadLabelSpinEdit
    Left = 7
    Top = 16
    Width = 97
    Height = 22
    Cursor = crDefault
    LabelDefs.Width = 36
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Coletor:'
    Ctl3D = False
    ParentCtl3D = False
    Decimals = 0
    TabOrder = 3
    Increment = 1.000000000000000000
    RoundValues = False
    Wrap = False
  end
  object cbConfItemSemCadastro: TfsCheckBox
    Left = 7
    Top = 85
    Width = 231
    Height = 17
    Caption = 'Pede confirma'#231#227'o p/ itens n'#227'o cadastrados'
    TabOrder = 4
    FlatFont.Charset = DEFAULT_CHARSET
    FlatFont.Color = clWindowText
    FlatFont.Height = -11
    FlatFont.Name = 'MS Sans Serif'
    FlatFont.Style = []
  end
end
