unit uUsuariosVsAcoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, uGrid;

type
  TfrmUsuarioVsAcoes = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    grdUsuarios: TDBGrid;
    grdAcoes: TDBGrid;
    QryUsuario: TZQuery;
    QryAcoes: TZQuery;
    dtsUsuario: TDataSource;
    dtsAcoes: TDataSource;
    QryUsuariousuarioID: TIntegerField;
    QryUsuarioNome: TWideStringField;
    QryAcoesusuarioId: TIntegerField;
    QryAcoesacaoAcessoId: TIntegerField;
    QryAcoesdescricao: TWideStringField;
    QryAcoesativo: TBooleanField;
    btnFechar: TBitBtn;
    procedure btnFecharClick(Sender: TObject);
    procedure QryUsuarioAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure grdAcoesDblClick(Sender: TObject);
    procedure grdAcoesDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure grdUsuariosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure SelecionarAcoesAcessoPorUsuario;
  public
    { Public declarations }
  end;

var
  frmUsuarioVsAcoes: TfrmUsuarioVsAcoes;

implementation

uses
  uDTMConexao;

{$R *.dfm}

procedure TfrmUsuarioVsAcoes.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmUsuarioVsAcoes.grdAcoesDblClick(Sender: TObject);
var Qry:TZQuery;
    bmRegistroAtual:TBookMark;
begin
  try
    bmRegistroAtual := QryAcoes.GetBookMark;
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=DtmPrincipal.ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE usuariosAcaoAcesso         '+
                '   SET ativo=:ativo               '+
                ' WHERE usuarioId=:usuarioId       '+
                '   AND acaoAcessoId=:acaoAcessoId ');
    Qry.ParamByName('usuarioId').AsInteger     :=QryAcoes.FieldByName('usuarioId').AsInteger;
    Qry.ParamByName('acaoAcessoId').AsInteger  :=QryAcoes.FieldByName('acaoAcessoId').AsInteger;
    Qry.ParamByName('ativo').AsBoolean         :=not QryAcoes.FieldByName('ativo').AsBoolean;
    Try
      DtmPrincipal.ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      DtmPrincipal.ConexaoDB.Commit;
    Except
      DtmPrincipal.ConexaoDB.Rollback;
    End;

  finally;
    SelecionarAcoesAcessoPorUsuario;
    QryAcoes.GotoBookMark(bmRegistroAtual);
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

procedure TfrmUsuarioVsAcoes.grdAcoesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
        State: TGridDrawState);
begin
  ZebrarGrid(Sender, Rect, DataCol, Column, State);
  FormatarTitulosColunas(grdAcoes);

  If not QryAcoes.FieldByName('ativo').AsBoolean then
  begin
    TDBGrid(Sender).Canvas.Font.Color:= clWhite;
    TDBGrid(Sender).Canvas.Brush.Color:=clRed;
  end;
  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).Columns[DataCol].Field, State);
end;

procedure TfrmUsuarioVsAcoes.grdUsuariosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
begin
  ZebrarGrid(Sender, Rect, DataCol, Column, State);
  FormatarTitulosColunas(grdUsuarios);
end;

procedure TfrmUsuarioVsAcoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  grdUsuarios.Columns.SaveToFile('C:\ProjetoDelphi\Win32\Config\UsuariosVsAcoes');
  grdAcoes.Columns.SaveToFile('C:\ProjetoDelphi\Win32\Config\AcoesVsUsuarios');
end;

procedure TfrmUsuarioVsAcoes.FormShow(Sender: TObject);
begin
  Try
    QryUsuario.DisableControls;
    QryUsuario.Open;
    SelecionarAcoesAcessoPorUsuario;
  Finally
    QryUsuario.EnableControls;
  End;
  if FileExists('C:\ProjetoDelphi\Win32\Config\UsuariosVsAcoes') then
     grdUsuarios.Columns.LoadFromFile('C:\ProjetoDelphi\Win32\Config\UsuariosVsAcoes');
  if FileExists('C:\ProjetoDelphi\Win32\Config\AcoesVsUsuarios') then
     grdAcoes.Columns.LoadFromFile('C:\ProjetoDelphi\Win32\Config\AcoesVsUsuarios');
end;

procedure TfrmUsuarioVsAcoes.QryUsuarioAfterScroll(DataSet: TDataSet);
begin
  SelecionarAcoesAcessoPorUsuario;
end;

procedure TfrmUsuarioVsAcoes.SelecionarAcoesAcessoPorUsuario;
begin
  QryAcoes.Close;
  QryAcoes.ParamByName('usuarioId').AsInteger := QryUsuario.FieldByName('usuarioId').AsInteger;
  QryAcoes.Open;
end;

end.
