unit uConCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHerancaConsulta, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, uGrid;

type
  TfrmConCategoria = class(TfrmTelaHerancaConsulta)
    QryListagemcategoriaId: TIntegerField;
    QryListagemdescricao: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdPesquisaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConCategoria: TfrmConCategoria;

implementation

{$R *.dfm}

procedure TfrmConCategoria.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmConCategoria.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  grdPesquisa.Columns.SaveToFile('C:\ProjetoDelphi\Win32\Config\ConsultaDeCategoria');
end;

procedure TfrmConCategoria.FormCreate(Sender: TObject);
begin
  aCampoId :='categoriaId';
  IndiceAtual :='descricao';
  inherited;

end;

procedure TfrmConCategoria.FormShow(Sender: TObject);
begin
  inherited;
  if FileExists('C:\ProjetoDelphi\Win32\Config\ConsultaDeCategoria') then
     grdPesquisa.Columns.LoadFromFile('C:\ProjetoDelphi\Win32\Config\ConsultaDeCategoria');
end;

procedure TfrmConCategoria.grdPesquisaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  ZebrarGrid(Sender, Rect, DataCol, Column, State);
  FormatarTitulosColunas(grdPesquisa);
end;

end.
