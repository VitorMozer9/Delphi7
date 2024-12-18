unit UCadUsuaController;

interface

uses SysUtils, Math, StrUtils, UConexao, UUsuario;

type
   TCadUsuaController = class
      public
         constructor Create;
         function GravaUsuario(pUsuario : TUsuario;
            pInclusao : Boolean) : Boolean;

         function RetornaCondicaoUsuario(pUsuario : String) : String;
         function BuscaUsuario(pUsuario : String): TUsuario;
         function ExcluiUsuario(pUsuario : TUsuario) : Boolean;
         function PesquisaUsuario(pUsuario : String) : TColUsuario; 

      published
         class function getInstancia : TCadUsuaController;

   end;

implementation

uses UCadUsuaDAO;

var _instance : TCadUsuaController;

{ TCadUsuaController }

function TCadUsuaController.BuscaUsuario(pUsuario: String): TUsuario;
var
   xUsuarioDAO : TCadUsuaDAO;
begin
   try
      try
         Result := nil;

         xUsuarioDAO := TCadUsuaDAO.Create(TConexao.get.getConn);

         Result := xUsuarioDAO.Retorna(RetornaCondicaoUsuario(pUsuario));

      finally
         if (xUsuarioDAO <> nil) then
            FreeAndNil(xUsuarioDAO);
      end;
   except
      on E : Exception do
      begin
         raise Exception.Create(
         'Falha ao retornar dados do Usu�rio. [Controller]'#13 +
         e.Message);
      end;
   end;
end;

constructor TCadUsuaController.Create;
begin
   inherited Create;
end;

function TCadUsuaController.ExcluiUsuario(pUsuario: TUsuario): Boolean;
var
   xUsuarioDAO : TCadUsuaDAO;
begin
   try
      try
         Result := False;
         TConexao.getInstance.iniciaTransacao;
         xUsuarioDAO := Nil;

         xUsuarioDAO := TCadUsuaDAO.Create(TConexao.get.getConn);

         if (pUsuario.Usuario = EmptyStr) then
            exit
         else
         begin
            xUsuarioDAO.Deleta(RetornaCondicaoUsuario(pUsuario.Usuario));
         end;

         TConexao.get.confirmaTransacao;

         Result := True;
      finally
         if xUsuarioDAO <> nil then
            FreeAndNil(xUsuarioDAO);
      end;
   except
      on E : Exception do
      begin
         TConexao.get.cancelaTransacao;
         raise Exception.Create(
            'Falha ao excluir dados de usu�rio. [Controller]'+ #13 +
            e.Message);
      end;
   end;
end;

class function TCadUsuaController.getInstancia: TCadUsuaController;
begin
   if _instance = nil then
      _instance := TCadUsuaController.Create;

   Result := _instance;
end;

function TCadUsuaController.GravaUsuario(pUsuario: TUsuario;
   pInclusao : Boolean): Boolean;
var
   xUsuarioDAO : TCadUsuaDAO;
begin
   try
      try
         TConexao.getInstance.iniciaTransacao;
         Result := False;
         xUsuarioDAO := nil;

         xUsuarioDAO := TCadUsuaDAO.Create(TConexao.get.getConn);

          if pInclusao then
            xUsuarioDAO.Insere(pUsuario)
          else
            xUsuarioDAO.Atualiza(
               pUsuario,RetornaCondicaoUsuario(pUsuario.Usuario));

         Result := True;
         TConexao.get.confirmaTransacao;
      finally
         if xUsuarioDAO <> nil then
            FreeAndNil(xUsuarioDAO);
      end;   
   except
      on E : Exception do
      begin
         TConexao.get.cancelaTransacao;
         raise Exception.Create(
            'Falha ao gravar dados do Usu�rio. [Controller]:'#13 +
            e.Message);
      end;
   end;  
end;

function TCadUsuaController.PesquisaUsuario(pUsuario: String): TColUsuario;
var
   xUsuarioDAO : TCadUsuaDAO;
   xCondicao   : String;
begin
   try
      try
         Result := nil;

         xUsuarioDAO :=
            TCadUsuaDAO.Create(TConexao.getInstance.getConn);

         xCondicao :=
            IfThen(pUsuario <> EmptyStr,
            'WHERE                                            '#13 +
            '    (NOME LIKE UPPER(''%' + pUsuario + '%'' ))'#13 +
               'ORDER BY NOME, USUARIO ', EmptyStr);

         Result := xUsuarioDAO.RetornaLista(xCondicao);

      finally
       if (xUsuarioDAO <> nil) then
         FreeAndNil(xUsuarioDAO);
      end;
   except
      on E : Exception do
      begin
         raise Exception.Create(
            'Falha ao buscar os dados da Unidade de Produto [Controller]'#13 +
            e.Message);
      end;
   end;
end;

function TCadUsuaController.RetornaCondicaoUsuario(
  pUsuario: String): String;
var
   xChave : string;
begin
   xChave := 'USUARIO';

   Result :=
   'WHERE                                        '#13+ //filter records
   '    '+xChave+ ' = ' + QuotedStr(pUsuario)+ ' '#13;
end;

end.
