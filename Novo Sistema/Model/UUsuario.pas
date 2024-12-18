unit UUsuario;

interface

uses SysUtils, Classes;

type
   TUsuario = class(TPersistent)

   private
      vUsuario : string;
      vSenha   : string;
      vNome    : String;
      vCargo   : Integer;
      vAtivo   : Boolean;

   public
      constructor Create;

   published
       property Usuario : String read vUsuario write vUsuario;
       property Senha   : String  read vSenha write vSenha;
       property Nome    : String  read vNome write vNome;
       property Cargo   : integer read vCargo write vCargo;
       property Ativo   : Boolean read vAtivo write vAtivo;

   end;

   TColUsuario = class(TList)
     public
       function Retorna(pIndex : Integer) : TUsuario;
       procedure Adiciona(pUsuario : TUsuario);

   end;

implementation

{ TUsuario }

constructor TUsuario.Create;
begin
   Self.vUsuario := EmptyStr;
   Self.vSenha   := EmptyStr;
   Self.vNome    := EmptyStr;
   Self.vCargo   := 0;
   Self.vAtivo   := False;
end;

{ TColUsuario }

procedure TColUsuario.Adiciona(pUsuario: TUsuario);
begin
   Self.Add(TUsuario(pUsuario));
end;

function TColUsuario.Retorna(pIndex: Integer): TUsuario;
begin
   Result := TUsuario(Self[pIndex]);
end;

end.
