unit uCadCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  cCadCategoria, uDTMConexao, uEnum;

type
  TfrmCadCategoria = class(TfrmTelaHeranca)
    QryListagemcategoriaId: TIntegerField;
    QryListagemdescricao: TWideStringField;
    edtCategoriaId: TLabeledEdit;
    edtDescricao: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdListagemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    { Private declarations }
    oCategoria:TCategoria;
    Function Apagar:Boolean; override;
    Function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadCategoria: TfrmCadCategoria;

implementation

{$R *.dfm}

{$region 'Override'}
function TfrmCadCategoria.Apagar: Boolean;
begin
  if oCategoria.Selecionar(QryListagem.FieldByName('categoriaId').AsInteger) then
  Result:=oCategoria.Apagar;
end;

function TfrmCadCategoria.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if edtCategoriaId.Text<>EmptyStr then
     oCategoria.codigo:= StrToInt(edtCategoriaId.Text)
  else
     oCategoria.codigo:= 0;

  oCategoria.descricao:=edtDescricao.Text;

  if (EstadoDoCadastro=ecInserir) then
      Result:=oCategoria.Inserir
  else if (EstadoDoCadastro=ecAlterar) then
      Result:=oCategoria.Atualizar;
end;

procedure TfrmCadCategoria.grdListagemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

end;

{$endregion}

procedure TfrmCadCategoria.btnAlterarClick(Sender: TObject);
begin
  if oCategoria.Selecionar(QryListagem.FieldByName('categoriaId').AsInteger) then
  begin
     edtCategoriaId.Text:=IntToStr(oCategoria.codigo);
     edtDescricao.Text  :=oCategoria.descricao;
  end
  else
  begin
    btnCancelar.Click;
    abort;
  end;

  inherited;
end;

procedure TfrmCadCategoria.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(oCategoria) then
    FreeAndNil(oCategoria);
  grdListagem.Columns.SaveToFile('C:\ProjetoDelphi\Win32\Config\CadastroDeCategoria');
end;

procedure TfrmCadCategoria.FormCreate(Sender: TObject);
begin
  inherited;
  oCategoria:=TCategoria.Create(dtmPrincipal.ConexaoDB);

  IndiceAtual:= 'descricao';
end;

procedure TfrmCadCategoria.FormShow(Sender: TObject);
begin
  inherited;
  if FileExists('C:\ProjetoDelphi\Win32\Config\CadastroDeCategoria') then
     grdListagem.Columns.LoadFromFile('C:\ProjetoDelphi\Win32\Config\CadastroDeCategoria');
end;

end.
