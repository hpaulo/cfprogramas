object fmMain: TfmMain
  Left = 413
  Top = 261
  Width = 265
  Height = 254
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '01.08.01 - Coletor. '
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  KeyPreview = True
  Menu = menu
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object lbEanRecebido: TLabel
    Left = 64
    Top = 2
    Width = 73
    Height = 13
    Caption = 'lbEanRecebido'
    Visible = False
  end
  object Label2: TLabel
    Left = 3
    Top = 3
    Width = 22
    Height = 13
    Caption = 'EAN'
  end
  object Label3: TLabel
    Left = 143
    Top = 1
    Width = 58
    Height = 13
    Caption = 'Quantidade:'
  end
  object edEan: TEdit
    Left = 2
    Top = 18
    Width = 135
    Height = 19
    Ctl3D = False
    MaxLength = 13
    ParentCtl3D = False
    TabOrder = 0
    OnKeyDown = edEanKeyDown
  end
  object edQuant: TEdit
    Left = 144
    Top = 18
    Width = 99
    Height = 19
    Ctl3D = False
    MaxLength = 6
    ParentCtl3D = False
    TabOrder = 1
  end
  object edDescricao: TEdit
    Left = 2
    Top = 42
    Width = 241
    Height = 19
    Color = clBtnFace
    Ctl3D = False
    MaxLength = 20
    ParentCtl3D = False
    TabOrder = 2
  end
  object menu: TMainMenu
    Left = 36
    Top = 12
    object File1: TMenuItem
      Caption = 'File'
      object NovaCaptura1: TMenuItem
        Caption = 'NovaCaptura'
        OnClick = NovaCaptura1Click
      end
      object DeletaItem1: TMenuItem
        Caption = 'Ver Itens'
      end
    end
  end
end
