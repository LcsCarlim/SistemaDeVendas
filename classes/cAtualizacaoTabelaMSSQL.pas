unit cAtualizacaoTabelaMSSQL;

interface

uses System.Classes,
     Vcl.Controls,
     Vcl.ExtCtrls,
     Vcl.Dialogs,
     ZAbstractConnection,
     ZConnection,
     ZAbstractRODataset,
     ZAbstractDataset,
     ZDataset,
     System.SysUtils,
     cAtualizacaoBancoDeDados,
     cCadUsuario;

type
  TAtualizacaoTableMSSQL = class(TAtualizaBancoDados)

  private
    function  TabelaExiste(aNomeTabela:String):Boolean;

  protected

  public
    constructor Create(aConexao:TZConnection);
    destructor Destroy; override;

    procedure Categoria;
    procedure Cliente;
    procedure Produto;
    procedure Vendas;
    procedure VendasItens;
    procedure Usuario;
    procedure UsuariosAcaoAcesso;
    procedure AcaoAcesso;
    procedure Status;
    procedure Pessoa;
    procedure SubCategoria;
end;

implementation

{ TAtualizacaoTableMSSQL }

constructor TAtualizacaoTableMSSQL.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
  Categoria;
  SubCategoria;
  Status;
  Pessoa;
  Cliente;
  Produto;
  Vendas;
  VendasItens;
  Usuario;
  AcaoAcesso;
  UsuariosAcaoAcesso;

end;

destructor TAtualizacaoTableMSSQL.Destroy;
begin
  inherited;
end;

function TAtualizacaoTableMSSQL.TabelaExiste(aNomeTabela: String): Boolean;
Var Qry:TZQuery;
Begin
  Try
    Result:=False;
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add(' SELECT OBJECT_ID (:NomeTabela) As ID ');
    Qry.ParamByName('NomeTabela').AsString:=aNomeTabela;
    Qry.Open;

    if Qry.FieldByName('ID').AsInteger>0 then
       Result:=True;

  Finally
    Qry.Close;
    if Assigned(Qry) then
       FreeAndNil(Qry);
  End;
end;

procedure TAtualizacaoTableMSSQL.Usuario;
Var oUsuario:TUsuario;
begin
  if not TabelaExiste('usuarios') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE usuarios ( '+
      '	 usuarioId int identity(1,1) not null, '+
      '	 nome varchar(50) not null, '+
      '	 senha varchar(40) not null, '+
      '	 PRIMARY KEY (usuarioId) '+
      '	) '
    );
  end;

  Try
    oUsuario:=TUsuario.Create(ConexaoDB);
    oUsuario.nome:='DOMTEC';
    oUsuario.senha:='domtec@10';
    if not oUsuario.UsuarioExiste(oUsuario.nome) then
      oUsuario.Inserir;
  Finally
    if Assigned(oUsuario) then
       FreeAndNil(oUsuario);
  End;
end;


