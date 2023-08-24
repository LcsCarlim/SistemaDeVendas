unit cCadSubCategoria;

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
     System.SysUtils;

type
  TSubCategoria = class
  private
    ConexaoDB:TZConnection;
    F_subCategoriaId:Integer;
    F_categoriaId:Integer;
    F_descricao:String;

  public
    constructor Create(aConexao:TZConnection);
    destructor Destroy; override;
    function Inserir:Boolean;
    function Atualizar:Boolean;
    function Apagar:Boolean;
    function Selecionar(id:Integer):Boolean;

  published
    property codigo        :Integer    read F_subCategoriaId        write F_subCategoriaId;
    property categoriaId   :Integer    read F_categoriaId           write F_categoriaId;
    property descricao     :String     read F_descricao             write F_descricao;
end;

implementation

{ TSubCategoria }

{$region 'Constructor and Destructor'}
constructor TSubCategoria.Create(aConexao: TZConnection);
begin
  ConexaoDB:=aConexao
end;

destructor TSubCategoria.Destroy;
begin

  inherited;
end;
{$endregion}

function TSubCategoria.Apagar: Boolean;
var Qry:TZQuery;
begin
  if MessageDlg('Apagar o Registro: '+#13+#13+
                'Código: '+IntToStr(F_subCategoriaId)+#13+
                'SubCategoria: '+F_descricao,mtConfirmation,[mbYes, mbNo],0)=mrNo then
  begin
     Result:=false;
     abort;
  end;
  try
    Result:=true;
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('DELETE FROM subCategorias '+
                ' WHERE subCategoriaId=:subCategoriaId ');
    Qry.ParamByName('subCategoriaId').AsInteger :=F_subCategoriaId;
     Try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result:=false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

function TSubCategoria.Atualizar: Boolean;
var Qry:TZQuery;
begin
  try
    Result:=true;
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE subCategorias '+
                '   SET descricao        =:descricao '+
                '       ,categoriaId     =:categoriaId '+
                ' WHERE subCategoriaId=:subCategoriaId ');
    Qry.ParamByName('subCategoriaId').AsInteger       :=Self.F_subCategoriaId;
    Qry.ParamByName('categoriaId').AsInteger          :=Self.F_categoriaId;
    Qry.ParamByName('descricao').AsString             :=Self.F_descricao;

    Try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result:=false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

function TSubCategoria.Inserir: Boolean;
var Qry:TZQuery;
begin
  try
    Result:=true;
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO subCategorias (categoriaId, '+
                '                      descricao) '+
                ' VALUES              (:categoriaId, '+
                '                      :descricao)' );

    Qry.ParamByName('categoriaId').AsInteger      :=Self.F_categoriaId;
    Qry.ParamByName('descricao').AsString         :=Self.F_descricao;

    Try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result:=false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

function TSubCategoria.Selecionar(id: Integer): Boolean;
var Qry:TZQuery;
begin
  try
    Result:=true;
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT subCategoriaId,'+
                '       categoriaId, '+
                '       descricao '+
                '  FROM subCategorias '+
                ' WHERE subCategoriaId=:subCategoriaId');
    Qry.ParamByName('subCategoriaId').AsInteger:=id;
    Try
      Qry.Open;

      Self.F_subCategoriaId   := Qry.FieldByName('subCategoriaId').AsInteger;
      Self.F_categoriaId      := Qry.FieldByName('categoriaId').AsInteger;
      Self.F_descricao        := Qry.FieldByName('descricao').AsString;

    Except
      Result:=false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

end.
