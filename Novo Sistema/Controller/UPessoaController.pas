unit UPessoaController;

interface

uses SysUtils, Math, StrUtils, UConexao, UPessoa;

type
  TPessoaController = class
     public
       constructor Create;
       function GravaPessoa(
                   pPessoa : TPessoa) : Boolean;

       function ExcluiPessoa(pPessoa : TPessoa) : Boolean;

       function BuscaPessoa(pID : Integer) : TPessoa;  

       function RetornaCondicaoPessoa(pID_Pessoa : Integer) : String;

     published
        class function getInstancia : TPessoaController;
  end;

implementation

uses UPessoaDAO;

var
  _instance : TPessoaController;

{ TPessoaController }

function TPessoaController.BuscaPessoa(pID: Integer): TPessoa;
var
   xPessoaDAO : TPessoaDAO; //objeto temporario
begin
   try
      try
         Result := nil; //o Create cria uma nova instancia criando uma conex�o com o banco de dados

         xPessoaDAO := TPessoaDAO.Create(TConexao.getInstance.getConn);
         Result := xPessoaDAO.Retorna(RetornaCondicaoPessoa(pID));
      finally
         if (xPessoaDAO <> nil) then
            FreeAndNil(xPessoaDAO);
      end;
   except
      on E: Exception do //O Raise serve para gerar exce��es de erro explicitas
      begin
         raise Exception.Create(
            'Falha ao buscar dados da pessoa. [Controller] '#13 +
            e.Message);
      end;
   end;
end;

constructor TPessoaController.Create;
begin
   inherited Create;
end;

function TPessoaController.ExcluiPessoa(pPessoa: TPessoa): Boolean;
var
   xPessoaDAO : TPessoaDAO;
begin
   try
      try
         Result := False;

         TConexao.get.iniciaTransacao;

         xPessoaDAO := TPessoaDAO.Create(TConexao.get.getConn);

          if (pPessoa.Id = 0) then
          Exit
          else
          begin
            xPessoaDAO.Deleta(RetornaCondicaoPessoa(pPessoa.Id));
          end;

          TConexao.get.confirmaTransacao;

         Result := True;
      finally
         if (xPessoaDAO <> nil) then
            FreeAndNil(xPessoaDAO);
      end;
   except
      on E: Exception do
      begin
         TConexao.get.cancelaTransacao;
         Raise Exception.Create(
            'Falha ao excluir os dados da pessoa. [Controller]'#13+
            e.Message);
      end;
   end;
end;

class function TPessoaController.getInstancia: TPessoaController;
begin
   if _instance = nil then
      _instance := TPessoaController.Create;

   Result := _instance;
end;

function TPessoaController.GravaPessoa(pPessoa: TPessoa): Boolean;
var
  xPessoaDAO : TPessoaDAO;
begin
   try
     try
        TConexao.get.iniciaTransacao;

        Result := False;
        //no cod diferenciei o obj de new, logo antes instancio ela como nil
        xPessoaDAO := nil;

        xPessoaDAO :=    // aq estou passando a conexao do banco que estava na UpessoaDao para o objeto xPessoaDAO
           TPessoaDAO.Create(TConexao.get.getConn);

        if pPessoa.Id = 0 then
        begin
           xPessoaDAO.Insere(pPessoa);
        end
        else
        begin
           xPessoaDAO.Atualiza(pPessoa, RetornaCondicaoPessoa(pPessoa.Id));
        end;

        TConexao.get.confirmaTransacao;

     finally
        if (xPessoaDAO <> nil) then
           FreeAndNil(xPessoaDAO);
     end;
   except
      on E : Exception do
      begin
         TConexao.get.cancelaTransacao;
         Raise Exception.Create(
            'Falha ao gravar os dados da pessoa [Controller]. '#13+
            e.Message);
      end;

   end;
end;

function TPessoaController.RetornaCondicaoPessoa(
  pID_Pessoa: Integer): String;
var
  xChave : String;
begin
   xChave := 'ID';


   Result :=
   'WHERE                                                '#13+
   '   '+ xChave+ ' = '+ QuotedStr(IntToStr(pID_Pessoa))+' '#13; //fun��o Quoted para substituir as aspas duplas / quadruplas

end;

end.