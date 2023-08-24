unit uConCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHerancaConsulta, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, uGrid;

type
  TfrmConCliente = class(TfrmTelaHerancaConsulta)
    QryListagemclienteId: TIntegerField;
    QryListagemnome: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure grdPesquisaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConCliente: TfrmConCliente;

implementation

{$R *.dfm}

procedure TfrmConCliente.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmConCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  grdPesquisa.Columns.SaveToFile('C:\ProjetoDelphi\Win32\Config\ConsultaDeCliente');
end;

procedure TfrmConCliente.FormCreate(Sender: TObject);
begin
  aCampoId :='clienteId';
  IndiceAtual :='nome';
  inherited;

end;

procedure TfrmConCliente.FormShow(Sender: TObject);
begin
  inherited;
  if FileExists('C:\ProjetoDelphi\Win32\Config\ConsultaDeCliente') then
     grdPesquisa.Columns.LoadFromFile('C:\ProjetoDelphi\Win32\Config\ConsultaDeCliente');
end;

procedure TfrmConCliente.grdPesquisaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  ZebrarGrid(Sender, Rect, DataCol, Column, State);
  FormatarTitulosColunas(grdPesquisa);
end;

end.
