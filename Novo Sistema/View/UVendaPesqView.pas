unit UVendaPesqView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, DB, DBClient, Grids,
  DBGrids, Mask,uMessageUtil, UVenda;

type
  TfrmVendaPesqView = class(TForm)
    stbBarraStatus: TStatusBar;
    pnlBotoes: TPanel;
    btnConfirmar: TBitBtn;
    btnLimpar: TBitBtn;
    btnSair: TBitBtn;
    pnlFiltro: TPanel;
    pnlArea: TPanel;
    grbFiltrar: TGroupBox;
    grbResultado: TGroupBox;
    lblDataInicio: TLabel;
    lblCodigoDoCliente: TLabel;
    edtProduto: TEdit;
    btnFiltrar: TBitBtn;
    mskDataInicio: TMaskEdit;
    lblDataFim: TLabel;
    mskDataFim: TMaskEdit;
    lblAte: TLabel;
    dbgPesquisaVenda: TDBGrid;
    dtsVendaPesq: TDataSource;
    cdsVendaPesq: TClientDataSet;
    cdsVendaPesqCodigoVenda: TIntegerField;
    cdsVendaPesqNomeCliente: TStringField;
    cdsVendaPesqDataVenda: TDateField;
    cdsVendaPesqTotalVenda: TFloatField;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    vKey : Word;

    procedure LimpaTela;
    procedure ProcessaPesquisa;

  public
    { Public declarations }
  end;

var
  frmVendaPesqView: TfrmVendaPesqView;

implementation

{$R *.dfm}

{ TfrmVendaPesqView }

procedure TfrmVendaPesqView.LimpaTela;
var
   xI : Integer;
begin
   for xI := 0 to pred(ComponentCount) do
   begin
      if (Components[xI] is TEdit) then
         (Components[xI] as TEdit).Text := EmptyStr;

       if (Components[xI] is TMaskEdit) then
        (Components[xI] as TMaskEdit).Text := EmptyStr;
   end;

   if (not cdsVendaPesq.IsEmpty) then
      cdsVendaPesq.EmptyDataSet;

   if (mskDataInicio.CanFocus) then
      (mskDataInicio.SetFocus);
end;

procedure TfrmVendaPesqView.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   vKey := Key;

   case vKey of
      VK_RETURN:
      begin
         Perform(WM_NEXTDLGCTL, 0, 0 );
      end;

      VK_ESCAPE:
      begin
         if TMessageUtil.Pergunta('Deseja sair da rotina?') then
            Close;
      end;

      VK_UP:
      begin
         vKey := VK_CLEAR;

         if (ActiveControl = dbgPesquisaVenda) then
            exit;

          Perform(WM_NextDlgCtl, 1, 0);
      end;
   end;
end;

procedure TfrmVendaPesqView.ProcessaPesquisa;
var
   xListaVenda : TColVenda;
   xAux        : Integer;
begin
   try
      try
         xListaVenda := TColVenda.Create;

//          xListaVenda :=
//            TVendaController.getInstancia.PesquisaVenda(mskDataInicio.Text, mskDataFim.Text);

         cdsVendaPesq.EmptyDataSet;

         if xListaVenda <> nil then
         begin
            for xAux := 0 to pred(xListaVenda.Count) do
            begin
               cdsVendaPesq.Append;
               cdsVendaPesqCodigoVenda.Value := xListaVenda.Retorna(xAux).ID;
               cdsVendaPesqNomeCliente.Value := xListaVenda.Retorna(xAux).NomeCliente;
               cdsVendaPesqDataVenda.Value := xListaVenda.Retorna(xAux).DataVenda;
               cdsVendaPesqTotalVenda.Value := xListaVenda.Retorna(xAux).TotalVenda;
               cdsVendaPesq.Post;
            end;
         end;

         if (cdsVendaPesq.RecordCount = 0) then
         begin
            if mskDataInicio.CanFocus then
               mskDataInicio.SetFocus;

            TMessageUtil.Alerta(
               'Nenhuma venda encontrada para este filtro.');
         end
         else
         begin
            cdsVendaPesq.First;

            if dbgPesquisaVenda.CanFocus then
               dbgPesquisaVenda.SetFocus;
         end;



      finally
         if (xListaVenda <> nil) then
            FreeAndNil(xListaVenda);
      end;
   except
      on E : Exception do
      begin
         raise Exception.Create(
            'Falha ao pesquisar dados da venda '#13 +
            e.Message);
      end;
   end;
end;

end.
