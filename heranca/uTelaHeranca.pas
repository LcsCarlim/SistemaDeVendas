unit uTelaHeranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ComCtrls, Vcl.ExtCtrls,
  uDtmConexao, ZAbstractRODataset, ZAbstractDataset, ZDataset, uEnum,
  RxToolEdit, RxCurrEdit, ZAbstractConnection, ZConnection, System.UITypes, cUsuarioLogado, uGrid;

type
  TfrmTelaHeranca = class(TForm)
    pgcPrincipal: TPageControl;
    pnlRodaPe: TPanel;
    tabListagem: TTabSheet;
    tabManutencao: TTabSheet;
    pnlListagem: TPanel;
    mskPesquisar: TMaskEdit;
    btnPesquisar: TBitBtn;
    grdListagem: TDBGrid;
    btnNovo: TBitBtn;
    btnApagar: TBitBtn;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnAlterar: TBitBtn;
    btnFechar: TBitBtn;
    btnNavigator: TDBNavigator;
    QryListagem: TZQuery;
    dtsListagem: TDataSource;
    lblIndice: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdListagemTitleClick(Column: TColumn);
    procedure mskPesquisarChange(Sender: TObject);
    procedure grdListagemDblClick(Sender: TObject);
    procedure grdListagemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnPesquisarClick(Sender: TObject);
    procedure grdListagemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    { Private declarations }
    SelectOriginal:String;
    procedure ControlarBotoes(btnNovo, btnAlterar, btnCancelar,
              btnGravar, btnApagar:TBitBtn; Navegador:TDBNavigator;
              pgcPrincipal: TPageControl; Flag:Boolean);
    procedure ControlarIndiceTab(pgcPrincipal: TPageControl; Indice: Integer);
    function RetornarCampoTraduzido(Campo:String):string;
    procedure ExibirLabelIndice(Campo: String; aLabel: TLabel);
    function ExisteCampoObrigatorio: Boolean;
    procedure DesabilitarEditPK;
    procedure LimparEdits;
  public
    { Public declarations }
    IndiceAtual:string;
    EstadoDoCadastro:TEstadoDoCadastro;
    Function Apagar:Boolean; virtual;
    Function Gravar(EstadoDoCadastro:TEstadoDoCadastro) :Boolean; virtual;
    procedure BloqueiaCTRL_DEL_DBGrid(var Key: Word; Shift: TShiftState);
  end;

var
  frmTelaHeranca: TfrmTelaHeranca;

implementation

{$R *.dfm}

uses uPrincipal;

{$region 'OBSERVA��ES'}
  //TAG:1 - CHAVE PRIMARIA - PK
  //TAG:2 - CAMPOS OBRIGAT�RIOS
{$endregion}

{$region 'FUN��ES E PROCEDURES'}
procedure TfrmTelaHeranca.ControlarBotoes(btnNovo, btnAlterar, btnCancelar,
          btnGravar, btnApagar:TBitBtn; Navegador:TDBNavigator;
          pgcPrincipal: TPageControl; Flag:Boolean);
begin
  btnNovo.Enabled      :=Flag;
  btnApagar.Enabled    :=Flag;
  btnAlterar.Enabled   :=Flag;
  Navegador.Enabled    :=Flag;
  pgcPrincipal.Pages[0].TabVisible :=Flag;
  btnCancelar.Enabled  :=not(Flag);
  btnGravar.Enabled    :=not(Flag);
end;

procedure TfrmTelaHeranca.ControlarIndiceTab(pgcPrincipal: TPageControl;
          Indice: Integer);
begin
  if (pgcPrincipal.Pages[Indice].TabVisible) then
      pgcPrincipal.TabIndex:=Indice;
end;

function TfrmTelaHeranca.RetornarCampoTraduzido(Campo:String):String;
var i:Integer;
begin
  for I := 0 to QryListagem.Fields.Count-1 do begin
    if lowercase(QryListagem.Fields[i].FieldName)=lowercase(Campo) then begin
      Result:=QryListagem.Fields[i].DisplayLabel;
      Break;
    end;
  end;
end;

function TfrmTelaHeranca.ExisteCampoObrigatorio:Boolean;
var i:Integer;
begin
  Result:=False;
  for I := 0 to ComponentCount -1 do begin
    if (Components[i] is TLabeledEdit) then begin
      if (TLabeledEdit(Components[i]).Tag = 2) and
         (TLabeledEdit(Components[i]).Text=EmptyStr) then begin
           MessageDlg(TLabeledEdit(Components[i]).EditLabel.Caption +
                    ' � um campo obrigat�rio',mtInformation,[mbOK],0);
           TLabeledEdit(Components[i]).SetFocus;
           Result:=True;
           Break;
         end;
    end;
  end;
end;

procedure TfrmTelaHeranca.DesabilitarEditPK;
var i:Integer;
begin
  for i := 0 to ComponentCount -1 do begin
    if (Components[i] is TLabeledEdit) then begin
      if (TLabeledEdit(Components[i]).Tag = 1) then begin
          TLabeledEdit(Components[i]).Enabled:=False;
          break;
      end;
    end;
  end;
