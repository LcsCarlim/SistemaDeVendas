unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDTMConexao, Enter,
  ufrmAtualizaDB, ShellApi, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, uUsuariosVsAcoes,
  VclTee.TeeGDIPlus, Data.DB, VCLTee.Series, VCLTee.TeEngine, VCLTee.TeeProcs,
  VCLTee.Chart, VCLTee.DBChart, ZDbcIntfs, RLReport,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cUsuarioLogado, Vcl.Imaging.pngimage, cAtualizacaoBancoDeDados, cFuncao;

type
  TfrmPrincipal = class(TForm)
    mainMenu: TMainMenu;
    CADASTRO1: TMenuItem;
    MOVIMENTAO1: TMenuItem;
    RELATRIOS1: TMenuItem;
    CLIENTE1: TMenuItem;
    N1: TMenuItem;
    CATEGORIA1: TMenuItem;
    PRODUTO1: TMenuItem;
    N2: TMenuItem;
    mnuFechar: TMenuItem;
    VENDA1: TMenuItem;
    CLIENTE2: TMenuItem;
    N3: TMenuItem;
    PRODUTO2: TMenuItem;
    N4: TMenuItem;
    VENDAPORDATA1: TMenuItem;
    CATEGORIA2: TMenuItem;
    FICHADECLIENTE1: TMenuItem;
    PRODUTOSPORCATEGORIA1: TMenuItem;
    USURIO1: TMenuItem;
    N5: TMenuItem;
    ALTERARSENHA1: TMenuItem;
    stbPrincipal: TStatusBar;
    AO1: TMenuItem;
    N6: TMenuItem;
    USURIOSVSAES1: TMenuItem;
    N7: TMenuItem;
    pnlDashBoard: TPanel;
    GridPanel1: TGridPanel;
    pnlProdutoEstoque: TPanel;
    pnlVendaProClienteUltimaSemana: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    DBChart1: TDBChart;
    Series1: TBarSeries;
    DBChart2: TDBChart;
    Series2: TPieSeries;
    DBChart3: TDBChart;
    PieSeries1: TPieSeries;
    DBChart4: TDBChart;
    Series3: TFastLineSeries;
    tmrAtualizacaoDashBoard: TTimer;
    SUBCATEGORIA1: TMenuItem;
    procedure mnuFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CATEGORIA1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CLIENTE1Click(Sender: TObject);
    procedure PRODUTO1Click(Sender: TObject);
    procedure VENDA1Click(Sender: TObject);
    procedure CATEGORIA2Click(Sender: TObject);
    procedure CLIENTE2Click(Sender: TObject);
    procedure FICHADECLIENTE1Click(Sender: TObject);
    procedure PRODUTO2Click(Sender: TObject);
    procedure PRODUTOSPORCATEGORIA1Click(Sender: TObject);
    procedure VENDAPORDATA1Click(Sender: TObject);
    procedure USURIO1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ALTERARSENHA1Click(Sender: TObject);
    procedure AO1Click(Sender: TObject);
    procedure USURIOSVSAES1Click(Sender: TObject);
    procedure pnlDashBoardClick(Sender: TObject);
    procedure SUBCATEGORIA1Click(Sender: TObject);
  private
    { Private declarations }
    TeclaEnter: TMREnter;
    procedure AtualizacaoBancoDados(aForm: TfrmAtualizaDB);
    procedure AtualizarDashBoard;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;
  oUsuarioLogado:TUsuarioLogado;

implementation

{$R *.dfm}

uses uCadCategoria, uCadCliente, uCadProduto, uProVenda, uRelCategoria,
  uRelCadProduto, uRelCadProdutoComGrupoCategoria, uRelCadCliente,
  uRelCadClienteFicha, uRelVendaPorData, uSelecionarData, uCadUsuario, uLogin, uAlterarSenha, cArquivoIni, uCadAcaoAcesso,
  cAcaoAcesso, uTelaHeranca, uDTMGrafico, uCadSubCategoria;

