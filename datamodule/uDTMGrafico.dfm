object DTMGrafico: TDTMGrafico
  OldCreateOrder = False
  Height = 438
  Width = 651
  object QryProdutoEstoque: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      
        'select convert(varchar, produtoId) +'#39' - '#39'+nome as Label, Quantid' +
        'ade as Value from produtos')
    Params = <>
    Left = 40
    Top = 32
    object QryProdutoEstoqueLabel: TWideStringField
      FieldName = 'Label'
      ReadOnly = True
      Size = 93
    end
    object QryProdutoEstoqueValue: TFloatField
      FieldName = 'Value'
    end
  end
  object dtsProdutoEstoque: TDataSource
    DataSet = QryProdutoEstoque
    Left = 24
    Top = 96
  end
  object QryValorVendaPorCliente: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      
        'select convert(varchar, vendas.clienteID) + '#39' - '#39'+ clientes.nome' +
        ' AS Label, SUM(vendas.totalVenda) as Value'
      'from Vendas'
      #9'INNER JOIN clientes on clientes.clienteId = vendas.clienteId'
      
        #9'where vendas.dataVenda between convert(DATE, GETDATE()-7) and c' +
        'onvert(DATE, GETDATE())'
      #9'group by Vendas.clienteId, clientes.Nome')
    Params = <>
    Left = 152
    Top = 32
    object QryValorVendaPorClienteLabel: TWideStringField
      FieldName = 'Label'
      ReadOnly = True
      Size = 93
    end
    object QryValorVendaPorClienteValue: TFloatField
      FieldName = 'Value'
      ReadOnly = True
    end
  end
  object Qry10ProdutosMaisVendidos: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      
        'SELECT TOP 10 CONVERT(VARCHAR, vi.produtoId) + '#39'-'#39'+ p.nome AS La' +
        'bel, SUM(vi.totalProduto) AS Value'
      '  FROM vendasItens AS vi'
      #9'   INNER JOIN produtos AS P ON p.produtoId = vi.produtoId'
      ' GROUP BY vi.produtoId, p.nome'
      'ORDER BY Label DESC')
    Params = <>
    Left = 288
    Top = 32
    object Qry10ProdutosMaisVendidosLabel: TWideStringField
      FieldName = 'Label'
      ReadOnly = True
      Size = 91
    end
    object Qry10ProdutosMaisVendidosValue: TFloatField
      FieldName = 'Value'
      ReadOnly = True
    end
  end
  object QryVendasUltimasSemana: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT vendas.dataVenda AS Label,'
      #9'   SUM(vendas.totalVenda) AS Value'
      #9'FROM Vendas'
      
        #9'WHERE vendas.dataVenda BETWEEN CONVERT(DATE, GETDATE()-7) and C' +
        'ONVERT(DATE, GETDATE())'
      #9'GROUP BY Vendas.dataVenda')
    Params = <>
    Left = 440
    Top = 32
    object QryVendasUltimasSemanaLabel: TDateTimeField
      FieldName = 'Label'
    end
    object QryVendasUltimasSemanaValue: TFloatField
      FieldName = 'Value'
      ReadOnly = True
    end
  end
end
