unit UUnidadeProdController;

interface

uses SysUtils, Math, StrUtils, UConexao, UUnidadeProduto, SqlExpr;

type
   TUnidadeProdController = class
      public
         constructor create;
         function GravaUnidadeProduto (
                     pUnidadeProduto : TUnidadeProduto) : Boolean;

         function ExcluiUnidade (pUnidadeProd : TUnidadeProduto) : Boolean;

         function BuscaUnidade(pID : Integer) : TUnidadeProduto;
         function PesquisaUnidade(pUnidade : String) : TColUnidadeProd;
         function RetornaCondicaoUnidade(pID : Integer ) : String;
         //function RetornaProdutoUnidade(pCodProduto : Integer) : TUnidadeProduto;

      published
         class function getInstancia : TUnidadeProdController;  

   end;

implementation

uses UUnidadeProdDAO, UClassFuncoes;

var
   _instance : TUnidadeProdController;

{ TUnidadeProdController }

function TUnidadeProdController.BuscaUnidade(
  pID: Integer): TUnidadeProduto;
var
   xUnidadeDAO : TUnidadeProdutoDAO;
begin
   try
      try
         Result := nil;

         xUnidadeDAO := TUnidadeProdutoDAO.Create(TConexao.getInstance.getConn);

         Result := xUnidadeDAO.Retorna(RetornaCondicaoUnidade(pID));

      finally
         if (xUnidadeDAO <> nil) then
            FreeAndNil(xUnidadeDAO);
      end;
   except
      on E : Exception do
      begin
         raise Exception.Create(
         'Falha ao retornar dados da Unidade de Produto. [Controller]'#13 +
         e.Message);
      end;
   end;  
end;

constructor TUnidadeProdController.create;
begin
   inherited create;
end;

function TUnidadeProdController.ExcluiUnidade(
  pUnidadeProd: TUnidadeProduto): Boolean;
var
   xUnidadeDAO : TUnidadeProdutoDAO;
begin
   try
      try
         Result := False;

         TConexao.get.iniciaTransacao;

         xUnidadeDAO := TUnidadeProdutoDAO.Create(TConexao.get.getConn);

         if (pUnidadeProd.Id = 0) then
            exit
         else
         begin
            xUnidadeDAO.Deleta(RetornaCondicaoUnidade(pUnidadeProd.Id));
         end;

         TConexao.get.confirmaTransacao;

         Result := True;
      finally
         if (xUnidadeDAO <> nil) then
            FreeAndNil(xUnidadeDAO);
      end;
   except
      on E : Exception do
      begin
         TConexao.get.cancelaTransacao;
         raise Exception.Create(
            'Falha ao excluir dados de unidade de produto. [Controller]'+ #13 +
            e.Message);
      end;
   end;
end;

class function TUnidadeProdController.getInstancia: TUnidadeProdController;
begin
   if _instance = nil then
      _instance := TUnidadeProdController.Create;

   Result := _instance;
end;

function TUnidadeProdController.GravaUnidadeProduto(
  pUnidadeProduto: TUnidadeProduto): Boolean;
var
   xUnidadeProdDAO : TUnidadeProdutoDAO;
begin
   try
      try
         TConexao.get.iniciaTransacao;

         Result := False;

         xUnidadeProdDAO := nil;

         xUnidadeProdDAO := TUnidadeProdutoDAO.Create(TConexao.get.getConn);

         if pUnidadeProduto.Id = 0 then
         begin
            xUnidadeProdDAO.Insere(pUnidadeProduto);
         end
         else
         begin
            xUnidadeProdDAO.Atualiza(
               pUnidadeProduto,RetornaCondicaoUnidade(pUnidadeProduto.Id));
         end;

         TConexao.get.confirmaTransacao;
      finally
         if xUnidadeProdDAO <> nil then
            FreeAndNil(xUnidadeProdDAO);
      end;
   except
      on E : Exception do
      begin
         TConexao.get.cancelaTransacao;
         Raise Exception.Create(
            'Falha ao gravar dados de unidade de produto. [Controller]'#13 +
            e.Message);
      end;
   end;
end;

function TUnidadeProdController.PesquisaUnidade(
  pUnidade: String): TColUnidadeProd;
var
   xUnidadeDAO : TUnidadeProdutoDAO;
   xCondicao : string;
begin
   try
      try
         Result := nil;

         xUnidadeDAO :=
            TUnidadeProdutoDAO.Create(TConexao.getInstance.getConn);

         xCondicao :=
            IfThen(pUnidade <> EmptyStr,
            'WHERE                                            '#13 +
            '    (UNIDADE LIKE UPPER(''%' + pUnidade + '%'' ))'#13 +
               'ORDER BY UNIDADE, ID ', EmptyStr);

         Result := xUnidadeDAO.RetornaLista(xCondicao);

      finally
       if (xUnidadeDAO <> nil) then
         FreeAndNil(xUnidadeDAO);
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

function TUnidadeProdController.RetornaCondicaoUnidade(
  pID: Integer): String;
var
   xChave : String;
begin
   xChave := 'ID';

   Result :=
   'WHERE                                             '#13+
   '    '+xChave+ ' = ' + QuotedStr(IntToStr(pID))+ ' '#13;
end;

//function TUnidadeProdController.RetornaProdutoUnidade(
//  pCodProduto: Integer): TUnidadeProduto;
//var
//   xQuery : TSQLQuery;
//   xConexao : TSQLConnection;
//   xObjUnidadeProduto : TUnidadeProduto;
//begin
//   try
//      try
//         Result := nil;
//         xObjUnidadeProduto := TUnidadeProduto.create;
//         xQuery := TSQLQuery.Create(nil);
//
//         xQuery.SQLConnection := xConexao;
//         xQuery.Close;
//
//         xQuery.SQL.Text :=
//             'SELECT unidadeproduto.unidade, unidadeproduto.descricao'        + #13 +
//               'FROM unidadeproduto'                                          + #13 +
//               'INNER JOIN produto on unidadeproduto.id = PRODUTO.unidade_id' + #13 +
//               'WHERE PRODUTO.id = ' + IntToStr(pCodProduto);
//
//         xQuery.Open;
//
//         xObjUnidadeProduto.Unidade := xQuery.FieldByName('');
//
//          Result :=
//      finally
//         if (xQuery <> nil) then
//            FreeAndNil(xQuery);
//      end;
//   except
//      on E : Exception do
//      begin
//         raise Exception.Create(
//            'Falha ao retornar dados de unidade para produto. [Controller]: '#13 +
//            e.Message);
//      end;
//   end;
//end;

end.