procedure TAtualizacaoTableMSSQL.Categoria;
begin
  if not TabelaExiste('categorias') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE categorias( '+
      '	 categoriaId int IDENTITY(1,1) NOT NULL, '+
      '	 descricao  varchar(30) NULL, '+
      '	 PRIMARY KEY (categoriaId) '+
      '	) '
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.Cliente;
begin
  if not TabelaExiste('clientes') then
  begin
    ExecutaDiretoBancoDeDados(
      '	CREATE TABLE clientes (                                                           '+
      '		clienteId int IDENTITY(1,1) NOT NULL,                                           '+
      '   pessoaId int NOT NULL,                                                          '+
      '   statusId int NOT NULL,                                                          '+
      '		nome varchar(60) NULL,                                                          '+
      '		endereco varchar(60) null,                                                      '+
      '		cidade varchar(50) null,                                                        '+
      '		bairro varchar(40) null,                                                        '+
      '		estado varchar(2) null,                                                         '+
      '		cep varchar(10) null,                                                           '+
      '		telefone varchar(14) null,                                                      '+
      '		email varchar(100) null,                                                        '+
      '   cpfcnpj varchar(20) null,                                                       '+
      '		dataNascimento datetime null,                                                   '+
      '		PRIMARY KEY (clienteId),                                                        '+
      '   CONSTRAINT FK_ClientePessoa FOREIGN KEY (pessoaId) REFERENCES pessoa(pessoaId), '+
      '   CONSTRAINT FK_ClienteStatus FOREIGN KEY (statusId) REFERENCES status(statusId) )'
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.Pessoa;
begin
  if not TabelaExiste('pessoa') then
  begin
    ExecutaDiretoBancoDeDados(
        ' CREATE TABLE pessoa (                 '+
        ' pessoaId INT IDENTITY(1,1) not null,  '+
        ' descricao VARCHAR(20) null,           '+
        ' PRIMARY KEY (pessoaId) )              '
      );
    ExecutaDiretoBancoDeDados(
        ' INSERT INTO pessoa(descricao) VALUES (''Fis�ca''), (''Jur�dica'')');
  end;
end;

procedure TAtualizacaoTableMSSQL.Produto;
begin
  if not TabelaExiste('produtos') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE produtos(  '+
      '  produtoId int IDENTITY(1,1) NOT NULL, '+
      '  nome varchar(60) NULL, '+
      '  descricao varchar(255) null, '+
      '  valor decimal(18,5) default 0.00000 null, '+
      '  quantidade decimal(18,5) default 0.00000 null, '+
      '  categoriaId int null, '+
      '  subCategoriaId int null, '+
      '  PRIMARY KEY (produtoId), '+
      '  CONSTRAINT FK_ProdutosCategorias '+
      '  FOREIGN KEY (categoriaId) references categorias(categoriaId), '+
      '  CONSTRAINT FK_ProdutosSubCategorias '+
      '  FOREIGN KEY (subCategoriaId) references subCategorias(subCategoriaId) '+
      ') '
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.Status;
begin
  if not TabelaExiste('status') then
  begin
    ExecutaDiretoBancoDeDados(
      ' CREATE TABLE status (                '+
      ' statusId INT IDENTITY(1,1) not null, '+
      ' descricao VARCHAR(20) null,          '+
      ' PRIMARY KEY (statusId) )             '
    );
    ExecutaDiretoBancoDeDados(
      ' INSERT INTO status(descricao) VALUES (''Ativo''), (''Bloqueado''), (''Aten��o''), (''Inativo''), (''Prospecto'')');
  end;
end;

procedure TAtualizacaoTableMSSQL.SubCategoria;
begin
  if not TabelaExiste('subCategorias') then
  begin
    ExecutaDiretoBancoDeDados(
    ' CREATE TABLE subCategorias (                '+
    ' subCategoriaId INT IDENTITY(1,1) NOT NULL,  '+
    ' categoriaId INT NOT NULL,                   '+
    ' descricao VARCHAR(50) null,                 '+
    ' PRIMARY KEY (subCategoriaId),               '+
    ' CONSTRAINT FK_Categorias                    '+
    ' FOREIGN KEY (categoriaId)                   '+
    ' REFERENCES categorias(categoriaId) )        '
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.Vendas;
begin
  if not TabelaExiste('vendas') then
  begin
    ExecutaDiretoBancoDeDados(
      '	CREATE TABLE vendas (  '+
      '	  vendaId int identity(1,1) not null, '+
      '	  clienteId int not null, '+
      '	  dataVenda datetime default getdate(), '+
      '	  totalVenda decimal(18,5) default 0.00000, '+

      '	  PRIMARY KEY (vendaId), '+
      '	  CONSTRAINT FK_VendasClientes FOREIGN KEY (clienteId) '+
      '		REFERENCES clientes(clienteId) '+
      '	) '
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.VendasItens;
begin
  if not TabelaExiste('vendasItens') then
  begin
    ExecutaDiretoBancoDeDados(
      ' CREATE TABLE vendasItens (   '+
      ' 	vendaId int not null,  '+
      '	  produtoId int not null,  '+
      '	  valorUnitario decimal (18,5) default 0.00000,  '+
      '	  quantidade decimal (18,5) default 0.00000,  '+
      '	  totalProduto decimal (18,5) default 0.00000,  '+

      '	  PRIMARY KEY (vendaId,produtoId),  '+
      '	  CONSTRAINT FK_VendasItensProdutos FOREIGN KEY (produtoId)  '+
      '		REFERENCES produtos(produtoId)  '+
      '	)  '
    );
  end;
end;


procedure TAtualizacaoTableMSSQL.AcaoAcesso;
begin
  if not TabelaExiste('acaoAcesso') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE acaoAcesso ( '+
      '	 acaoAcessoId int identity(1,1) not null, '+
      '	 descricao varchar(100) not null, '+
      '	 chave varchar(60) not null unique, '+
      '	 PRIMARY KEY (acaoAcessoId) '+
      '	) '
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.UsuariosAcaoAcesso;
begin
  if not TabelaExiste('usuariosAcaoAcesso') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE usuariosAcaoAcesso( '+
      '	 usuarioId  int NOT NULL, '+
      '	 acaoAcessoId int NOT NULL, '+
      '	 ativo bit not null default 1, '+
      '	 PRIMARY KEY (usuarioId, acaoAcessoId), '+
      '	 CONSTRAINT FK_UsuarioAcaoAcessoUsuario '+
      '	 FOREIGN KEY (usuarioId) references usuarios(usuarioId), '+
      '	 CONSTRAINT FK_UsuarioAcaoAcessoAcaoAcesso '+
      '	 FOREIGN KEY (acaoAcessoId) references acaoAcesso(acaoAcessoId), '+
      '	) '
    );
  end;
end;

end.
