unit uCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  uEnum, cCadCliente, uDTMConexao, RxToolEdit, uFuncaoCriptografia, Math, StrUtils, System.ImageList, Vcl.ImgList, uUtils,
  Vcl.Menus, uGrid;

type
  TfrmCadCliente = class(TfrmTelaHeranca)
    edtClienteId: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtEndereco: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtBairro: TLabeledEdit;
    edtEmail: TLabeledEdit;
    edtCEP: TMaskEdit;
    Label1: TLabel;
    lblTelefone: TLabel;
    Label3: TLabel;
    edtDataNascimento: TDateEdit;
    lkpStatus: TDBLookupComboBox;
    Label4: TLabel;
    lkpPessoa: TDBLookupComboBox;
    Label5: TLabel;
    QryStatus: TZQuery;
    QryStatusstatusId: TIntegerField;
    QryStatusdescricao: TWideStringField;
    dtsStatus: TDataSource;
    QryPessoa: TZQuery;
    dtsPessoa: TDataSource;
    QryPessoapessoaId: TIntegerField;
    QryPessoadescricao: TWideStringField;
    lblCpfCnpj: TLabel;
    edtCpfCnpj: TEdit;
    edtEstado: TLabeledEdit;
    edtTelefone: TEdit;
    QryListagemclienteId: TIntegerField;
    QryListagemstatusId: TIntegerField;
    QryListagempessoaId: TIntegerField;
    QryListagemcpfcnpj: TWideStringField;
    QryListagemnome: TWideStringField;
    QryListagemendereco: TWideStringField;
    QryListagemcidade: TWideStringField;
    QryListagembairro: TWideStringField;
    QryListagemestado: TWideStringField;
    QryListagemcep: TWideStringField;
    QryListagemtelefone: TWideStringField;
    QryListagememail: TWideStringField;
    QryListagemdataNascimento: TDateTimeField;
    imgList: TImageList;
    imgAtivo: TImage;
    Label2: TLabel;
    imgBloqueado: TImage;
    Label6: TLabel;
    imgAtencao: TImage;
    Label7: TLabel;
    imgInativo: TImage;
    Label8: TLabel;
    imgProspecto: TImage;
    Label9: TLabel;
    Label10: TLabel;
    procedure btnAlterarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure lkpPessoaClick(Sender: TObject);
    procedure edtCpfCnpjEnter(Sender: TObject);
    procedure edtCpfCnpjChange(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtTelefoneChange(Sender: TObject);
    procedure grdListagemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure QryListagemstatusIdGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
    poCliente:TCliente;
    piTipoPessoa:Integer;
    function Apagar:Boolean; override;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; override;
    function ValidacoesAoGravar: Boolean;
    procedure AtualizarEdtCpfCnpj;
  public
    { Public declarations }
end;

var
  frmCadCliente: TfrmCadCliente;

implementation

{$R *.dfm}


{ TfrmCadCliente }

{$region 'Override'}


function IsValidCPF(const CPF: string): Boolean;
var
  Soma, Digito1, Digito2, i: Integer;
begin
  Result := False;

  if Length(CPF) <> 11 then
    Exit;

  Soma := 0;
  for i := 1 to 9 do
    Inc(Soma, StrToInt(CPF[i]) * (11 - i));

  Digito1 := 11 - (Soma mod 11);
  if Digito1 >= 10 then
    Digito1 := 0;

  Soma := 0;
  for i := 1 to 9 do
    Inc(Soma, StrToInt(CPF[i]) * (12 - i));

  Inc(Soma, Digito1 * 2);
  Digito2 := 11 - (Soma mod 11);
  if Digito2 >= 10 then
    Digito2 := 0;

  Result := (Digito1 = StrToInt(CPF[10])) and (Digito2 = StrToInt(CPF[11]));
end;


function isCNPJ(CNPJ: string): boolean;
var   dig13, dig14: string;
    sm, i, r, peso: integer;
begin
// length - retorna o tamanho da string do CNPJ (CNPJ é um número formado por 14 dígitos)
  if ((CNPJ = '00000000000000') or (CNPJ = '11111111111111') or
      (CNPJ = '22222222222222') or (CNPJ = '33333333333333') or
      (CNPJ = '44444444444444') or (CNPJ = '55555555555555') or
      (CNPJ = '66666666666666') or (CNPJ = '77777777777777') or
      (CNPJ = '88888888888888') or (CNPJ = '99999999999999') or
      (length(CNPJ) <> 14))
  then
    begin
      isCNPJ := false;
      exit;
    end;

// "try" - protege o código para eventuais erros de conversão de tipo através da função "StrToInt"
  try
{ *-- Cálculo do 1o. Digito Verificador --* }
    sm := 0;
    peso := 2;
    for i := 12 downto 1 do
    begin
// StrToInt converte o i-ésimo caractere do CNPJ em um número
      sm := sm + (StrToInt(CNPJ[i]) * peso);
      peso := peso + 1;
      if (peso = 10) then
          peso := 2;
    end;
    r := sm mod 11;
    if ((r = 0) or (r = 1)) then
       dig13 := '0'
    else str((11-r):1, dig13); // converte um número no respectivo caractere numérico

{ *-- Cálculo do 2o. Digito Verificador --* }
    sm := 0;
    peso := 2;
    for i := 13 downto 1 do
      begin
        sm := sm + (StrToInt(CNPJ[i]) * peso);
        peso := peso + 1;
      if (peso = 10)
      then peso := 2;
      end;
    r := sm mod 11;
    if ((r = 0) or (r = 1)) then
       dig14 := '0'
    else str((11-r):1, dig14);

{ Verifica se os digitos calculados conferem com os digitos informados. }
    if ((dig13 = CNPJ[13]) and (dig14 = CNPJ[14])) then
       isCNPJ := true
    else isCNPJ := false;
  except
    isCNPJ := false
  end;
end;

function TfrmCadCliente.Apagar: Boolean;
begin
  if poCliente.Selecionar(QryListagem.FieldByName('clienteId').AsInteger) then
  begin
     Result:=poCliente.Apagar;
  end;
end;

function TfrmCadCliente.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if edtClienteId.Text<>EmptyStr then
     poCliente.codigo:=StrToInt(edtClienteId.Text)
  else
     poCliente.codigo:=0;

  poCliente.nome             :=edtNome.Text;
  poCliente.cep              :=edtCEP.Text;
  poCliente.endereco         :=edtEndereco.Text;
  poCliente.bairro           :=edtBairro.Text;
  poCliente.cidade           :=edtCidade.Text;
  poCliente.estado           :=edtEstado.Text;
  poCliente.telefone         :=edtTelefone.Text;
  poCliente.email            :=edtEmail.Text;
  poCliente.dataNascimento   :=edtDataNascimento.Date;
  poCliente.PessoaId         :=lkpPessoa.KeyValue;
  poCliente.StatusId         :=lkpStatus.KeyValue;
  poCliente.cpfcnpj          :=edtCpfCnpj.Text;

  if (EstadoDoCadastro=ecInserir) then
     Result:=poCliente.Inserir
  else if (EstadoDoCadastro=ecAlterar) then
     Result:=poCliente.Atualizar;
end;

procedure TfrmCadCliente.grdListagemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Status: Integer;
begin
  inherited;
  with grdListagem do
  begin
    if Column.FieldName = 'statusId' then
    begin
      Status := Column.Field.AsInteger;

      imgList.Draw(Canvas, Rect.Left + 10, Rect.Top + 1, Status - 1);
    end;
  end;
end;

{$endregion}


procedure TfrmCadCliente.btnAlterarClick(Sender: TObject);
begin
  if poCliente.Selecionar(QryListagem.FieldByName('clienteId').AsInteger) then
  begin
     edtClienteId.Text:=IntToStr(poCliente.codigo);
     edtNome.Text     :=poCliente.nome;
     edtCEP.Text      :=poCliente.cep;
     edtEndereco.Text :=poCliente.endereco;
     edtBairro.Text   :=poCliente.bairro;
     edtCidade.Text   :=poCliente.cidade;
     edtEstado.Text   :=poCliente.estado;
     edtTelefone.Text :=poCliente.telefone;
     edtEmail.Text    :=poCliente.email;
     edtDataNascimento.Date:=poCliente.dataNascimento;
     lkpStatus.KeyValue:=poCliente.statusId;
     edtCpfCnpj.Text  :=poCliente.cpfcnpj;
     lkpPessoa.keyValue   :=poCliente.pessoaId;
  end
  else
  begin
    btnCancelar.Click;
    Abort;
  end;
  inherited;
  AtualizarEdtCpfCnpj;
end;

procedure TfrmCadCliente.btnCancelarClick(Sender: TObject);
begin
  inherited;
  HabilitarDesabilitarCampo(edtCpfCnpj, True);
end;

procedure TfrmCadCliente.btnGravarClick(Sender: TObject);
begin
  if ValidacoesAoGravar = True then
    inherited;
  HabilitarDesabilitarCampo(edtCpfCnpj, True);
end;

procedure TfrmCadCliente.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtDataNascimento.Date:=Date;
  lkpPessoa.SetFocus;
  lblCpfCnpj.Caption:= 'CPF/CNPJ';
  HabilitarDesabilitarCampo(edtCpfCnpj, True);
end;

procedure TfrmCadCliente.lkpPessoaClick(Sender: TObject);
begin
  inherited;
  AtualizarEdtCpfCnpj;
  edtCpfCnpj.Text:=  '';
  HabilitarDesabilitarCampo(edtCpfCnpj, False);
end;

procedure TfrmCadCliente.QryListagemstatusIdGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := '';
end;

procedure TfrmCadCliente.edtCpfCnpjChange(Sender: TObject);
var
  SomenteNumeros: string;
begin
  SomenteNumeros := SoNumero(edtCpfCnpj.Text);

  if piTipoPessoa = 1 then
  begin
    if Length(SomenteNumeros) <= 3 then
       edtCpfCnpj.Text:= Copy(SomenteNumeros, 1, 3)
    else
    if Length(SomenteNumeros) <= 6 then
       edtCpfCnpj.Text  := Copy(SomenteNumeros, 1, 3)
                          +'.'
                          + Copy(SomenteNumeros, 4, 3)
    else
    if Length(SomenteNumeros) <= 9 then
       edtCpfCnpj.Text:= Copy(SomenteNumeros, 1, 3)
                          +'.'
                          + Copy(SomenteNumeros, 4, 3)
                          +'.' + Copy(SomenteNumeros, 7, 3)
    else
    if Length(SomenteNumeros) <= 11 then
       edtCpfCnpj.Text := Copy(SomenteNumeros, 1, 3)
                          +'.'
                          + Copy(SomenteNumeros, 4, 3)
                          +'.'
                          + Copy(SomenteNumeros, 7, 3)
                          +'-'
                          + Copy(SomenteNumeros, 10, 2)
    else
    if Length(SomenteNumeros) > 11 then
       edtCpfCnpj.Text := Copy(SomenteNumeros, 1, 3)
                          +'.'
                          + Copy(SomenteNumeros, 4, 3)
                          +'.'
                          + Copy(SomenteNumeros, 7, 3)
                          +'-'
                          + Copy(SomenteNumeros, 10, 2);
  end
  else
  if piTipoPessoa = 2 then
  begin
    if Length(SomenteNumeros) <= 2 then
       edtCpfCnpj.Text := Copy(SomenteNumeros, 1, 2)
    else
    if Length(SomenteNumeros) <= 5 then
       edtCpfCnpj.Text := Copy(SomenteNumeros, 1, 2)
                          +'.'
                          + Copy(SomenteNumeros, 3, 3)
    else
    if Length(SomenteNumeros) <= 8 then
       edtCpfCnpj.Text := Copy(SomenteNumeros, 1, 2)
                          +'.'
                          + Copy(SomenteNumeros, 3, 3)
                          +'.'
                          + Copy(SomenteNumeros, 6, 3)
    else
    if Length(SomenteNumeros) <= 11 then
       edtCpfCnpj.Text := Copy(SomenteNumeros, 1, 2)
                          +'.'
                          + Copy(SomenteNumeros, 3, 3)
                          +'.' + Copy(SomenteNumeros, 6, 3)
                          +'/' + Copy(SomenteNumeros, 9, 4)
    else
    if Length(SomenteNumeros) <= 14 then
       edtCpfCnpj.Text := Copy(SomenteNumeros, 1, 2)
                          +'.' + Copy(SomenteNumeros, 3, 3)
                          +'.' + Copy(SomenteNumeros, 6, 3)
                          +'/' + Copy(SomenteNumeros, 9, 4)
                          +'-' + Copy(SomenteNumeros, 13, 2)
    else
    if Length(SomenteNumeros) > 14 then
       edtCpfCnpj.Text := Copy(SomenteNumeros, 1, 2)
                          +'.' + Copy(SomenteNumeros, 3, 3)
                          +'.' + Copy(SomenteNumeros, 6, 3)
                          +'/' + Copy(SomenteNumeros, 9, 4)
                          +'-' + Copy(SomenteNumeros, 13, 2);
  end;

  edtCpfCnpj.SelStart := Length(edtCpfCnpj.Text);
  HabilitarDesabilitarCampo(edtCpfCnpj, False);
end;


procedure TfrmCadCliente.edtCpfCnpjEnter(Sender: TObject);
var
    I: integer;
    S, Texto: string;
begin
  inherited;

  S := '';
    Texto := edtCpfCnpj.Text;
    for I := 1 to Length(Texto) do
    begin
        if (Texto[I] in ['0'..'9']) then
        begin
            S := S + Copy(Texto, I, 1);
        end;
    end;

    edtCpfCnpj.Text := S;
end;

procedure TfrmCadCliente.edtTelefoneChange(Sender: TObject);
var
  SomenteNumeros: string;

  function Is0800:Boolean;
    begin
      Result := False;

      if (Copy(SomenteNumeros, 1, 1) = '0') and (Copy(SomenteNumeros, 3, 2) = '00') then
      Result := True;
    end;

  function NumeroCelular:Boolean;
  var i:Integer;
    begin
      Result := False;
      if length(SomenteNumeros) = 11 then
      begin
        Result := True;
      end;
    end;

begin
  SomenteNumeros := SoNumero(edtTelefone.Text);
  if not is0800 then
  begin
  //Celular/Fixo
    if Length(SomenteNumeros) = 0 then
    begin
       edtTelefone.Text:= '';
       edtTelefone.SelStart := Length(edtTelefone.Text);
    end
    else
    if Length(SomenteNumeros) <= 2 then
    begin
       edtTelefone.Text := '('
                           + Copy(SomenteNumeros, 1, 2);
       edtTelefone.SelStart := Length(edtTelefone.Text);
    end
    else
    if Length(SomenteNumeros) <= 7 then
    begin
       edtTelefone.Text := '('
                           + Copy(SomenteNumeros, 1, 2)
                           + ')'
                           + Copy(SomenteNumeros, 3, 5);
       edtTelefone.SelStart := Length(edtTelefone.Text);
    end
    else
    if Length(SomenteNumeros) <= 10 then
    begin
       edtTelefone.Text := '('
                            + Copy(SomenteNumeros, 1, 2)
                            + ')'
                            + Copy(SomenteNumeros, 3, 4)
                            + '-'
                            + Copy(SomenteNumeros, 7, 4);
       edtTelefone.SelStart := Length(edtTelefone.Text);
    end
    else
    if Length(SomenteNumeros) <= 11 then
    begin
       edtTelefone.Text := '('
                           + Copy(SomenteNumeros, 1, 2)
                           + ')'
                           + Copy(SomenteNumeros, 3, 5)
                           + '-'
                           + Copy(SomenteNumeros, 8, 4);
       edtTelefone.SelStart := Length(edtTelefone.Text);
    end
    else
    if Length(SomenteNumeros) > 11 then
    begin
       edtTelefone.Text := '('
                           + Copy(SomenteNumeros, 1, 2)
                           + ')'
                           + Copy(SomenteNumeros, 3, 5)
                           + '-'
                           + Copy(SomenteNumeros, 8, 4);
       edtTelefone.SelStart := Length(edtTelefone.Text);
    end;
  end
  else
  begin
    if Length(SomenteNumeros) = 0 then
    begin
       edtTelefone.Text:= '';
       edtTelefone.SelStart := Length(edtTelefone.Text);
    end
    else
    if Length(SomenteNumeros) <= 4 then
    begin
       edtTelefone.Text := Copy(SomenteNumeros, 1, 4);
       edtTelefone.SelStart := Length(edtTelefone.Text);
    end
    else
    if Length(SomenteNumeros) <= 7 then
    begin
       edtTelefone.Text := Copy(SomenteNumeros, 1, 4)
                           + ' '
                           + Copy(SomenteNumeros, 5, 3);
       edtTelefone.SelStart := Length(edtTelefone.Text);
    end
    else
    if Length(SomenteNumeros) <= 11 then
    begin
       edtTelefone.Text := Copy(SomenteNumeros, 1, 4)
                           + ' '
                           + Copy(SomenteNumeros, 5, 3)
                           + ' '
                           + Copy(SomenteNumeros, 8, 4);
       edtTelefone.SelStart := Length(edtTelefone.Text);
    end
    else
    if Length(SomenteNumeros) >= 11 then
    begin
       edtTelefone.Text := Copy(SomenteNumeros, 1, 4)
                           + ' '
                           + Copy(SomenteNumeros, 5, 3)
                           + ' '
                           + Copy(SomenteNumeros, 8, 4);
       edtTelefone.SelStart := Length(edtTelefone.Text);
    end;
  end;
end;

procedure TfrmCadCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(poCliente) then
     FreeAndNil(poCliente);
  grdListagem.Columns.SaveToFile('C:\ProjetoDelphi\Win32\Config\CadastroDeCliente');
end;

procedure TfrmCadCliente.FormCreate(Sender: TObject);
begin
  inherited;
  poCliente:=TCliente.Create(dtmPrincipal.ConexaoDB);
  IndiceAtual:='clienteId';
end;

procedure TfrmCadCliente.FormShow(Sender: TObject);
begin
  inherited;
  if FileExists('C:\ProjetoDelphi\Win32\Config\CadastroDeCliente') then
     grdListagem.Columns.LoadFromFile('C:\ProjetoDelphi\Win32\Config\CadastroDeCliente');
  HabilitarDesabilitarCampo(edtCpfCnpj, True);
end;

function TfrmCadCliente.ValidacoesAoGravar: Boolean;
var
  CpfCnpj:string;
begin
  Result:= True;
  CpfCnpj:= SoNumero(edtCpfCnpj.Text);

  if piTipoPessoa = 1 then begin
    if not IsValidCPF(CpfCnpj) then
    begin
       ShowMessage('CPF inválido');
       edtCpfCnpj.SetFocus;
       Result:= False;
    end;
  end
  else
  if piTipoPessoa = 2 then begin
    if not isCNPJ(CpfCnpj) then
    begin
        ShowMessage('CNPJ inválido');
        edtCpfCnpj.SetFocus;
        Result:= False;
    end;
  end;
end;

procedure TfrmCadCliente.AtualizarEdtCpfCnpj;
begin
  piTipoPessoa := lkpPessoa.KeyValue;
  lblCpfCnpj.Caption := ifThen(piTipoPessoa = 1, 'CPF', 'CNPJ');
end;

end.
