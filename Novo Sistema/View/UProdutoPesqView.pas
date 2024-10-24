unit UProdutoPesqView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, DB, DBClient, Grids,
  DBGrids,uMessageUtil, UProduto, UProdutoController;

type
  TfrmProdutoPesq = class(TForm)
    stbBarraStatus: TStatusBar;
    pnlBotoes: TPanel;
    btnConfirmar: TBitBtn;
    btnLimpar: TBitBtn;
    btnSair: TBitBtn;
    pnlFiltro: TPanel;
    pnlArea: TPanel;
    grbFiltrar: TGroupBox;
    lblProduto: TLabel;
    lblInfo: TLabel;
    edtProduto: TEdit;
    btnFiltrar: TBitBtn;
    dtsProduto: TDataSource;
    cdsProduto: TClientDataSet;
    cdsProdutoID: TIntegerField;
    cdsProdutoDescricao: TStringField;
    cdsProdutoQuantidadeEstoque: TFloatField;
    cdsProdutoPrecoVenda: TFloatField;
    gbrResultadoBusca: TGroupBox;
    dbgResultadoBusca: TDBGrid;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure cdsProdutoBeforeDelete(DataSet: TDataSet);
    procedure dbgResultadoBuscaDblClick(Sender: TObject);
    procedure dbgResultadoBuscaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    vKey : Word;

    procedure LimpaTela;
    procedure ProcessaPesquisa;
    procedure ProcessaConfirmacao;

  public
    { Public declarations }
    mProdutoID   : Integer;
    mProduto     : String;
  end;

var
  frmProdutoPesq: TfrmProdutoPesq;

implementation

{$R *.dfm}

procedure TfrmProdutoPesq.FormKeyDown(Sender: TObject; var Key: Word;
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

         if (ActiveControl = dbgResultadoBusca) then
            exit;

          Perform(WM_NextDlgCtl, 1, 0);
      end;
   end;
end;

procedure TfrmProdutoPesq.LimpaTela;
var
   xI : Integer;
begin
   for xI := 0 to pred(ComponentCount) do
   begin
      if (Components[xI] is TEdit) then
         (Components[xI] as TEdit).Text := EmptyStr;
   end;

   if (not cdsProduto.IsEmpty) then
      cdsProduto.EmptyDataSet;

   if (edtProduto.CanFocus) then
      (edtProduto.SetFocus);
end;

procedure TfrmProdutoPesq.ProcessaPesquisa;
var
   xListaProduto : TColProduto;
   xAux          : Integer;
begin
   try
      try
         xListaProduto := TColProduto.Create;

         xListaProduto :=
            TProdutoController.getInstancia.PesquisaProduto(Trim(edtProduto.Text));

         cdsProduto.EmptyDataSet;

         if xListaProduto <> nil then
         begin
            for xAux := 0 to pred(xListaProduto.Count) do
            begin
               cdsProduto.Append;
               cdsProdutoID.Value := xListaProduto.Retorna(xAux).Id;
               cdsProdutoDescricao.Value := xListaProduto.Retorna(xAux).Descricao;
               cdsProdutoQuantidadeEstoque.Value := xListaProduto.Retorna(xAux).QuantidadeEstoque;
               cdsProdutoPrecoVenda.Value := xListaProduto.Retorna(xAux).PrecoVenda;

               cdsProduto.Post;
            end;
         end;

         if (cdsProduto.RecordCount = 0) then
         begin
            if edtProduto.CanFocus then
               edtProduto.SetFocus;

            TMessageUtil.Alerta(
               'Nenhum produto encontrado para este filtro.');
         end
         else
         begin
            cdsProduto.First;

            if dbgResultadoBusca.CanFocus then
               dbgResultadoBusca.SetFocus;
         end;

      finally
         if (xListaProduto <> nil) then
            FreeAndNil(xListaProduto);
      end;
   except
      on E : Exception do
      begin
         raise Exception.Create(
            'Falha ao pesquisar dados do produto '#13 +
            e.Message);
      end;
   end;  
end;

procedure TfrmProdutoPesq.btnFiltrarClick(Sender: TObject);
begin
   mProdutoID := 0;
   mProduto := EmptyStr;
   ProcessaPesquisa;
end;

procedure TfrmProdutoPesq.ProcessaConfirmacao;
begin
   if not cdsProduto.IsEmpty then
   begin
      mProdutoID       := cdsProdutoID.Value;
      mProduto     := cdsProdutoDescricao.Value;
      Self.ModalResult := mrOk;
      LimpaTela;
      Close;
   end
   else
   begin
      TMessageUtil.Alerta('Nenhum produto selecionado.');

      if edtProduto.CanFocus then
         edtProduto.SetFocus;
   end;
end;

procedure TfrmProdutoPesq.btnConfirmarClick(Sender: TObject);
begin
   ProcessaConfirmacao;
end;

procedure TfrmProdutoPesq.btnLimparClick(Sender: TObject);
begin
   mProdutoID := 0;
   mProduto := EmptyStr;
   LimpaTela;
end;

procedure TfrmProdutoPesq.btnSairClick(Sender: TObject);
begin
   LimpaTela;
   Close;
end;

procedure TfrmProdutoPesq.cdsProdutoBeforeDelete(DataSet: TDataSet);
begin
   Abort;
end;

procedure TfrmProdutoPesq.dbgResultadoBuscaDblClick(Sender: TObject);
begin
   ProcessaConfirmacao;
end;

procedure TfrmProdutoPesq.dbgResultadoBuscaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if (Key = VK_RETURN) and
      (btnConfirmar.CanFocus) then
      btnConfirmar.SetFocus;
end;

end.
