unit uConSubCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHerancaConsulta, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, uGrid;

type
  TfrmConSubCategoria = class(TfrmTelaHerancaConsulta)
    QryListagemsubCategoriaId: TIntegerField;
    QryListagemcategoriaId: TIntegerField;
    QryListagemdescricao: TWideStringField;
    QryListagemDescricaoCategoria: TWideStringField;
    procedure btnFecharClick(Sender: TObject);
    procedure grdPesquisaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConSubCategoria: TfrmConSubCategoria;

implementation

{$R *.dfm}

procedure TfrmConSubCategoria.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmConSubCategoria.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  grdPesquisa.Columns.SaveToFile('C:\ProjetoDelphi\Win32\Config\ConsultaDeSubCategoria');
end;

procedure TfrmConSubCategoria.FormCreate(Sender: TObject);
begin
  inherited;
  aCampoId :='subCategoriaId';
  IndiceAtual :='descricao';
end;

procedure TfrmConSubCategoria.FormShow(Sender: TObject);
begin
  inherited;
  if FileExists('C:\ProjetoDelphi\Win32\Config\ConsultaDeSubCategoria') then
     grdPesquisa.Columns.LoadFromFile('C:\ProjetoDelphi\Win32\Config\ConsultaDeSubCategoria');
end;

procedure TfrmConSubCategoria.grdPesquisaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
begin
  inherited;
  ZebrarGrid(Sender, Rect, DataCol, Column, State);
  FormatarTitulosColunas(grdPesquisa);
end;

end.
