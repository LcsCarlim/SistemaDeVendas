inherited frmConCliente: TfrmConCliente
  Caption = 'Consulta de Clientes'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    ExplicitWidth = 777
    inherited mskPesquisa: TMaskEdit
      ExplicitWidth = 775
    end
  end
  inherited Panel2: TPanel
    inherited btnFechar: TBitBtn
      OnClick = btnFecharClick
      ExplicitLeft = 693
    end
  end
  inherited Panel3: TPanel
    ExplicitWidth = 777
    inherited grdPesquisa: TDBGrid
      OnDrawColumnCell = grdPesquisaDrawColumnCell
      Columns = <
        item
          Expanded = False
          FieldName = 'clienteId'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome'
          Visible = True
        end>
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT clienteId,'
      '       nome'
      '  FROM clientes'
      '')
    object QryListagemclienteId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'clienteId'
      ReadOnly = True
    end
    object QryListagemnome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
  end
end
