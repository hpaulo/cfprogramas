object Form2: TForm2
  Left = 298
  Top = 66
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Gera'#231#227'o de pre'#231'os a partir de pedido de compra.'
  ClientHeight = 317
  ClientWidth = 557
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TadLabelEdit
    Left = 1
    Top = 25
    Width = 145
    Height = 22
    LabelDefs.Width = 87
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Numero do pedido'
    Colors.Active = False
    Colors.WhenEnterFocus.BackColor = clWindow
    Colors.WhenExitFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnKeyDown = Edit1KeyDown
  end
  object sg2: TStringGrid
    Left = 1
    Top = 57
    Width = 554
    Height = 195
    Color = clInfoBk
    ColCount = 8
    Ctl3D = False
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ParentCtl3D = False
    TabOrder = 1
  end
  object edit2: TadLabelNumericEdit
    Left = 1
    Top = 272
    Width = 77
    Height = 22
    LabelDefs.Width = 57
    LabelDefs.Height = 13
    LabelDefs.Caption = '% Desconto'
    Colors.Active = False
    Colors.WhenEnterFocus.BackColor = clWindow
    Colors.WhenExitFocus.BackColor = clInfoBk
    Color = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object edit4: TadLabelNumericEdit
    Left = 184
    Top = 272
    Width = 77
    Height = 22
    LabelDefs.Width = 64
    LabelDefs.Height = 13
    LabelDefs.Caption = '% Margem 01'
    Colors.Active = False
    Colors.WhenEnterFocus.BackColor = clWindow
    Colors.WhenExitFocus.BackColor = clInfoBk
    Color = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object edit3: TadLabelNumericEdit
    Left = 89
    Top = 272
    Width = 77
    Height = 22
    LabelDefs.Width = 35
    LabelDefs.Height = 13
    LabelDefs.Caption = '% Frete'
    Colors.Active = False
    Colors.WhenEnterFocus.BackColor = clWindow
    Colors.WhenExitFocus.BackColor = clInfoBk
    Color = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object Memo1: TMemo
    Left = 1
    Top = 231
    Width = 553
    Height = 9
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -8
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    Visible = False
  end
  object edit6: TadLabelNumericEdit
    Left = 374
    Top = 25
    Width = 97
    Height = 22
    LabelDefs.Width = 86
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Ajusta % IPI para :'
    LabelPosition = adLeft
    Colors.Active = False
    Colors.WhenEnterFocus.BackColor = clWindow
    Colors.WhenExitFocus.BackColor = clInfoBk
    Color = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object FlatButton1: TFlatButton
    Left = 390
    Top = 265
    Width = 74
    Height = 32
    Caption = '&Calcular'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00337000000000
      73333337777777773F333308888888880333337F3F3F3FFF7F33330808089998
      0333337F737377737F333308888888880333337F3F3F3F3F7F33330808080808
      0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
      0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
      0333337F737373737F333308888888880333337F3FFFFFFF7F33330800000008
      0333337F7777777F7F333308000E0E080333337F7FFFFF7F7F33330800000008
      0333337F777777737F333308888888880333337F333333337F33330888888888
      03333373FFFFFFFF733333700000000073333337777777773333}
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 7
    OnClick = FlatButton1Click
  end
  object FlatButton2: TFlatButton
    Left = 478
    Top = 265
    Width = 74
    Height = 32
    Caption = '&Sair'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
      03333377777777777F333301BBBBBBBB033333773F3333337F3333011BBBBBBB
      0333337F73F333337F33330111BBBBBB0333337F373F33337F333301110BBBBB
      0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
      0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
      0333337F337F33337F333301110BBBBB0333337F337FF3337F33330111B0BBBB
      0333337F337733337F333301110BBBBB0333337F337F33337F333301110BBBBB
      0333337F3F7F33337F333301E10BBBBB0333337F7F7F33337F333301EE0BBBBB
      0333337F777FFFFF7F3333000000000003333377777777777333}
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 8
    OnClick = FlatButton2Click
  end
  object FlatButton3: TFlatButton
    Left = 151
    Top = 23
    Width = 40
    Height = 28
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333300000000
      0000333377777777777733330FFFFFFFFFF033337F3FFF3F3FF733330F000F0F
      00F033337F777373773733330FFFFFFFFFF033337F3FF3FF3FF733330F00F00F
      00F033337F773773773733330FFFFFFFFFF033337FF3333FF3F7333300FFFF00
      F0F03333773FF377F7373330FB00F0F0FFF0333733773737F3F7330FB0BF0FB0
      F0F0337337337337373730FBFBF0FB0FFFF037F333373373333730BFBF0FB0FF
      FFF037F3337337333FF700FBFBFB0FFF000077F333337FF37777E0BFBFB000FF
      0FF077FF3337773F7F37EE0BFB0BFB0F0F03777FF3733F737F73EEE0BFBF00FF
      00337777FFFF77FF7733EEEE0000000003337777777777777333}
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 9
    OnClick = FlatButton3Click
  end
  object FlatButton4: TFlatButton
    Left = 475
    Top = 23
    Width = 40
    Height = 28
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      55555FFFFFFF5F55FFF5777777757559995777777775755777F7555555555550
      305555555555FF57F7F555555550055BB0555555555775F777F55555550FB000
      005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
      B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
      B05555577F555557F7F5550E0BFBFB00B055557575F55577F7F550EEE0BFB0B0
      B05557FF575F5757F7F5000EEE0BFBF0B055777FF575FFF7F7F50000EEE00000
      B0557777FF577777F7F500000E055550805577777F7555575755500000555555
      05555777775555557F5555000555555505555577755555557555}
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 10
    OnClick = FlatButton4Click
  end
  object Edit5: TadLabelNumericEdit
    Left = 270
    Top = 272
    Width = 77
    Height = 22
    Hint = 'Percentual sobre o  Valor da Margem 01'
    LabelDefs.Width = 64
    LabelDefs.Height = 13
    LabelDefs.Caption = '% Margem 02'
    Colors.Active = False
    Colors.WhenEnterFocus.BackColor = clWindow
    Colors.WhenExitFocus.BackColor = clInfoBk
    Color = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
  end
  object CheckBox1: TCheckBox
    Left = 390
    Top = 301
    Width = 163
    Height = 17
    Caption = 'Mostre a mem'#243'ria de c'#225'lculo'
    TabOrder = 12
  end
  object Query: TADOQuery
    Connection = Form1.Connection
    CursorType = ctStatic
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      
        'select prod.is_ref, Prod.cd_ref, Prod.ds_ref, CAST ( item.qt_ped' +
        ' as int) as quantidade, item.pr_uni, item.pc_ipi, cast(0 as smal' +
        'lmoney) as Dsc '
      'from crefe prod, dsipe item where prod.is_ref = item.is_ref'
      'and item.is_pedf = 2233')
    Left = 219
    Top = 3
  end
end
