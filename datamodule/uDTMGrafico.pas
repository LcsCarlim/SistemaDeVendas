unit uDTMGrafico;

interface

uses
  System.SysUtils, System.Classes, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TDTMGrafico = class(TDataModule)
    QryProdutoEstoque: TZQuery;
    dtsProdutoEstoque: TDataSource;
    QryProdutoEstoqueLabel: TWideStringField;
    QryProdutoEstoqueValue: TFloatField;
    QryValorVendaPorCliente: TZQuery;
    QryValorVendaPorClienteLabel: TWideStringField;
    QryValorVendaPorClienteValue: TFloatField;
    Qry10ProdutosMaisVendidos: TZQuery;
    Qry10ProdutosMaisVendidosLabel: TWideStringField;
    Qry10ProdutosMaisVendidosValue: TFloatField;
    QryVendasUltimasSemana: TZQuery;
    QryVendasUltimasSemanaLabel: TDateTimeField;
    QryVendasUltimasSemanaValue: TFloatField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DTMGrafico: TDTMGrafico;

implementation

uses
  uDTMConexao;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
