unit UUnidadeProdPesqView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, DB, DBClient, Grids,
  DBGrids,UMessageUtil, UUnidadeProduto, UUnidadeProdController, Math, StrUtils;

type
  TfrmUnidadePesq = class(TForm)
    pnlBotoes: TPanel;
    btnConfirmar: TBitBtn;
    btnLimpar: TBitBtn;
    btnSair: TBitBtn;
    pnlFiltro: TPanel;
    pnlResultado: TPanel;
    grbFiltrar: TGroupBox;
    lblUnidade: TLabel;
    lblInfo: TLabel;
    edtUnidade: TEdit;
    btnFiltrar: TBitBtn;
    grbGrid: TGroupBox;
    dbgResultadoBusca: TDBGrid;
    dtsUnidade: TDataSource;
    cdsUnidade: TClientDataSet;
    cdsUnidadeID: TIntegerField;
    cdsUnidadeUnidade: TStringField;
    cdsUnidadeDescricao: TStringField;
    cdsUnidadeAtivo: TIntegerField;
    cdsUnidadeAtivoDesc: TStringField;
    stbBarraStatus: TStatusBar;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure cdsUnidadeBeforeDelete(DataSet: TDataSet);
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
    mUnidade      : String;
  end;

var
  frmUnidadePesq: TfrmUnidadePesq;

implementation

{$R *.dfm}

procedure TfrmUnidadePesq.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmUnidadePesq.LimpaTela;
var
   I : Integer;
begin
   for I := 0 to pred(ComponentCount) do
   begin
      if (Components[I] is TEdit) then
         (Components[I] as TEdit).Text := EmptyStr;
   end;

   if (not cdsUnidade.IsEmpty) then
      cdsUnidade.EmptyDataSet;

   if edtUnidade.CanFocus then
      edtUnidade.SetFocus;

end;

procedure TfrmUnidadePesq.ProcessaPesquisa;
var
   xListaUnidade : TColUnidadeProd;
   xAux          : Integer;
begin
   try
      try
         xListaUnidade := TColUnidadeProd.Create;

         xListaUnidade :=
            TUnidadeProdController.getInstancia.PesquisaUnidade(Trim(edtUnidade.Text));

         cdsUnidade.EmptyDataSet;

         if xListaUnidade <> nil then
         begin
            for xAux := 0 to pred(xListaUnidade.Count) do
            begin
               cdsUnidade.Append;
               cdsUnidadeUnidade.Value   := xListaUnidade.Retorna(xAux).Unidade;
               cdsUnidadeDescricao.Value := xListaUnidade.Retorna(xAux).Descricao;
               cdsUnidadeAtivo.Value     :=
                  IfThen(xListaUnidade.Retorna(xAux).Ativo, 1, 0);

               cdsUnidadeAtivoDesc.Value :=
                  IfThen(xListaUnidade.Retorna(xAux).Ativo, 'Sim', 'N�o');

               cdsUnidade.Post;
            end;
         end;

         if (cdsUnidade.RecordCount = 0) then
         begin
            if edtUnidade.CanFocus then
               edtUnidade.SetFocus;

            TMessageUtil.Alerta(
               'Nenhuma unidade de produto encontrada para este filtro.');
         end
         else
         begin
            cdsUnidade.First;

            if dbgResultadoBusca.CanFocus then
               dbgResultadoBusca.SetFocus;
         end;

      finally
         if (xListaUnidade <> nil) then
            FreeAndNil(xListaUnidade);
      end;
   except
      on E : Exception do
      begin
         raise Exception.Create(
         'Falha ao pesquisar dados de Unidade de Produto. [View]:' + #13 +
         e.Message);
      end;
   end;
end;

procedure TfrmUnidadePesq.btnFiltrarClick(Sender: TObject);
begin
   mUnidade := EmptyStr;
   ProcessaPesquisa;
end;

procedure TfrmUnidadePesq.btnConfirmarClick(Sender: TObject);
begin
   ProcessaConfirmacao;
end;

procedure TfrmUnidadePesq.ProcessaConfirmacao;
begin
   if not cdsUnidade.IsEmpty then
   begin
      mUnidade     := cdsUnidadeUnidade.Value;
      Self.ModalResult := mrOk;
      LimpaTela;
      Close;
   end
   else
   begin
      TMessageUtil.Alerta('Nenhuma Unidade de Produto selecionada.');

      if edtUnidade.CanFocus then
         edtUnidade.SetFocus;
   end;
end;

procedure TfrmUnidadePesq.btnLimparClick(Sender: TObject);
begin
   mUnidade := EmptyStr;
   LimpaTela;
end;

procedure TfrmUnidadePesq.btnSairClick(Sender: TObject);
begin
   LimpaTela;
   Close;
end;

procedure TfrmUnidadePesq.cdsUnidadeBeforeDelete(DataSet: TDataSet);
begin
   Abort;
end;

procedure TfrmUnidadePesq.dbgResultadoBuscaDblClick(Sender: TObject);
begin
   ProcessaConfirmacao;
end;

procedure TfrmUnidadePesq.dbgResultadoBuscaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    if (Key = VK_RETURN) and
      (btnConfirmar.CanFocus) then
      btnConfirmar.SetFocus;
end;

end.