end;

procedure TfrmTelaHeranca.LimparEdits;
var i:Integer;
begin
  for i := 0 to ComponentCount -1 do begin
    if (Components[i] is TLabeledEdit) then
          TLabeledEdit(Components[i]).Text:=EmptyStr
    else if (Components[i] is TEdit) then
      TEdit(Components[i]).Text:=''
    else if (Components[i] is TMemo) then
      TMemo(Components[i]).Text:=''
    else if (Components[i] is TDBLookupComboBox) then
      TDBLookupComboBox(Components[i]).KeyValue:=Null
    else if (Components[i] is TCurrencyEdit) then
      TCurrencyEdit(Components[i]).Value:=0
    else if (Components[i] is TDateEdit) then
      TDateEdit(Components[i]).Date:=0
    else if (Components[i] is TMaskEdit) then
      TMaskEdit(Components[i]).Text:='';

  end;
end;

{$endregion}

{$region 'M�TODOS VIRTUAIS'}
function TfrmTelaHeranca.Gravar(EstadoDoCadastro: TEstadoDoCadastro): boolean;
begin
   if (EstadoDoCadastro=ecInserir) then
       showmessage('Inserir')
   else if (EstadoDoCadastro=ecAlterar) then
       showmessage('Alterado')
   else
      showmessage('Nada aconteceu');
end;

function TfrmTelaHeranca.Apagar: Boolean;
begin
  showmessage('Apagar');
end;
{$endregion}

procedure TfrmTelaHeranca.ExibirLabelIndice(Campo:String; aLabel:TLabel);
begin
  aLabel.Caption:=RetornarCampoTraduzido(Campo);
end;

procedure TfrmTelaHeranca.btnNovoClick(Sender: TObject);
begin
  if not TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, self.Name+'_'+TBitBtn(Sender).Name, DtmPrincipal.ConexaoDB) then
  begin
    MessageDlg('Usu�rio: '+oUsuarioLogado.nome +', n�o tem permiss�o de acesso',mtWarning,[mbOK],0);
    Abort;
  end;

  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
                  btnNavigator, pgcPrincipal,false);
  EstadoDoCadastro:=ecInserir;
  LimparEdits;
end;

procedure TfrmTelaHeranca.btnPesquisarClick(Sender: TObject);
var I:Integer;
    TipoCampo:TFieldType;
    NomeCampo:String;
    WhereOrAnd:String;
    CondicaoSQL:String;
begin
  if not TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, self.Name+'_'+TBitBtn(Sender).Name, DtmPrincipal.ConexaoDB) then
  begin
    MessageDlg('Usu�rio: '+oUsuarioLogado.nome +', n�o tem permiss�o de acesso',mtWarning,[mbOK],0);
    Abort;
  end;

  if mskPesquisar.Text='' then
  begin
    QryListagem.Close;
    QryListagem.SQL.Clear;
    QryListagem.SQL.Add(SelectOriginal);
    QryListagem.Open;
    Abort;
  end;

  for I := 0 to QryListagem.FieldCount-1 do
  begin
    if QryListagem.Fields[i].FieldName=IndiceAtual then
    begin
      TipoCampo := QryListagem.Fields[i].DataType;
      if QryListagem.Fields[i].Origin<>'' then
      begin
        if Pos('.',QryListagem.Fields[i].Origin) > 0 then
          NomeCampo := QryListagem.Fields[i].Origin
        else
          NomeCampo := QryListagem.Fields[i].Origin+'.'+QryListagem.Fields[i].FieldName
      end
      else
        NomeCampo := QryListagem.Fields[i].FieldName;
      Break;
    end;
  end;

  if Pos('where',LowerCase(SelectOriginal)) > 1 then
  begin
    WhereOrAnd := ' and '
  end
  else
  begin
    WhereOrAnd := ' where ';
  end;

  if(TipoCampo=ftString) or (TipoCampo=ftWideString) then
  begin
    CondicaoSQL := WhereOrAnd+' ' + NomeCampo + ' LIKE '+QuotedStr('%'+mskPesquisar.Text+'%');
  end
  else if (TipoCampo = ftInteger) or (TipoCampo = ftSmallint) then
  begin
    CondicaoSQL := WhereOrAnd+' '+NomeCampo + '='+mskPesquisar.Text
  end
  else if (TipoCampo = ftDate) or (TipoCampo = ftDateTime) then
  begin
    CondicaoSQL := WhereOrAnd+' '+NomeCampo +  '='+QuotedStr(mskPesquisar.Text)
  end
  else if (TipoCampo = ftFloat) or (TipoCampo=ftCurrency)  then
  begin
    CondicaoSQL := WhereOrAnd+' '+NomeCampo + '='+StringReplace(mskPesquisar.Text,',','.',[rfReplaceAll]);
  end;

  QryListagem.Close;
  QryListagem.SQL.Clear;
  QryListagem.SQL.Add(SelectOriginal);
  QryListagem.SQL.Add(CondicaoSQL);
  QryListagem.Open;

  mskPesquisar.Text:='';
  mskPesquisar.SetFocus;
