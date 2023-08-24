unit uConProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHerancaConsulta, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, uGrid;

type
  TfrmConProduto = class(TfrmTelaHerancaConsulta)
    QryListagemprodutoId: TIntegerField;
    QryListagemnome: TWideStringField;
    QryListagemquantidade: TFloatField;
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
  frmConProduto: TfrmConProduto;

implementation

{$R *.dfm}

procedure TfrmConProduto.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmConProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  grdPesquisa.Columns.SaveToFile('C:\ProjetoDelphi\Win32\Config\ConsultaDeProduto');
end;

procedure TfrmConProduto.FormCreate(Sender: TObject);
begin
  aCampoId :='produtoId';
  IndiceAtual :='nome';
  inherited;

end;

procedure TfrmConProduto.FormShow(Sender: TObject);
begin
  inherited;
  if FileExists('C:\ProjetoDelphi\Win32\Config\ConsultaDeProduto') then
     grdPesquisa.Columns.LoadFromFile('C:\ProjetoDelphi\Win32\Config\ConsultaDeProduto');
end;

procedure TfrmConProduto.grdPesquisaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  ZebrarGrid(Sender, Rect, DataCol, Column, State);
  FormatarTitulosColunas(grdPesquisa);
end;

end.
