inherited frmConSubCategoria: TfrmConSubCategoria
  Caption = 'Consulta SubCategoria'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    ExplicitWidth = 777
    inherited mskPesquisa: TMaskEdit
      ExplicitWidth = 775
    end
  end
  inherited Panel2: TPanel
    ExplicitWidth = 780
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
          FieldName = 'subCategoriaId'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DescricaoCategoria'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descricao'
          Visible = True
        end>
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT s.subCategoriaId,'
      '       s.categoriaId,'
      '       s.descricao,'
      '       c.descricao as DescricaoCategoria'
      '  FROM subCategorias s'
      '  LEFT JOIN categorias AS c ON c.categoriaId = s.categoriaId')
    object QryListagemsubCategoriaId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'subCategoriaId'
      ReadOnly = True
    end
    object QryListagemcategoriaId: TIntegerField
      FieldName = 'categoriaId'
      Required = True
    end
    object QryListagemdescricao: TWideStringField
      DisplayLabel = 'SubCategoria'
      FieldName = 'descricao'
      Size = 50
    end
    object QryListagemDescricaoCategoria: TWideStringField
      DisplayLabel = 'Categoria'
      FieldName = 'DescricaoCategoria'
      Size = 30
    end
  end
end
