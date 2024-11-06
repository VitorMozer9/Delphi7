unit UVendaItem;

interface

uses SysUtils, Classes;

type
   TVendaItem = class(TPersistent)
      private
         vID             : Integer;
         vID_Venda       : Integer;
         vID_Produto     : Integer;
         vQuantidade     : Double;
         vUnidadeDeSaida : String;
         vValorDesconto  : Double;
         vValorUnitario  : Double;
         vTotalItem      : Double;

   public
         constructor Create;

   published
         property ID             : Integer read vID write vID;
         property ID_Cliente     : Integer read vID_Cliente write vID_Cliente;
         property ID_Produto     : Integer read vID_Produto write vID_Produto;
         property Quantidade     : Double read vQuantidade write vQuantidade;
         property UnidadeDeSaida : String read vUnidadeDeSaida write vUnidadeDeSaida;
         property ValorDesconto  : Double read vValorDesconto write vValorDesconto;
         property ValorUnitario  : Double read vValorUnitario write vValorUnitario;
         property TotalItem      : Double read vTotalItem write vTotalItem;

   end;

   TColVendaItem = class(TList)
      public
       function Retorna(pIndex : Integer) : TVendaItem;
       procedure Adiciona(pVendaItem : TVendaItem);
   end;

implementation

{ TColVendaItem }

procedure TColVendaItem.Adiciona(pVendaItem: TVendaItem);
begin
   Self.Add(TVendaItem(pVendaItem));
end;

function TColVendaItem.Retorna(pIndex: Integer): TVendaItem;
begin
   Result := TVendaItem(Self[pIndex]);
end;

{ TVendaItem }

constructor TVendaItem.Create;
begin
   Self.ID             := 0;
   Self.ID_Venda       := 0;
   Self.ID_Produto     := 0;
   Self.Quantidade     := 0;
   Self.UnidadeDeSaida := EmptyStr;
   Self.ValorDesconto  := 0;
   Self.ValorUnitario  := 0;
   Self.TotalItem      := 0;
end;

end.
