unit uUtils;

interface

uses
  System.SysUtils,
  Math,
  StrUtils,
  Vcl.StdCtrls,
  Vcl.Graphics,
  Vcl.DBCtrls;

  function SoNumero(fField: String): String;
  procedure HabilitarDesabilitarCampo(oEdit:TEdit; lAtiva:Boolean);
  procedure HabilitarDesabilitarCampoLkp(oLkp:TDBLookupComboBox; lAtiva:Boolean);

implementation

function SoNumero(fField : String): String;
var
  vText : PChar;
begin
  vText := PChar(fField);
  Result := '';

  while (vText^ <> #0) do
  begin
    {$IFDEF UNICODE}
    if CharInSet(vText^, ['0'..'9']) then
    {$ELSE}
    if vText^ in ['0'..'9'] then
    {$ENDIF}
      Result := Result + vText^;

    Inc(vText);
  end;
end;

procedure HabilitarDesabilitarCampo(oEdit:TEdit; lAtiva:Boolean);
begin
  oEdit.ReadOnly:= lAtiva;
  oEdit.Color:= ifthen(lAtiva, clMedGray, clWhite);
end;

procedure HabilitarDesabilitarCampoLkp(oLkp:TDBLookupComboBox; lAtiva:Boolean);
begin
  oLkp.ReadOnly:= lAtiva;
  oLkp.Color:= ifthen(lAtiva, clMedGray, clWhite);
end;

end.
