unit uProVenda;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  RxToolEdit, RxCurrEdit, uDtmVenda, uEnum, cProVenda, uCadCliente, cFuncao, uConCliente, uCadProduto, uConProduto, uGrid;
type
  TfrmProVenda = class(TfrmTelaHeranca)
    pnlItemVenda: TPanel;
    pnlTotalizador: TPanel;
    Label2: TLabel;
    edtValorTotal: TCurrencyEdit;
    QryListagemvendaId: TIntegerField;
    QryListagemclienteId: TIntegerField;
    QryListagemnome: TWideStringField;
    QryListagemdataVenda: TDateTimeField;
    QryListagemtotalVenda: TFloatField;
    Panel1: TPanel;
    edtVendaId: TLabeledEdit;
    lkpCliente: TDBLookupComboBox;
    Label3: TLabel;
    btnPesquisarCliente: TSpeedButton;
    btnIncluirCliente: TSpeedButton;
    Label1: TLabel;
    edtDataVenda: TDateEdit;
    lkpProduto: TDBLookupComboBox;
    Label4: TLabel;
    btnIncluirProduto: TSpeedButton;
    btnPesquisarProduto: TSpeedButton;
    edtValorUnitario: TCurrencyEdit;
    Label6: TLabel;
    edtQuantidade: TCurrencyEdit;
    Label5: TLabel;
    edtTotalProduto: TCurrencyEdit;
    Label7: TLabel;
    btnAdicionarItem: TBitBtn;
    btnApagarItem: TBitBtn;
    dbgridItensVenda: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgridItensVendaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAdicionarItemClick(Sender: TObject);
    procedure lkpProdutoExit(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure dbgridItensVendaDblClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarItemClick(Sender: TObject);
    procedure btnIncluirClienteClick(Sender: TObject);
    procedure btnPesquisarClienteClick(Sender: TObject);
    procedure btnIncluirProdutoClick(Sender: TObject);
    procedure btnPesquisarProdutoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgridItensVendaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
    dtmVendas: TdtmVendas;
    oVenda:TVenda;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):boolean; override;
    function Apagar:Boolean; override;
    function TotalizarProduto(valorUnitario, Quantidade: Double): Double;
    procedure CarregarRegistroSelecionado;
    procedure LimparComponenteItem;
    procedure LimparCds;
    function TotalizarVenda: Double;
    procedure BloqueiaCTRL_DEL_DBGrid(var Key: Word; Shift: TShiftState);
  public
    { Public declarations }
  end;
var
  frmProVenda: TfrmProVenda;
implementation

{$R *.dfm}

uses uDTMConexao, uPrincipal, uRelProVenda;

{$region 'Override'}
function TfrmProVenda.Apagar: Boolean;
begin
  if oVenda.Selecionar(QryListagem.FieldByName('vendaId').AsInteger, dtmVendas.cdsItensVenda) then
  begin
     Result:=oVenda.Apagar;
  end;
end;

function TfrmProVenda.Gravar(EstadoDoCadastro: TEstadoDoCadastro): boolean;
begin
  Result:= False;
  if edtVendaId.Text<>EmptyStr then
     oVenda.VendaId:=StrToInt(edtVendaId.Text)
  else
     oVenda.VendaId:=0;

  oVenda.ClienteId        :=lkpCliente.KeyValue;
  oVenda.DataVenda        :=edtDataVenda.Date;
  oVenda.TotalVenda       :=edtValorTotal.Value;

  if (EstadoDoCadastro=ecInserir) then
     oVenda.VendaId:= oVenda.Inserir(dtmVendas.cdsItensVenda)
  else
  if (EstadoDoCadastro=ecAlterar) then
     oVenda.Atualizar(dtmVendas.cdsItensVenda);

  frmRelProVenda:=TfrmRelProVenda.Create(self);
  frmRelProVenda.QryVendas.Close;
  frmRelProVenda.QryVendas.ParamByName('VendaId').AsInteger:= oVenda.VendaId;
  frmRelProVenda.QryVendas.Open;

  frmRelProVenda.QryVendasItens.Close;
  frmRelProVenda.QryVendasItens.ParamByName('VendaId').AsInteger:= oVenda.VendaId;
  frmRelProVenda.QryVendasItens.Open;


  frmRelProVenda.Relatorio.PreviewModal;
  frmRelProVenda.Release;

  Result:=true;
end;

procedure TfrmProVenda.lkpProdutoExit(Sender: TObject);
begin
  inherited;
  if lkpProduto.KeyValue<>Null then
  begin
    edtValorUnitario.Value:=dtmVendas.QryProdutos.FieldByName('valor').AsFloat;
    edtQuantidade.Value:=1;
    edtTotalProduto.Value:=TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
  end;
end;