end;

procedure TfrmTelaHeranca.btnAlterarClick(Sender: TObject);
begin
  if not TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, self.Name+'_'+TBitBtn(Sender).Name, DtmPrincipal.ConexaoDB) then
  begin
    MessageDlg('Usu�rio: '+oUsuarioLogado.nome +', n�o tem permiss�o de acesso',mtWarning,[mbOK],0);
    Abort;
  end;

  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
                  btnNavigator, pgcPrincipal,false);
  EstadoDoCadastro:=ecAlterar;
end;

procedure TfrmTelaHeranca.btnApagarClick(Sender: TObject);
begin
  if not TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, self.Name+'_'+TBitBtn(Sender).Name, DtmPrincipal.ConexaoDB) then
  begin
    MessageDlg('Usu�rio: '+oUsuarioLogado.nome +', n�o tem permiss�o de acesso',mtWarning,[mbOK],0);
    Abort;
  end;

  Try
    if (Apagar) then begin
       ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
                       btnNavigator, pgcPrincipal,true);
       ControlarIndiceTab(pgcPrincipal, 0);
       LimparEdits;
       QryListagem.Refresh;
    end
    else begin
      MessageDlg('Erro na exclus�o', mtError, [mbok], 0);
       end;
    Finally
       EstadoDoCadastro:=ecNenhum;
    End;
  end;

procedure TfrmTelaHeranca.btnCancelarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
                  btnNavigator, pgcPrincipal,true);
  ControlarIndiceTab(pgcPrincipal, 0);
  EstadoDoCadastro:=ecNenhum;
  LimparEdits;
end;

procedure TfrmTelaHeranca.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmTelaHeranca.btnGravarClick(Sender: TObject);
begin
  if not TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, self.Name+'_'+TBitBtn(Sender).Name, DtmPrincipal.ConexaoDB) then
  begin
    MessageDlg('Usu�rio: '+oUsuarioLogado.nome +', n�o tem permiss�o de acesso',mtWarning,[mbOK],0);
    Abort;
  end;

  if (ExisteCampoObrigatorio) then
  abort;

  Try
      if Gravar(EstadoDoCadastro) then
      begin
        ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
                        btnNavigator, pgcPrincipal,true);
        ControlarIndiceTab(pgcPrincipal, 0);
        EstadoDoCadastro:=ecNenhum;
        LimparEdits;
        QryListagem.Refresh;
      end
      else
      begin
        MessageDlg('Erro ao Gravar', mtWarning,[mbOK],0);
      end;
  Finally
  End;
end;

procedure TfrmTelaHeranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  QryListagem.Close;
end;

procedure TfrmTelaHeranca.FormCreate(Sender: TObject);
begin
  QryListagem.Connection:=dtmPrincipal.ConexaoDB;
  dtsListagem.DataSet:=QryListagem;
  grdListagem.DataSource:=dtsListagem;
  grdListagem.Options:=[dgTitles,dgIndicator,dgColumnResize,
                        dgColLines,dgRowLines,dgTabs,
                        dgRowSelect,dgAlwaysShowSelection,dgCancelOnExit,
                        dgTitleClick,dgTitleHotTrack];
end;

procedure TfrmTelaHeranca.FormShow(Sender: TObject);
begin
  if (QryListagem.SQL.Text<>EmptyStr) then
  begin
    QryListagem.IndexFieldNames:=IndiceAtual;
    ExibirLabelIndice(IndiceAtual, lblIndice);
    SelectOriginal:=QryListagem.SQL.Text;
    QryListagem.Open;
  end;
    ControlarIndiceTab(pgcPrincipal, 0);
    DesabilitarEditPK;
    ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
                    btnNavigator, pgcPrincipal,true);
end;

procedure TfrmTelaHeranca.grdListagemDblClick(Sender: TObject);
begin
  btnAlterar.Click;
end;

procedure TfrmTelaHeranca.grdListagemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  ZebrarGrid(Sender, Rect, DataCol, Column, State);
  FormatarTitulosColunas(grdListagem);
end;

procedure TfrmTelaHeranca.grdListagemKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  BloqueiaCTRL_DEL_DBGrid(Key,Shift);
end;

procedure TfrmTelaHeranca.grdListagemTitleClick(Column: TColumn);
begin
  IndiceAtual :=Column.FieldName;
  QryListagem.IndexFieldNames:=IndiceAtual;
  ExibirLabelIndice(IndiceAtual, lblIndice);
end;

procedure TfrmTelaHeranca.mskPesquisarChange(Sender: TObject);
begin
  QryListagem.Locate(IndiceAtual, TMaskEdit(Sender).Text, [loPartialKey]);
end;

procedure TfrmTelaHeranca.BloqueiaCTRL_DEL_DBGrid(var Key: Word; Shift: TShiftState);
begin
  //Bloqueia CTRL + DEL
  if (Shift = [ssCtrl]) and (Key = 46) then
     Key := 0;
end;

end.