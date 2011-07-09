object fmRelGeral: TfmRelGeral
  Left = 667
  Top = 357
  Width = 784
  Height = 337
  Caption = 'Pagamentos em cart'#227'o - pr'#233'via de caixa'
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
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cbLojas: TadLabelComboBox
    Left = 3
    Top = 25
    Width = 175
    Height = 21
    AutoDropDown = True
    BevelInner = bvNone
    BevelKind = bkSoft
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnClick = cbLojasClick
    LabelDefs.Width = 20
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object btOk: TFlatButton
    Left = 656
    Top = 22
    Width = 66
    Height = 26
    Caption = '&OK'
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 1
    ModalResult = 1
    OnClick = btOkClick
  end
  object GroupBox1: TGroupBox
    Left = 192
    Top = 9
    Width = 249
    Height = 50
    Caption = ' Per'#237'odo '
    TabOrder = 2
    object Label1: TLabel
      Left = 115
      Top = 23
      Width = 15
      Height = 13
      Caption = 'at'#233
    end
    object dti: TDateTimePicker
      Left = 11
      Top = 20
      Width = 102
      Height = 21
      Date = 40391.000000000000000000
      Time = 40391.000000000000000000
      TabOrder = 0
      OnChange = dtiChange
    end
    object dtf: TDateTimePicker
      Left = 134
      Top = 20
      Width = 102
      Height = 21
      BevelInner = bvSpace
      Date = 40395.999305555550000000
      Time = 40395.999305555550000000
      TabOrder = 1
    end
  end
  object cbDetAvaForn: TfsCheckBox
    Left = 192
    Top = 64
    Width = 249
    Height = 17
    Caption = 'Detalhar por fornecedor'
    TabOrder = 3
    Visible = False
    FlatFont.Charset = DEFAULT_CHARSET
    FlatFont.Color = clWindowText
    FlatFont.Height = -11
    FlatFont.Name = 'MS Sans Serif'
    FlatFont.Style = []
  end
  object cbCaixas: TadLabelComboBox
    Left = 451
    Top = 25
    Width = 162
    Height = 21
    AutoDropDown = True
    BevelInner = bvNone
    BevelKind = bkSoft
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 4
    LabelDefs.Width = 26
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Caixa'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object qr: TADOQuery
    Connection = fmMain.Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      '/*'
      
        'Select l.is_uo,l.ds_uo, c.cd_ref,c.ds_ref, z.pedido, z.qt, z.und' +
        ', (z.qt* z.und ) '
      
        'as tVenda, z.valorSugerido as pcVarejo , (z.qt* z.valorSugerido ' +
        ') as tVarejo, '
      
        'z.cmu, (z.qt* z.cmu)as tCMU, ((z.qt* z.und ) - (z.qt* z.cmu)) as' +
        ' DifCMU, '
      ' ((z.valorSugerido * z.und ) - (z.qt* z.cmu)) as DifVenda,'
      ' case when '
      ' ( (z.qt* z.cmu)) -  ((z.qt* z.und ))  > 0  then'
      ' (z.qt* z.cmu) -  (z.qt* z.und ) else 0 end as prejuizo  '
      
        '  from zcf_avariasDescontos z (nolock)  inner join crefe c (nolo' +
        'ck) on'
      
        ' z.is_ref = c.is_ref  inner join zcf_tbuo l (nolock)  on z.is_uo' +
        ' = l.is_uo '
      
        ' where  z.data between '#39'2010-08-01 00:00:00'#39' and '#39'2010-08-11 23:' +
        '59:00'#39' '
      'order by z.is_uo, z.data'
      '*/')
    Left = 16
    Top = 80
    object qris_uo: TIntegerField
      FieldName = 'is_uo'
    end
    object qrds_uo: TStringField
      FieldName = 'ds_uo'
      Size = 50
    end
    object qrcd_ref: TStringField
      FieldName = 'cd_ref'
    end
    object qrds_ref: TStringField
      FieldName = 'ds_ref'
      Size = 50
    end
    object qrpedido: TIntegerField
      FieldName = 'pedido'
    end
    object qrqt: TIntegerField
      FieldName = 'qt'
    end
    object qrund: TBCDField
      FieldName = 'und'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object qrtVenda: TBCDField
      FieldName = 'tVenda'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object qrpcVarejo: TBCDField
      FieldName = 'pcVarejo'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object qrtVarejo: TBCDField
      FieldName = 'tVarejo'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object qrcmu: TBCDField
      FieldName = 'cmu'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object qrtCMU: TBCDField
      FieldName = 'tCMU'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object qrDifCMU: TBCDField
      FieldName = 'DifCMU'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object qrDifVenda: TBCDField
      FieldName = 'DifVenda'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object qrprejuizo: TBCDField
      FieldName = 'prejuizo'
      ReadOnly = True
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
  end
  object tbValoresAvarias: TADOTable
    Connection = fmMain.Conexao
    Left = 16
    Top = 143
    object tbValoresAvariasis_uo: TStringField
      FieldName = 'is_uo'
      Size = 8
    end
    object tbValoresAvariasds_uo: TStringField
      FieldName = 'ds_uo'
      Size = 30
    end
    object tbValoresAvariasTipoAvaria: TStringField
      FieldName = 'TipoAvaria'
    end
    object tbValoresAvariasqtItens: TIntegerField
      FieldName = 'qtItens'
    end
    object tbValoresAvariasvalorTotalCusto: TBCDField
      FieldName = 'valorTotalCusto'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbValoresAvariasvalorTotalPcVarejo: TBCDField
      FieldName = 'valorTotalPcVarejo'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbValoresAvariasTotalVendido: TBCDField
      FieldName = 'TotalVendido'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbValoresAvariasFornecedor: TStringField
      FieldName = 'Fornecedor'
      Size = 30
    end
  end
  object tbValoresAvarias_Total: TADOTable
    Connection = fmMain.Conexao
    Left = 17
    Top = 184
    object tbValoresAvarias_TotaltipoAvaria: TStringField
      FieldName = 'tipoAvaria'
      Size = 30
    end
    object tbValoresAvarias_TotalqtItens: TIntegerField
      FieldName = 'qtItens'
    end
    object tbValoresAvarias_TotalvalorTotalCusto: TBCDField
      FieldName = 'valorTotalCusto'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbValoresAvarias_TotalvalorTotalVenda: TBCDField
      FieldName = 'valorTotalVenda'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbValoresAvarias_Totalfornecedor: TStringField
      FieldName = 'fornecedor'
      Size = 30
    end
  end
  object tbPreviaDeCaixa: TADOTable
    Connection = fmMain.Conexao
    Left = 304
    Top = 160
    object tbPreviaDeCaixacodLoja: TIntegerField
      FieldName = 'codLoja'
    end
    object tbPreviaDeCaixadescEstacao: TStringField
      FieldName = 'descEstacao'
    end
    object tbPreviaDeCaixacd_mve: TIntegerField
      FieldName = 'cd_mve'
    end
    object tbPreviaDeCaixads_mve: TStringField
      FieldName = 'ds_mve'
      Size = 30
    end
    object tbPreviaDeCaixadataSessaoCaixa: TDateTimeField
      FieldName = 'dataSessaoCaixa'
    end
    object tbPreviaDeCaixaseqtransacaoCaixa: TIntegerField
      FieldName = 'seqtransacaoCaixa'
    end
    object tbPreviaDeCaixaseqModPagtoPorTransCaixa: TIntegerField
      FieldName = 'seqModPagtoPorTransCaixa'
    end
    object tbPreviaDeCaixaValor: TBCDField
      FieldName = 'Valor'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbPreviaDeCaixanumParcelas: TStringField
      FieldName = 'numParcelas'
      Size = 3
    end
    object tbPreviaDeCaixatefMagnetico: TStringField
      FieldName = 'tefMagnetico'
      Size = 1
    end
    object tbPreviaDeCaixaseqTefTransCaixa: TIntegerField
      FieldName = 'seqTefTransCaixa'
    end
    object tbPreviaDeCaixacd_tpm: TStringField
      FieldName = 'cd_tpm'
      Size = 1
    end
    object tbPreviaDeCaixatp_mve: TStringField
      FieldName = 'tp_mve'
      Size = 1
    end
  end
  object tbOperadores: TADOTable
    Connection = fmMain.Conexao
    Left = 344
    Top = 160
  end
  object tbTotRec: TADOTable
    Connection = fmMain.Conexao
    Left = 384
    Top = 160
    object tbTotReccd_mve: TStringField
      FieldName = 'cd_mve'
      Size = 50
    end
    object tbTotRecvalor: TBCDField
      FieldName = 'valor'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
  end
  object tbSangrias: TADOTable
    Connection = fmMain.Conexao
    Left = 424
    Top = 160
    object tbSangriascd_mve: TStringField
      FieldName = 'cd_mve'
      Size = 50
    end
    object tbSangriasvalor: TBCDField
      FieldName = 'valor'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
  end
  object tbVendasCartao: TADOTable
    Connection = fmMain.Conexao
    CursorType = ctStatic
    Left = 472
    Top = 160
    object tbVendasCartaocodLoja: TIntegerField
      FieldName = 'codLoja'
    end
    object tbVendasCartaocd_mve: TIntegerField
      FieldName = 'cd_mve'
    end
    object tbVendasCartaods_mve: TStringField
      FieldName = 'ds_mve'
    end
    object tbVendasCartaoseqTransacaoCaixa: TIntegerField
      FieldName = 'seqTransacaoCaixa'
    end
    object tbVendasCartaovalor: TBCDField
      FieldName = 'valor'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbVendasCartaonumparcelas: TIntegerField
      FieldName = 'numparcelas'
    end
    object tbVendasCartaotp_mve: TStringField
      FieldName = 'tp_mve'
      Size = 1
    end
    object tbVendasCartaotefMagnetico: TStringField
      FieldName = 'tefMagnetico'
      Size = 1
    end
  end
end