procedure TfrmProVenda.btnIncluirClienteClick(Sender: TObject);
begin
  inherited;
  TFuncao.CriarForm(TfrmCadCliente, oUsuarioLogado, DtmPrincipal.ConexaoDB);
  QryListagem.Refresh;
end;

procedure TfrmProVenda.btnIncluirProdutoClick(Sender: TObject);
begin
  inherited;
  TFuncao.CriarForm(TfrmCadProduto, oUsuarioLogado, DtmPrincipal.ConexaoDB);
  QryListagem.Refresh;
end;

{$endregion}
procedure TfrmProVenda.btnAdicionarItemClick(Sender: TObject);
begin
  inherited;
  if lkpProduto.KeyValue=Null then
  begin
     MessageDlg('Produto � um campo obrigat�rio' ,mtInformation,[mbOK],0);
     lkpProduto.SetFocus;
     abort;
  end;
  if edtValorUnitario.value<=0 then
  begin
     MessageDlg('Valor Unit�rio n�o pode ser Zero' ,mtInformation,[mbOK],0);
     edtValorUnitario.SetFocus;
     abort;
  end;
  if edtQuantidade.value<=0 then
  begin
     MessageDlg('Quantidade n�o pode ser Zero' ,mtInformation,[mbOK],0);
     edtQuantidade.SetFocus;
     abort;
  end;
  if dtmVendas.cdsItensVenda.Locate('produtoId', lkpProduto.KeyValue, []) then
  begin
     MessageDlg('Este Produto j� foi selecionado' ,mtInformation,[mbOK],0);
     lkpProduto.SetFocus;
     abort;
  end;
  edtTotalProduto.Value:=TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
  dtmVendas.cdsItensVenda.Append;
  dtmVendas.cdsItensVenda.FieldByName('produtoId').AsString:=lkpProduto.KeyValue;
  dtmVendas.cdsItensVenda.FieldByName('nomeProduto').AsString:=dtmVendas.QryProdutos.FieldByName('nome').AsString;
  dtmVendas.cdsItensVenda.FieldByName('quantidade').AsFloat:=edtQuantidade.Value;
  dtmVendas.cdsItensVenda.FieldByName('valorUnitario').AsFloat:=edtValorUnitario.Value;
  dtmVendas.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat:=edtTotalProduto.Value;
  dtmVendas.cdsItensVenda.Post;
  edtValorTotal.Value:=TotalizarVenda;
  LimparComponenteItem;
  lkpProduto.SetFocus;
end;

procedure TfrmProVenda.btnAlterarClick(Sender: TObject);
begin
  if oVenda.Selecionar(QryListagem.FieldByName('vendaId').AsInteger, dtmVendas.cdsItensVenda) then
  begin
     edtVendaId.Text     :=IntToStr(oVenda.VendaId);
     lkpCliente.KeyValue :=oVenda.ClienteId;
     edtDataVenda.Date   :=oVenda.DataVenda;
     edtValorTotal.Value :=oVenda.TotalVenda;
  end
  else
  begin
    btnCancelar.Click;
    Abort;
  end;
  inherited;
  dbgridItensVenda.Refresh;
  if FileExists('C:\ProjetoDelphi\Win32\Config\ProdutoDeItensVenda') then
     dbgridItensVenda.Columns.LoadFromFile('C:\ProjetoDelphi\Win32\Config\ProdutoDeItensVenda');
end;

procedure TfrmProVenda.btnApagarItemClick(Sender: TObject);
begin
  inherited;
  if lkpProduto.KeyValue=Null then
  begin
     MessageDlg('Selecione o Produto a ser exclu�do' ,mtInformation,[mbOK],0);
     dbgridItensVenda.SetFocus;
     abort;
  end;
  if dtmVendas.cdsItensVenda.Locate('produtoId', lkpProduto.KeyValue, []) then
  begin
     dtmVendas.cdsItensVenda.Delete;
     LimparComponenteItem;
  end;
  edtValorTotal.Value:=TotalizarVenda;
end;

procedure TfrmProVenda.btnCancelarClick(Sender: TObject);
begin
  inherited;
  LimparCds;
  dbgridItensVenda.Columns.SaveToFile('C:\ProjetoDelphi\Win32\Config\ProdutoDeItensVenda');
end;

procedure TfrmProVenda.btnFecharClick(Sender: TObject);
begin
  inherited;
  dbgridItensVenda.Columns.SaveToFile('C:\ProjetoDelphi\Win32\Config\ProdutoDeItensVenda');
  Close;
end;

procedure TfrmProVenda.btnGravarClick(Sender: TObject);
begin
  inherited;
  LimparCds;
  dbgridItensVenda.Columns.SaveToFile('C:\ProjetoDelphi\Win32\Config\ProdutoDeItensVenda');
end;

