object dtmPrincipal: TdtmPrincipal
  OldCreateOrder = False
  Height = 129
  Width = 340
  object ConexaoDB: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    TransactIsolationLevel = tiReadCommitted
    SQLHourGlass = True
    HostName = '.\SERVERCURSO'
    Port = 1433
    Database = 'vendas'
    User = 'sa'
    Password = 'domtec@10'
    Protocol = 'mssql'
    LibraryLocation = 'C:\ProjetoDelphi\ntwdblib.dll'
    Left = 40
    Top = 32
  end
end
