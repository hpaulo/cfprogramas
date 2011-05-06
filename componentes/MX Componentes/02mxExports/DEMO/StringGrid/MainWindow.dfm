object frm_MainWindow: Tfrm_MainWindow
  Left = 334
  Top = 147
  Width = 679
  Height = 438
  Caption = 'TmxExport Component Test'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 671
    Height = 89
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 474
      Height = 13
      Caption = 
        'This demo demonstrates only the TmxStringGrid, but all of my Exp' +
        'ort components work the same way'
    end
    object btn_Export: TButton
      Left = 8
      Top = 56
      Width = 75
      Height = 25
      Caption = '&Export'
      TabOrder = 0
      OnClick = btn_ExportClick
    end
    object btn_Close: TButton
      Left = 96
      Top = 56
      Width = 75
      Height = 25
      Caption = '&Close'
      TabOrder = 1
      OnClick = btn_CloseClick
    end
  end
  object StringGrid: TStringGrid
    Left = 0
    Top = 89
    Width = 671
    Height = 322
    Align = alClient
    ColCount = 10
    DefaultRowHeight = 15
    FixedCols = 0
    RowCount = 30
    TabOrder = 1
  end
  object mxStringGridExport: TmxStringGridExport
    DateFormat = 'M/d/yy'
    TimeFormat = 'h:mm AMPM'
    DateTimeFormat = 'h:mm AMPM M/d/yy'
    ExportType = xtRTF
    ExportTypes = [xtHTML, xtExcel, xtWord, xtTXT, xtCSV, xtTAB, xtRTF, xtDIF, xtSYLK, xtClipboard]
    ExportStyle = xsView
    HTML.CustomColors.Background = clWhite
    HTML.CustomColors.DefaultLink = clRed
    HTML.CustomColors.DefaultFontFace = 'Arial,Helvetica'
    HTML.CustomColors.VisitedLink = clAqua
    HTML.CustomColors.ActiveLink = clBlue
    HTML.CustomColors.DefaultText = clBlack
    HTML.CustomColors.TableFontColor = clBlack
    HTML.CustomColors.TableFontFace = 'Arial,Helvetica'
    HTML.CustomColors.TableBackground = 16777167
    HTML.CustomColors.TableOddBackground = clWhite
    HTML.CustomColors.HeaderBackground = 3368601
    HTML.CustomColors.HeadersFontColor = clWhite
    HTML.Options = [hoShowGridLines, hoBoldHeaders, hoAutoLink, hoOddRowColoring, hoDisplayTitle]
    HTML.Template = ctMSMoney
    Messages.Caption = 'Exporting String Grid'
    Messages.CopiedToClipboard = 'Data was copied to clipboard!'
    Messages.CancelCaption = '&Cancel'
    Messages.CreatedText = 'Created:'
    Messages.DocumentFilter.HTML = 'HTML Documents'
    Messages.DocumentFilter.Excel = 'Excel Files'
    Messages.DocumentFilter.Word = 'Word Documents'
    Messages.DocumentFilter.Text = 'Text Files'
    Messages.DocumentFilter.Comma = 'CSV (Comma delimited)'
    Messages.DocumentFilter.Tab = 'Text (Tab delimited)'
    Messages.DocumentFilter.RTF = 'Rich Text Format'
    Messages.DocumentFilter.DIF = 'Data Interchange Format'
    Messages.DocumentFilter.SYLK = 'SYLK Files'
    Messages.ExportCaption = '&Export'
    Messages.ExportToFile = 'Export &to file'
    Messages.FalseText = 'False'
    Messages.Height = 80
    Messages.SaveTitle = 'Save document'
    Messages.SelectFormat = 'E&xport formats:'
    Messages.Text = 'Processing...'
    Messages.TrueText = 'True'
    Messages.Width = 300
    Messages.ViewOnly = '&View only'
    TruncateSymbol = '...'
    RowNumberFormat = '%d'
    DOC_RTF.Template = rtStandard
    DOC_RTF.Options = [roShowGridLines, roOddRowColoring]
    DOC_RTF.CustomSettings.TableBackground = 16777167
    DOC_RTF.CustomSettings.TableOddBackground = clWhite
    DOC_RTF.CustomSettings.HeaderBackground = 3368601
    DOC_RTF.CustomSettings.DefaultFont.Charset = DEFAULT_CHARSET
    DOC_RTF.CustomSettings.DefaultFont.Color = clWindowText
    DOC_RTF.CustomSettings.DefaultFont.Height = -11
    DOC_RTF.CustomSettings.DefaultFont.Name = 'MS Sans Serif'
    DOC_RTF.CustomSettings.DefaultFont.Style = []
    DOC_RTF.CustomSettings.HeaderFont.Charset = DEFAULT_CHARSET
    DOC_RTF.CustomSettings.HeaderFont.Color = clWindowText
    DOC_RTF.CustomSettings.HeaderFont.Height = -11
    DOC_RTF.CustomSettings.HeaderFont.Name = 'MS Sans Serif'
    DOC_RTF.CustomSettings.HeaderFont.Style = [fsBold]
    DOC_RTF.CustomSettings.TableFont.Charset = DEFAULT_CHARSET
    DOC_RTF.CustomSettings.TableFont.Color = clWindowText
    DOC_RTF.CustomSettings.TableFont.Height = -11
    DOC_RTF.CustomSettings.TableFont.Name = 'MS Sans Serif'
    DOC_RTF.CustomSettings.TableFont.Style = []
    DOC_RTF.CellWidth = 1400
    DOC_RTF.TopMargin = 101
    DOC_RTF.BottomMargin = 101
    DOC_RTF.LeftMargin = 461
    DOC_RTF.RightMargin = 562
    EXCEL.Options = [reSetColumnWidths]
    EXCEL.ColumnWidth = 15
    EXCEL.Protected = False
    EXCEL.DefaultFont.Name = 'MS Sans Serif'
    EXCEL.DefaultFont.Charset = DEFAULT_CHARSET
    EXCEL.DefaultFont.Color = ecAutomatic
    EXCEL.DefaultFont.Size = 10
    EXCEL.DefaultFont.Style = []
    EXCEL.PageSetup.Header.Font.Name = 'Arial'
    EXCEL.PageSetup.Header.Font.Charset = ANSI_CHARSET
    EXCEL.PageSetup.Header.Font.Color = ecAutomatic
    EXCEL.PageSetup.Header.Font.Size = 10
    EXCEL.PageSetup.Header.Font.Style = []
    EXCEL.PageSetup.Footer.Center = '&P'
    EXCEL.PageSetup.Footer.Right = '&D'
    EXCEL.PageSetup.Footer.Font.Name = 'Arial'
    EXCEL.PageSetup.Footer.Font.Charset = ANSI_CHARSET
    EXCEL.PageSetup.Footer.Font.Color = ecAutomatic
    EXCEL.PageSetup.Footer.Font.Size = 10
    EXCEL.PageSetup.Footer.Font.Style = []
    EXCEL.PageSetup.AdjustTo = 100
    EXCEL.PageSetup.Copies = 1
    EXCEL.PageSetup.Options = []
    EXCEL.PageSetup.FirstPage = 0
    EXCEL.PageSetup.FitTall = 1
    EXCEL.PageSetup.FitWide = 1
    EXCEL.PageSetup.Margins.Left = 0.75
    EXCEL.PageSetup.Margins.Right = 0.75
    EXCEL.PageSetup.Margins.Top = 1
    EXCEL.PageSetup.Margins.Bottom = 1
    EXCEL.PageSetup.Margins.Footer = 0.5
    EXCEL.PageSetup.Margins.Header = 0.5
    EXCEL.PageSetup.PaperSize = piPrinter_Default
    EXCEL.HeaderFormat.Alignment.Horizontal = haCenter
    EXCEL.HeaderFormat.Borders.Top.BorderStyle = ebThin
    EXCEL.HeaderFormat.Borders.Bottom.BorderStyle = ebMedium
    EXCEL.HeaderFormat.Borders.Left.BorderStyle = ebThin
    EXCEL.HeaderFormat.Borders.Right.BorderStyle = ebThin
    EXCEL.HeaderFormat.Borders.Diagonal.BorderStyle = ebNone
    EXCEL.HeaderFormat.Font.Name = 'Arial'
    EXCEL.HeaderFormat.Font.Charset = ANSI_CHARSET
    EXCEL.HeaderFormat.Font.Color = ecBlue
    EXCEL.HeaderFormat.Font.Size = 12
    EXCEL.HeaderFormat.Font.Style = [efBold, efItalic]
    EXCEL.HeaderFormat.Options = [foLocked]
    EXCEL.HeaderFormat.Pattern.Style = epSolid
    EXCEL.HeaderFormat.Pattern.Interior = ecAutomatic
    EXCEL.HeaderFormat.Pattern.Color = ecGrey25
    EXCEL.TableFormat.Borders.Top.BorderStyle = ebThin
    EXCEL.TableFormat.Borders.Bottom.BorderStyle = ebThin
    EXCEL.TableFormat.Borders.Left.BorderStyle = ebThin
    EXCEL.TableFormat.Borders.Right.BorderStyle = ebThin
    EXCEL.TableFormat.Borders.Diagonal.BorderStyle = ebNone
    EXCEL.TableFormat.Borders.BorderStyle = ebThin
    EXCEL.TableFormat.Font.Name = 'Arial'
    EXCEL.TableFormat.Font.Charset = ANSI_CHARSET
    EXCEL.TableFormat.Font.Color = ecAutomatic
    EXCEL.TableFormat.Font.Size = 10
    EXCEL.TableFormat.Font.Style = []
    EXCEL.TableFormat.Options = [foLocked]
    EXCEL.TableFormat.Pattern.Style = epNone
    EXCEL.TableFormat.Pattern.Interior = ecAutomatic
    EXCEL.TableFormat.Pattern.Color = ecAutomatic
    Options = [xoClipboardMessage, xoFooterLine, xoHeaderLine, xoShowExportDate, xoShowHeader, xoShowProgress, xoUseAlignments]
    Version = '2.34'
    StringGrid = StringGrid
    Left = 8
    Top = 24
  end
end