procedure TfrmProVenda.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtDataVenda.Date:=Date;
  lkpCliente.SetFocus;
  LimparCds;
  dbgridItensVenda.Refresh;
  if FileExists('C:\ProjetoDelphi\Win32\Config\ProdutoDeItensVenda') then
     dbgridItensVenda.Columns.LoadFromFile('C:\ProjetoDelphi\Win32\Config\ProdutoDeItensVenda');
end;

procedure TfrmProVenda.btnPesquisarClienteClick(Sender: TObject);
begin
  inherited;
  Try
    frmConCliente:=TfrmConCliente.Create(Self);

    if lkpCliente.KeyValue<>Null then
       frmConCliente.aIniciarPesquisaId:=lkpCliente.KeyValue;

    frmConCliente.ShowModal;

    if frmConCliente.aRetornarIdSelecionado<>Unassigned then
       lkpCliente.KeyValue:=frmConCliente.aRetornarIdSelecionado;
  Finally
    frmConCliente.Release;
  End;
end;

procedure TfrmProVenda.btnPesquisarProdutoClick(Sender: TObject);
begin
  inherited;
  Try
    frmConProduto:=TfrmConProduto.Create(Self);

    if lkpProduto.KeyValue<>Null then
       frmConProduto.aIniciarPesquisaId:=lkpProduto.KeyValue;

    frmConProduto.ShowModal;

    if frmConProduto.aRetornarIdSelecionado<>Unassigned then
       lkpProduto.KeyValue:=frmConProduto.aRetornarIdSelecionado;
  Finally
    frmConProduto.Release;
  End;
end;

procedure TfrmProVenda.dbgridItensVendaDblClick(Sender: TObject);
begin
  inherited;
  CarregarRegistroSelecionado;
end;

procedure TfrmProVenda.dbgridItensVendaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  ZebrarGrid(Sender, Rect, DataCol, Column, State);
  FormatarTitulosColunas(dbgridItensVenda);
end;

procedure TfrmProVenda.dbgridItensVendaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  BloqueiaCTRL_DEL_DBGrid(key, shift);
end;

procedure TfrmProVenda.edtQuantidadeExit(Sender: TObject);
begin
  inherited;
  edtTotalProduto.Value:=TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
end;

procedure TfrmProVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(dtmVendas) then
     FreeAndNil(dtmVendas);
  if Assigned(oVenda) then
     FreeAndNil(oVenda);
  grdListagem.Columns.SaveToFile('C:\ProjetoDelphi\Win32\Config\ProdutoDeVenda');
end;

procedure TfrmProVenda.FormCreate(Sender: TObject);
begin
  inherited;
  dtmVendas := TdtmVendas.Create(self);
  oVenda:=TVenda.Create(dtmPrincipal.ConexaoDB);
  IndiceAtual:='nome';
end;

procedure TfrmProVenda.FormShow(Sender: TObject);
begin
  inherited;
  if FileExists('C:\ProjetoDelphi\Win32\Config\ProdutoDeVenda') then
     grdListagem.Columns.LoadFromFile('C:\ProjetoDelphi\Win32\Config\ProdutoDeVenda');
end;

function TfrmProVenda.TotalizarProduto(valorUnitario, Quantidade:Double):Double;
begin
  result :=valorUnitario * Quantidade;
end;

procedure TfrmProVenda.CarregarRegistroSelecionado;
begin
  lkpProduto.KeyValue   := dtmVendas.cdsItensVenda.FieldByName('produtoId').AsString;
  edtQuantidade.Value   := dtmVendas.cdsItensVenda.FieldByName('quantidade').AsFloat;
  edtValorUnitario.Value:= dtmVendas.cdsItensVenda.FieldByName('valorUnitario').AsFloat;
  edtTotalProduto.Value := dtmVendas.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat;
end;

procedure TfrmProVenda.LimparComponenteItem;
begin
  lkpProduto.KeyValue   := null;
  edtQuantidade.Value   := 0;
  edtValorUnitario.Value:= 0;
  edtTotalProduto.Value := 0;
end;

procedure TfrmProVenda.LimparCds;
begin
  dtmVendas.cdsItensVenda.First;
  while not dtmVendas.cdsItensVenda.Eof do
    dtmVendas.cdsItensVenda.Delete;

end;

function TfrmProVenda.TotalizarVenda:Double;
begin
  result:=0;
  dtmVendas.cdsItensVenda.First;
  while not dtmVendas.cdsItensVenda.Eof do
  begin
    result := result + dtmVendas.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat;
    dtmVendas.cdsItensVenda.Next;
  end;
end;

procedure TfrmProVenda.BloqueiaCTRL_DEL_DBGrid(var Key: Word; Shift: TShiftState);
begin
  //Bloqueia CTRL + DEL
  if (Shift = [ssCtrl]) and (Key = 46) then
     Key := 0;
end;
end.
