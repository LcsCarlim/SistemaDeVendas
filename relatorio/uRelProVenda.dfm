object frmRelProVenda: TfrmRelProVenda
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Vendas'
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
      Width = 48
      Height = 16
      Caption = 'VENDA'
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
      DataFields = 'vendaId'
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
          Top = -1
          Width = 52
          Height = 16
          Caption = 'VENDA:'
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
          Width = 52
          Height = 16
          DataField = 'clienteId'
          DataSource = dtsVendas
          Text = ''
        end
        object RLDBText5: TRLDBText
          Left = 51
          Top = -1
          Width = 47
          Height = 16
          DataField = 'vendaId'
          DataSource = dtsVendas
          Text = ''
        end
      end
      object RLBand1: TRLBand
        Left = 0
        Top = 18
        Width = 718
        Height = 20
        object RLDBText1: TRLDBText
          Left = 118
          Top = 2
          Width = 36
          Height = 16
          DataField = 'nome'
          DataSource = dtsVendas
          Text = ''
        end
        object RLDBText2: TRLDBText
          Left = 57
          Top = 3
          Width = 52
          Height = 16
          DataField = 'clienteId'
          DataSource = dtsVendas
          Text = ''
        end
        object RLDBText4: TRLDBText
          Left = 649
          Top = 1
          Width = 66
          Height = 16
          Alignment = taRightJustify
          DataField = 'dataVenda'
          DataSource = dtsVendas
          Text = ''
        end
        object RLLabel4: TRLLabel
          Left = 3
          Top = 3
          Width = 53
          Height = 16
          Caption = 'Cliente:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel9: TRLLabel
          Left = 103
          Top = 0
          Width = 8
          Height = 16
          Caption = '-'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel7: TRLLabel
          Left = 606
          Top = 1
          Width = 37
          Height = 16
          Alignment = taRightJustify
          Caption = 'Data:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
      end
      object RLSubDetail1: TRLSubDetail
        Left = 0
        Top = 38
        Width = 718
        Height = 64
        DataSource = dtsVendasItens
        object RLBand2: TRLBand
          Left = 0
          Top = 0
          Width = 718
          Height = 17
          BandType = btHeader
          Color = clInfoBk
          ParentColor = False
          Transparent = False
          object RLLabel10: TRLLabel
            Left = 3
            Top = 1
            Width = 81
            Height = 16
            Caption = 'PRODUTOS:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel11: TRLLabel
            Left = 385
            Top = 1
            Width = 78
            Height = 16
            Caption = 'Quantidade'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel12: TRLLabel
            Left = 469
            Top = 1
            Width = 92
            Height = 16
            Caption = 'Valor Unit'#225'rio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel13: TRLLabel
            Left = 577
            Top = 0
            Width = 74
            Height = 16
            Caption = 'Valor Total'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
        end
        object RLBand4: TRLBand
          Left = 0
          Top = 17
          Width = 718
          Height = 16
          object RLDBText3: TRLDBText
            Left = 3
            Top = 0
            Width = 57
            Height = 16
            DataField = 'produtoId'
            DataSource = dtsVendasItens
            Text = ''
          end
          object RLLabel5: TRLLabel
            Left = 47
            Top = -1
            Width = 8
            Height = 16
            Caption = '-'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLDBText7: TRLDBText
            Left = 61
            Top = 0
            Width = 38
            Height = 16
            DataField = 'Nome'
            DataSource = dtsVendasItens
            Text = ''
          end
          object RLDBText8: TRLDBText
            Left = 396
            Top = 0
            Width = 67
            Height = 16
            Alignment = taRightJustify
            DataField = 'quantidade'
            DataSource = dtsVendasItens
            Text = ''
          end
          object RLDBText9: TRLDBText
            Left = 487
            Top = 0
            Width = 74
            Height = 16
            Alignment = taRightJustify
            DataField = 'valorUnitario'
            DataSource = dtsVendasItens
            Text = ''
          end
          object RLDBText10: TRLDBText
            Left = 577
            Top = 0
            Width = 74
            Height = 16
            Alignment = taRightJustify
            DataField = 'totalProduto'
            DataSource = dtsVendasItens
            Text = ''
          end
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
        Width = 105
        Height = 16
        Caption = 'Total da Venda:'
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
    Active = True
    SQL.Strings = (
      'select vendas.vendaId,'
      '       vendas.clienteId,'
      '       clientes.nome,'
      '       vendas.dataVenda,'
      '       vendas.totalVenda'
      'from   vendas'
      
        '     inner join clientes on clientes.clienteId = vendas.clienteI' +
        'd'
      '     where vendas.vendaId =:vendaId')
    Params = <
      item
        DataType = ftInteger
        Name = 'vendaId'
        ParamType = ptInput
        Value = 1
      end>
    Left = 224
    Top = 336
    ParamData = <
      item
        DataType = ftInteger
        Name = 'vendaId'
        ParamType = ptInput
        Value = 1
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
      DisplayFormat = 'dd/mm/yyyy'
    end
    object QryVendastotalVenda: TFloatField
      FieldName = 'totalVenda'
      DisplayFormat = '#0.00'
    end
  end
  object dtsVendas: TDataSource
    DataSet = QryVendas
    Left = 280
    Top = 344
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
  object QryVendasItens: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      'select vendasItens.vendaId,'
      '       vendasItens.produtoId,'
      '       produtos.Nome,'
      '       vendasItens.quantidade,'
      '       vendasItens.valorUnitario,'
      '       vendasItens.totalProduto'
      'from   vendasItens'
      
        '     inner join produtos on produtos.produtoId = vendasItens.pro' +
        'dutoId'
      '     where vendasItens.vendaId =:vendaId'
      '     order by vendasItens.produtoId')
    Params = <
      item
        DataType = ftInteger
        Name = 'vendaId'
        ParamType = ptInput
        Value = 1
      end>
    Left = 232
    Top = 392
    ParamData = <
      item
        DataType = ftInteger
        Name = 'vendaId'
        ParamType = ptInput
        Value = 1
      end>
    object QryVendasItensvendaId: TIntegerField
      FieldName = 'vendaId'
      Required = True
    end
    object QryVendasItensprodutoId: TIntegerField
      FieldName = 'produtoId'
      Required = True
    end
    object QryVendasItensNome: TWideStringField
      FieldName = 'Nome'
      Size = 60
    end
    object QryVendasItensquantidade: TFloatField
      FieldName = 'quantidade'
    end
    object QryVendasItensvalorUnitario: TFloatField
      FieldName = 'valorUnitario'
    end
    object QryVendasItenstotalProduto: TFloatField
      FieldName = 'totalProduto'
    end
  end
  object dtsVendasItens: TDataSource
    DataSet = QryVendasItens
    Left = 280
    Top = 400
  end
end
