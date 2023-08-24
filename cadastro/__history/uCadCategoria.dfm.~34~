inherited frmCadCategoria: TfrmCadCategoria
  Caption = 'Cadastro de categorias'
  ClientWidth = 772
  ExplicitWidth = 778
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 772
    ExplicitWidth = 772
    inherited tabListagem: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 764
      ExplicitHeight = 370
      inherited pnlListagem: TPanel
        Width = 764
        ExplicitWidth = 764
        inherited lblIndice: TLabel
          Margins.Bottom = 0
        end
      end
      inherited grdListagem: TDBGrid
        Width = 764
        DataSource = dtsListagem
        Columns = <
          item
            Expanded = False
            FieldName = 'categoriaId'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 764
      ExplicitHeight = 370
      object edtCategoriaId: TLabeledEdit
        Tag = 1
        Left = 3
        Top = 40
        Width = 121
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
      end
      object edtDescricao: TLabeledEdit
        Tag = 2
        Left = 3
        Top = 96
        Width = 345
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Descri'#231#227'o'
        MaxLength = 30
        TabOrder = 1
      end
    end
  end
  inherited pnlRodaPe: TPanel
    Width = 772
    ExplicitWidth = 772
    DesignSize = (
      772
      41)
    inherited btnFechar: TBitBtn
      Left = 685
      ExplicitLeft = 685
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT categoriaId,'
      #9'   descricao'
      #9'FROM categorias')
    object QryListagemcategoriaId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'categoriaId'
      ReadOnly = True
    end
    object QryListagemdescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 30
    end
  end
end
