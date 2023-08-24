object frmRelProVendaPorData: TfrmRelProVendaPorData
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Vendas por Data'
  ClientHeight = 492
  ClientWidth = 1098
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Relatorio: TRLReport
    Left = 0
    Top = 0
    Width = 794
    Height = 1123
    DataSource = dtsVendas
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
      Width = 185
      Height = 16
      Caption = 'Listagem de Venda por Data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Rodape: TRLBand
      Left = 38
      Top = 273
      Width = 718
      Height = 48
      BandType = btFooter
      object RLDraw2: TRLDraw
        Left = 0
        Top = 0
        Width = 718
        Height = 17
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
    object BandaDoGrupo: TRLGroup
      Left = 38
      Top = 97
      Width = 718
      Height = 120
      DataFields = 'dataVenda'
      object RLBand3: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 18
        BandType = btHeader
        Color = clSilver
        ParentColor = False
        Transparent = False
        object RLLabel8: TRLLabel
          Left = 3
          Top = 1
          Width = 43
          Height = 16
          Caption = 'DATA:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLDBText6: TRLDBText
          Left = 174
          Top = 0
          Width = 117
          Height = 16
          DataField = 'DescricaoCategoria'
          DataSource = dtsVendas
          Text = ''
        end
        object RLDBText5: TRLDBText
          Left = 51
          Top = 1
          Width = 66
          Height = 16
          DataField = 'dataVenda'
          DataSource = dtsVendas
          Text = ''
        end
      end
      object RLBand2: TRLBand
        Left = 0
        Top = 18
        Width = 718
        Height = 20
        BandType = btColumnHeader
        Color = clInfoBk
        ParentColor = False
        Transparent = False
        object RLLabel5: TRLLabel
          Left = 2
          Top = 3
          Width = 49
          Height = 16
          Caption = 'C'#243'digo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel4: TRLLabel
          Left = 76
          Top = 4
          Width = 110
          Height = 16
          Caption = 'Nome do Cliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel7: TRLLabel
          Left = 612
          Top = 3
          Width = 103
          Height = 16
          Alignment = taRightJustify
          Caption = 'Valor da Venda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
      end
      object RLBand1: TRLBand
        Left = 0
        Top = 38
        Width = 718
        Height = 20
        object RLDBText1: TRLDBText
          Left = 3
          Top = 0
          Width = 52
          Height = 16
          DataField = 'clienteId'
          DataSource = dtsVendas
          Text = ''
        end
        object RLDBText2: TRLDBText
          Left = 76
          Top = -2
          Width = 36
          Height = 16
          DataField = 'nome'
          DataSource = dtsVendas
          Text = ''
        end
        object RLDBText4: TRLDBText
          Left = 649
          Top = 1
          Width = 66
          Height = 16
          Alignment = taRightJustify
          DataField = 'totalVenda'
          DataSource = dtsVendas
          Text = ''
        end
      end
      object RLBand4: TRLBand
        Left = 0
        Top = 58
        Width = 718
        Height = 31
        BandType = btSummary
        object RLDBResult1: TRLDBResult
          Left = 610
          Top = 7
          Width = 105
          Height = 16
          Alignment = taRightJustify
          DataField = 'totalVenda'
          DataSource = dtsVendas
          Info = riSum
          Text = ''
        end
        object RLDraw3: TRLDraw
          Left = 400
          Top = -4
          Width = 315
          Height = 12
          DrawKind = dkLine
        end
        object RLLabel10: TRLLabel
          Left = 508
          Top = 7
          Width = 94
          Height = 16
          Caption = 'Total por Data'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
      end
    end
    object RLBand5: TRLBand
      Left = 38
      Top = 217
      Width = 718
      Height = 56
      BandType = btSummary
      object RLDBResult2: TRLDBResult
        Left = 610
        Top = 28
        Width = 105
        Height = 16
        Alignment = taRightJustify
        DataField = 'totalVenda'
        DataSource = dtsVendas
        Info = riSum
        Text = ''
      end
      object RLDraw4: TRLDraw
        Left = 480
        Top = 17
        Width = 235
        Height = 12
        DrawKind = dkLine
      end
      object RLLabel6: TRLLabel
        Left = 513
        Top = 28
        Width = 75
        Height = 16
        Caption = 'Total Geral'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
    end
  end
  object QryVendas: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'select vendas.vendaId,'
      '       vendas.clienteId,'
      '       clientes.nome,'
      '       vendas.dataVenda,'
      '       vendas.totalVenda'
      'from vendas'
      
        '     inner join clientes on clientes.clienteId = vendas.clienteI' +
        'd'
      '     where vendas.dataVenda between :DataInicio and :DataFim'
      '     order by vendas.dataVenda, clienteId')
    Params = <
      item
        DataType = ftDate
        Name = 'DataInicio'
        ParamType = ptInput
        Value = '01/08/2023'
      end
      item
        DataType = ftDate
        Name = 'DataFim'
        ParamType = ptInput
        Value = '31/08/2023'
      end>
    Left = 680
    Top = 432
    ParamData = <
      item
        DataType = ftDate
        Name = 'DataInicio'
        ParamType = ptInput
        Value = '01/08/2023'
      end
      item
        DataType = ftDate
        Name = 'DataFim'
        ParamType = ptInput
        Value = '31/08/2023'
      end>
    object QryVendasvendaId: TIntegerField
      FieldName = 'vendaId'
      ReadOnly = True
    end
    object QryVendasclienteId: TIntegerField
      FieldName = 'clienteId'
      Required = True
    end
    object QryVendasnome: TWideStringField
      FieldName = 'nome'
      Size = 60
    end
    object QryVendasdataVenda: TDateTimeField
      FieldName = 'dataVenda'
    end
    object QryVendastotalVenda: TFloatField
      FieldName = 'totalVenda'
    end
  end
  object dtsVendas: TDataSource
    DataSet = QryVendas
    Left = 728
    Top = 424
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport Community Edition v4.0 \251 Copyright '#169' 1999-2016 F' +
      'ortes Inform'#225'tica'
    DisplayName = 'Documento PDF'
    Left = 712
    Top = 376
  end
  object RLXLSFilter1: TRLXLSFilter
    DisplayName = 'Planilha Excel 97-2013'
    Left = 672
    Top = 384
  end
  object RLXLSXFilter1: TRLXLSXFilter
    DisplayName = 'Planilha Excel'
    Left = 632
    Top = 416
  end
end
