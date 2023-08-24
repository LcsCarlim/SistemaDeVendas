object frmRelCadProduto: TfrmRelCadProduto
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Produto'
  ClientHeight = 399
  ClientWidth = 1098
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Relatorio: TRLReport
    Left = 0
    Top = 0
    Width = 794
    Height = 1123
    DataSource = dtsProdutos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object Cabecalho: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 59
      BandType = btHeader
      object RLDraw1: TRLDraw
        Left = 0
        Top = 49
        Width = 718
        Height = 10
        Align = faBottom
        DrawKind = dkLine
        Pen.Width = 2
      end
    end
    object RLLabel1: TRLLabel
      Left = 41
      Top = 56
      Width = 142
      Height = 16
      Caption = 'Listagem de Produtos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Rodape: TRLBand
      Left = 38
      Top = 137
      Width = 718
      Height = 48
      BandType = btFooter
      object RLDraw2: TRLDraw
        Left = 0
        Top = 0
        Width = 718
        Height = 10
        Align = faTop
        DrawKind = dkLine
        Pen.Width = 2
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 3
        Top = 16
        Width = 60
        Height = 16
        Info = itFullDate
        Text = ''
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 689
        Top = 29
        Width = 18
        Height = 16
        Alignment = taRightJustify
        Info = itPageNumber
        Text = ''
      end
      object RLSystemInfo3: TRLSystemInfo
        Left = 690
        Top = 29
        Width = 30
        Height = 16
        Alignment = taRightJustify
        Info = itLastPageNumber
        Text = ''
      end
      object RLLabel2: TRLLabel
        Left = 702
        Top = 29
        Width = 14
        Height = 16
        Caption = '/'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel3: TRLLabel
        Left = 633
        Top = 29
        Width = 53
        Height = 16
        Caption = 'P'#225'gina:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object RLBand1: TRLBand
      Left = 38
      Top = 117
      Width = 718
      Height = 20
      object RLDBText1: TRLDBText
        Left = 3
        Top = 0
        Width = 57
        Height = 16
        DataField = 'produtoId'
        DataSource = dtsProdutos
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 76
        Top = 0
        Width = 38
        Height = 16
        DataField = 'Nome'
        DataSource = dtsProdutos
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 421
        Top = 0
        Width = 70
        Height = 16
        Alignment = taRightJustify
        DataField = 'Quantidade'
        DataSource = dtsProdutos
        Text = ''
      end
      object RLDBText4: TRLDBText
        Left = 681
        Top = 1
        Width = 34
        Height = 16
        Alignment = taRightJustify
        DataField = 'Valor'
        DataSource = dtsProdutos
        Text = ''
      end
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 97
      Width = 718
      Height = 20
      BandType = btColumnHeader
      object RLPanel1: TRLPanel
        Left = 0
        Top = 0
        Width = 718
        Height = 20
        Align = faClient
        Color = clInfoBk
        ParentColor = False
        Transparent = False
        object RLLabel4: TRLLabel
          Left = 75
          Top = 1
          Width = 115
          Height = 16
          Caption = 'Nome do Produto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel6: TRLLabel
          Left = 339
          Top = 1
          Width = 152
          Height = 16
          Caption = 'Quantidade de Estoque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel7: TRLLabel
          Left = 677
          Top = 1
          Width = 38
          Height = 16
          Alignment = taRightJustify
          Caption = 'Valor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object RLLabel5: TRLLabel
        Left = 3
        Top = 1
        Width = 49
        Height = 16
        Caption = 'C'#243'digo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object QryProdutos: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      'select produtos.produtoId,'
      '       produtos.Nome,'
      '       produtos.Valor,'
      '       produtos.Quantidade'
      '  from produtos'
      ' order by Nome')
    Params = <>
    Left = 688
    Top = 328
    object QryProdutosprodutoId: TIntegerField
      FieldName = 'produtoId'
      ReadOnly = True
    end
    object QryProdutosNome: TWideStringField
      FieldName = 'Nome'
      Size = 60
    end
    object QryProdutosValor: TFloatField
      FieldName = 'Valor'
      DisplayFormat = '#0.00'
    end
    object QryProdutosQuantidade: TFloatField
      FieldName = 'Quantidade'
      DisplayFormat = '#0.00'
    end
  end
  object dtsProdutos: TDataSource
    DataSet = QryProdutos
    Left = 728
    Top = 328
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport Community Edition v4.0 \251 Copyright '#169' 1999-2016 F' +
      'ortes Inform'#225'tica'
    DisplayName = 'Documento PDF'
    Left = 712
    Top = 288
  end
  object RLXLSFilter1: TRLXLSFilter
    DisplayName = 'Planilha Excel 97-2013'
    Left = 680
    Top = 288
  end
  object RLXLSXFilter1: TRLXLSXFilter
    DisplayName = 'Planilha Excel'
    Left = 616
    Top = 320
  end
end
