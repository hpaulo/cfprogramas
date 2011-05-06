object fmMain: TfmMain
  Left = 324
  Top = 137
  Width = 911
  Height = 561
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = menuPrincipal
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 484
    Width = 895
    Height = 19
    Panels = <
      item
        Width = 170
      end
      item
        Width = 150
      end
      item
        Width = 150
      end
      item
        Width = 150
      end>
  end
  object Button1: TButton
    Left = 24
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    Visible = False
    OnClick = Button1Click
  end
  object menuPrincipal: TMainMenu
    Left = 49
    Top = 128
    object Estoques1: TMenuItem
      Caption = '&Estoques'
      object ConsultaaRequisies1: TMenuItem
        Caption = 'Fun'#231#245'es'
        object Analisedeestoque1: TMenuItem
          Tag = 106
          Caption = 'An'#225'lise de estoque para compras'
          OnClick = Analisedeestoque1Click
        end
        object Cadastrodeavarias1: TMenuItem
          Tag = 103
          Caption = 'Cadastro de avarias'
          OnClick = Cadastrodeavarias1Click
        end
        object Consultaarequisies2: TMenuItem
          Tag = 101
          Caption = 'Consulta a requisi'#231#245'es CD'
          OnClick = Consultaarequisies2Click
        end
        object ConsultaarequisioCDporproduto1: TMenuItem
          Tag = 107
          Caption = 'Consulta a requisi'#231#227'o  CD  - por produto'
          OnClick = ConsultaarequisioCDporproduto1Click
        end
        object Mapadeseparao1: TMenuItem
          Tag = 105
          Caption = 'Mapa de separa'#231#227'o'
          OnClick = Mapadeseparao1Click
        end
        object Requisicoentreloas1: TMenuItem
          Tag = 102
          Caption = 'Requisi'#231#227'o entre lojas'
          OnClick = Requisicoentreloas1Click
        end
        object Requisicaoparaocd1: TMenuItem
          Tag = 104
          Caption = 'Requisi'#231#227'o para o CD - vendas/encartes'
          OnClick = Requisicaoparaocd1Click
        end
        object Requisiodereposio1: TMenuItem
          Tag = 108
          Caption = 'Requisi'#231#227'o para o CD - Abastecimento'
          OnClick = Requisiodereposio1Click
        end
        object RequisioparaoCDAbastecimento1: TMenuItem
          Tag = 109
          Caption = 'Requisi'#231#227'o para o CD - Criar OS'
          OnClick = RequisioparaoCDAbastecimento1Click
        end
      end
      object Relatorios1: TMenuItem
        Caption = 'Relat'#243'rios'
        object Relacaodenotasdetransferncia1: TMenuItem
          Tag = 106
          Caption = 'Rela'#231#227'o de notas de  transfer'#234'ncia'
          OnClick = Relacaodenotasdetransferncia1Click
        end
      end
    end
    object compras1: TMenuItem
      Caption = 'Compras'
      object Alterafornpedidodecompra1: TMenuItem
        Tag = 601
        Caption = 'Altera forn pedido de compra'
        OnClick = Alterafornpedidodecompra1Click
      end
      object Classificaodepro1: TMenuItem
        Tag = 602
        Caption = 'Ajuste de categoria dos produtos'
        OnClick = Classificaodepro1Click
      end
      object Cadastrarcodigodebarrasdeproduto1: TMenuItem
        Tag = 603
        Caption = 'Cadastrar EAN de produto'
        OnClick = Cadastrarcodigodebarrasdeproduto1Click
      end
      object CadastrarNCM1: TMenuItem
        Tag = 604
        Caption = 'Cadastrar NCM dos itens de uma nota'
        OnClick = CadastrarNCM1Click
      end
    end
    object Preos1: TMenuItem
      Caption = '&Pre'#231'os'
      object abeladePreos1: TMenuItem
        Caption = 'Funcoes'
        object AjustedePrecos1: TMenuItem
          Tag = 204
          Caption = 'Ajuste de Precos'
          OnClick = AjustedePrecos1Click
        end
        object Descontodepedido1: TMenuItem
          Tag = 205
          Caption = 'Desconto de pedido'
          OnClick = Descontodepedido1Click
        end
        object Geracaopreodecusto1: TMenuItem
          Tag = 206
          Caption = 'Gera'#231#227'o de pre'#231'o de custo'
          OnClick = Geracaopreodecusto1Click
        end
      end
      object Precosalteradosporperodo1: TMenuItem
        Tag = 202
        Caption = 'Relatorios'
        object Precosalteradosporperodo2: TMenuItem
          Tag = 201
          Caption = 'Precos alterados por per'#237'odo'
          OnClick = Precosalteradosporperodo2Click
        end
        object abeladePreos2: TMenuItem
          Tag = 202
          Caption = 'Tabela de Pre'#231'os'
          OnClick = abeladePreos2Click
        end
        object Etiquetas1: TMenuItem
          Tag = 203
          Caption = 'Etiquetas de Codigo de barras'
          OnClick = Etiquetas1Click
        end
        object Listarcustodeitensporpedido1: TMenuItem
          Tag = 207
          Caption = 'Listar custo de itens por pedido'
          OnClick = Listarcustodeitensporpedido1Click
        end
      end
    end
    object Fiscal1: TMenuItem
      Caption = '&Fiscal'
      object Funcoes2: TMenuItem
        Caption = 'Funcoes'
        object Ajustedenotas1: TMenuItem
          Tag = 302
          Caption = 'Ajuste de notas'
          OnClick = Ajustedenotas1Click
        end
        object AjustedoarquivoSPED1: TMenuItem
          Tag = 301
          Caption = 'Ajuste do arquivo SPED'
          OnClick = AjustedoarquivoSPED1Click
        end
        object Comporavendafiscal1: TMenuItem
          Tag = 303
          Caption = 'Compor a venda fiscal'
          OnClick = Comporavendafiscal1Click
        end
        object EnviarXML1: TMenuItem
          Tag = 304
          Caption = 'Enviar XML de NFe por e-mail'
          OnClick = EnviarXML1Click
        end
        object EnviarespelhoPDFdeNFeparaemail1: TMenuItem
          Tag = 307
          Caption = 'Enviar DANFE por e-mail'
          OnClick = EnviarespelhoPDFdeNFeparaemail1Click
        end
        object ImprimirNFe1: TMenuItem
          Tag = 305
          Caption = 'Visualizar DANFE'
          OnClick = ImprimirNFe1Click
        end
        object Saldofiscalpormes1: TMenuItem
          Tag = 306
          Caption = 'Saldo fiscal por mes'
          OnClick = Saldofiscalpormes1Click
        end
        object ImprimirDANFE1: TMenuItem
          Caption = 'Imprimir DANFE'
          OnClick = ImprimirDANFE1Click
        end
        object RegistroSCAN1: TMenuItem
          Tag = 308
          Caption = 'Registro SCAN'
          OnClick = RegistroSCAN1Click
        end
      end
    end
    object Vendas1: TMenuItem
      Caption = '&Vendas'
      object Funcoes1: TMenuItem
        Caption = 'Funcoes'
        object DeletarRegistrodecartoTEF1: TMenuItem
          Tag = 405
          Caption = 'Ajuste de recebimento de caixa'
          OnClick = DeletarRegistrodecartoTEF1Click
        end
        object Cargadedadosparaconciliao1: TMenuItem
          Tag = 407
          Caption = 'Carga de dados para concilia'#231#227'o'
          OnClick = Cargadedadosparaconciliao1Click
        end
        object Propostasdaloja1: TMenuItem
          Tag = 401
          Caption = 'Propostas da loja'
          OnClick = Propostasdaloja1Click
        end
      end
      object Relatorios2: TMenuItem
        Caption = 'Relatorios'
        object AnaliseVLC1: TMenuItem
          Tag = 402
          Caption = 'Analise VLC'
          OnClick = AnaliseVLC1Click
        end
        object EtiquetasDeClientes1: TMenuItem
          Tag = 403
          Caption = 'EtiquetasDeClientes'
          OnClick = EtiquetasDeClientes1Click
        end
        object RelatriodeComisso1: TMenuItem
          Tag = 404
          Caption = 'Relat'#243'rio de Comiss'#227'o'
          OnClick = RelatriodeComisso1Click
        end
        object Pagamentosemcarto1: TMenuItem
          Tag = 406
          Caption = 'Pagamentos em cart'#227'o'
          OnClick = PagamentosEmCartao1Click
        end
      end
    end
    object administrao1: TMenuItem
      Caption = 'Administra'#231#227'o'
      object Permisses1: TMenuItem
        Tag = 501
        Caption = 'Permiss'#245'es'
        OnClick = Permisses2Click
      end
      object RemovevendasregistroTEF1: TMenuItem
        Tag = 502
        Caption = 'Remove vendas registro TEF'
      end
      object Fornecedoresaignorarnarequisio1: TMenuItem
        Tag = 503
        Caption = 'Fornecedores a ignorar na requisi'#231#227'o'
        OnClick = Fornecedoreacriticar1Click
      end
      object Mudafinanceiradeboleto1: TMenuItem
        Tag = 504
        Caption = 'Muda financeira de boleto'
        OnClick = Mudarfinanceiradeboleto1Click
      end
      object MudaversodoBD1: TMenuItem
        Tag = 505
        Caption = 'Muda vers'#227'o do BD'
        OnClick = Setaaversonobd1Click
      end
      object Fichasdefornecedorpordata1: TMenuItem
        Tag = 506
        Caption = 'Fichas de fornecedor por data'
        OnClick = Compromissosdefornecedorespordata1Click
      end
      object parmetrosdosistema1: TMenuItem
        Tag = 507
        Caption = 'Par'#226'metros do sistema'
        OnClick = parmetrosdosistema1Click
      end
    end
    object rocardeUsuario1: TMenuItem
      Caption = 'Trocar de Usu'#225'rio / Loja (F11)'
      ShortCut = 122
      OnClick = rocardeUsuario1Click
    end
    object N1: TMenuItem
      Caption = '  ...  '
      ImageIndex = 0
      ShortCut = 16506
      OnClick = N1Click
    end
  end
  object Conexao: TADOConnection
    ConnectionTimeout = 3
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    OnExecuteComplete = ConexaoExecuteComplete
    OnWillExecute = ConexaoWillExecute
    Left = 16
    Top = 128
  end
  object mxOneInstance1: TmxOneInstance
    SwitchToPrevious = True
    Terminate = True
    Version = '1.2'
    Left = 77
    Top = 128
  end
  object RvProject1: TRvProject
    Engine = RvSystem1
    ProjectFile = 'C:\ProgramasDiversos\RelatoriosPCF.rav'
    Left = 8
    Top = 342
  end
  object RvSystem1: TRvSystem
    TitleSetup = 'Op'#231#245'es de impress'#227'o'
    TitleStatus = 'Status da impress'#227'o'
    TitlePreview = 'Previa da impress'#227'o'
    DefaultDest = rdPrinter
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.FormState = wsMaximized
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'ReportPrinter Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 49
    Top = 344
  end
  object RvDSConn: TRvDataSetConnection
    RuntimeVisibility = rtEndUser
    Left = 80
    Top = 344
  end
  object RvDSConn2: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    Left = 120
    Top = 344
  end
  object Timer1: TTimer
    Left = 194
    Top = 344
  end
  object RvRenderPDF1: TRvRenderPDF
    DisplayName = 'Adobe Acrobat (PDF)'
    FileExtension = '*.pdf'
    EmbedFonts = False
    ImageQuality = 90
    MetafileDPI = 300
    FontEncoding = feWinAnsiEncoding
    DocInfo.Creator = 'Rave (http://www.nevrona.com/rave)'
    DocInfo.Producer = 'Nevrona Designs'
    Left = 157
    Top = 344
  end
end