procedure TfrmPrincipal.CATEGORIA1Click(Sender: TObject);
begin
  Tfuncao.CriarForm(TfrmCadCategoria, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.CATEGORIA2Click(Sender: TObject);
begin
  Tfuncao.CriarRelatorio(TfrmRelCategoria, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.CLIENTE1Click(Sender: TObject);
begin
  Tfuncao.CriarForm(TfrmCadCliente, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.CLIENTE2Click(Sender: TObject);
begin
  Tfuncao.CriarRelatorio(TfrmRelCadCliente, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.FICHADECLIENTE1Click(Sender: TObject);
begin
  Tfuncao.CriarRelatorio(TfrmRelCadClienteFicha, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(TeclaEnter);
  FreeAndNil(dtmPrincipal);
  FreeAndNil(DTMGrafico);

  if Assigned(oUsuarioLogado) then
     FreeAndNil(oUsuarioLogado);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  if not FileExists(TArquivoIni.ArquivoIni) then
  begin
    TArquivoIni.AtualizarIni('SERVER', 'TipoDataBase', 'MSSQL');
    TArquivoIni.AtualizarIni('SERVER', 'HostName',     '.\');
    TArquivoIni.AtualizarIni('SERVER', 'Port',         '1433');
    TArquivoIni.AtualizarIni('SERVER', 'User',         'sa');
    TArquivoIni.AtualizarIni('SERVER', 'Password',     'domtec@10');
    TArquivoIni.AtualizarIni('SERVER', 'Database',     'vendas');

    MessageDlg('Arquivo '+ TArquivoIni.ArquivoIni +' Criado com sucesso'+#13+
              ' Configure o arquivo antes de inicializar aplica��o',MtInformation,[mbok],0);

    Application.Terminate;
  end
  else
  begin
    frmAtualizaDB:=TfrmAtualizaDB.Create(Self);
    frmAtualizaDB.Show;
    frmAtualizaDB.Refresh;

    dtmPrincipal :=TdtmPrincipal.Create(Self);
    with dtmPrincipal.ConexaoDB do
    begin
      Connected:=false;
      SQLHourGlass:=False;
      if TArquivoIni.LerIni('SERVER', 'TipoDataBase')='MSSQL' then
         Protocol:= 'mssql';

      LibraryLocation:='C:\ProjetoDelphi\ntwdblib.dll';
      HostName:=TArquivoIni.LerIni('SERVER','HostName');
      Port:=StrToInt(TArquivoIni.LerIni('SERVER','Port'));
      User:=TArquivoIni.LerIni('SERVER','User');
      Password:=TArquivoIni.LerIni('SERVER','Password');
      Database:=TArquivoIni.LerIni('SERVER','Database');
      AutoCommit:= True;
      TransactIsolationLevel:=tiReadCommitted;
      Connected:=true;
    end;
    AtualizacaoBancoDados(frmAtualizaDB);

    TAcaoAcesso.CriarAcoes(TfrmCadCategoria,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadCliente,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadProduto,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadUsuario,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadAcaoAcesso,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmAlterarSenha,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmProVenda,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelProVendaPorData,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCadClienteFicha,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCadCliente,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCadProdutoComGrupoCategoria,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCadProduto,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCategoria,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmUsuarioVsAcoes,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmSelecionarData,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadSubCategoria,DtmPrincipal.ConexaoDB);

    TAcaoAcesso.PreencherUsuariosVsAcoes(DtmPrincipal.ConexaoDB);

    DTMGrafico:=TDTMGrafico.Create(self);
    AtualizarDashBoard;

    frmAtualizaDB.Free;

    TeclaEnter:= TMREnter.Create(Self);
    TeclaEnter.FocusEnabled:=true;
    TeclaEnter.FocusColor:=clinfoBk;
  end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
try
  oUsuarioLogado:=TUsuarioLogado.Create;

  frmLogin:=TfrmLogin.Create(Self);
  frmLogin.ShowModal;
finally
  frmLogin.Release;
  StbPrincipal.Panels[0].Text:='USU�RIO: '+oUsuariologado.nome;
end;

end;

procedure TfrmPrincipal.mnuFecharClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.pnlDashBoardClick(Sender: TObject);
begin
  AtualizarDashBoard;
end;

procedure TfrmPrincipal.PRODUTO1Click(Sender: TObject);
begin
  Tfuncao.CriarForm(TfrmCadProduto, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.PRODUTO2Click(Sender: TObject);
begin
  Tfuncao.CriarRelatorio(TfrmRelCadProduto, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.PRODUTOSPORCATEGORIA1Click(Sender: TObject);
begin
  Tfuncao.CriarRelatorio(TfrmRelCadProdutoComGrupoCategoria, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.SUBCATEGORIA1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmCadSubCategoria, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.USURIO1Click(Sender: TObject);
begin
  Tfuncao.CriarForm(TfrmCadUsuario, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.USURIOSVSAES1Click(Sender: TObject);
begin
  Tfuncao.CriarForm(TfrmUsuarioVsAcoes, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.VENDA1Click(Sender: TObject);
begin
  Tfuncao.CriarForm(TfrmProVenda, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.VENDAPORDATA1Click(Sender: TObject);
begin
  Try
    frmSelecionarData:=TfrmSelecionarData.Create(self);
    if TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, frmSelecionarData.Name, DtmPrincipal.ConexaoDB) then
    begin
      frmSelecionarData.ShowModal;

      frmRelProVendaPorData:=TfrmRelProVendaPorData.Create(self);
      frmRelProVendaPorData.QryVendas.Close;
      frmRelProVendaPorData.QryVendas.ParamByName('DataInicio').AsDate:=frmSelecionarData.EdtDataInicio.Date;
      frmRelProVendaPorData.QryVendas.ParamByName('DataFim').AsDate:=frmSelecionarData.EdtDataFinal.Date;
      frmRelProVendaPorData.QryVendas.Open;
      frmRelProVendaPorData.Relatorio.PreviewModal;
    end
    else
    begin
      MessageDlg('Usu�rio: '+oUsuarioLogado.nome +', n�o tem permiss�o de acesso',mtWarning,[mbOK],0);
    end;
  Finally
    if Assigned(frmSelecionarData) then
       frmSelecionarData.Release;
    if Assigned(frmRelProVendaPorData) then
       frmRelProVendaPorData.Release;
  End;
end;

procedure TfrmPrincipal.ALTERARSENHA1Click(Sender: TObject);
begin
  Tfuncao.CriarForm(TfrmAlterarSenha, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.AO1Click(Sender: TObject);
begin
  Tfuncao.CriarForm(TfrmCadAcaoAcesso, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.AtualizacaoBancoDados(aForm:TfrmAtualizaDB);
var oAtualizarMSSQL:TAtualizaBancoDadosMSSQL;
begin
  aForm.Refresh;

  try
    oAtualizarMSSQL:=TAtualizaBancoDadosMSSQL.Create(DtmPrincipal.ConexaoDB);
    oAtualizarMSSQL.AtualizarBancoDeDadosMSSQL;
  finally
    if Assigned(oAtualizarMSSQL) then
       FreeAndNil(oAtualizarMSSQL);
  end;
{
  DtmPrincipal.QryScriptCategorias.ExecSQL;
  aForm.chkCategoria.Checked := True;
  aForm.Refresh;
  Sleep(100);

  DtmPrincipal.QryScriptProdutos.ExecSQL;
  aForm.chkProduto.Checked := True;
  aForm.Refresh;
  Sleep(100);

  DtmPrincipal.QryScriptClientes.ExecSQL;
  aForm.chkCliente.Checked := True;
  aForm.Refresh;
  Sleep(100);

  DtmPrincipal.QryScriptVendas.ExecSQL;
  aForm.chkVendas.Checked := True;
  aForm.Refresh;
  Sleep(100);

  DtmPrincipal.QryScriptItensVendas.ExecSQL;
  aForm.chkItensVenda.Checked := True;
  aForm.Refresh;
  Sleep(100);

  DtmPrincipal.QryScriptUsuarios.ExecSQL;
  aForm.chkUsuarios.Checked := True;
  aForm.Refresh;
  Sleep(100);
}
end;

procedure TfrmPrincipal.AtualizarDashBoard;
begin
  Try
    Screen.Cursor:=crSQLWait;
    if DTMGrafico.QryProdutoEstoque.Active then
     DTMGrafico.QryProdutoEstoque.Close;

    if DTMGrafico.QryValorVendaPorCliente.Active then
       DTMGrafico.QryValorVendaPorCliente.Close;

    if DTMGrafico.QryVendasUltimasSemana.Active then
       DTMGrafico.QryVendasUltimasSemana.Close;

    if DTMGrafico.Qry10ProdutosMaisVendidos.Active then
       DTMGrafico.Qry10ProdutosMaisVendidos.Close;

    DTMGrafico.QryProdutoEstoque.Open;
    DTMGrafico.QryValorVendaPorCliente.Open;
    DTMGrafico.QryVendasUltimasSemana.Open;
    DTMGrafico.Qry10ProdutosMaisVendidos.Open;
  Finally
    Screen.Cursor:=crDefault;
  End;

end;

end.
