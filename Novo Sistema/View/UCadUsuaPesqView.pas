unit UCadUsuaPesqView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls,
  ComCtrls, UUsuario, UMessageUtil,UCadUsuaController, Math, StrUtils;

type
  TfrmCadUsuaPesq = class(TForm)
    stbBarraStatus: TStatusBar;
    pnlBotoes: TPanel;
    btnConfirmar: TBitBtn;
    btnLimpar: TBitBtn;
    btnSair: TBitBtn;
    pnlFiltro: TPanel;
    gbrFiltrar: TGroupBox;
    lblNome: TLabel;
    lblInfo: TLabel;
    edtNome: TEdit;
    btnFiltrar: TBitBtn;
    pnlResultadoBusca: TPanel;
    gbrGrid: TGroupBox;
    dbgResultadoBusca: TDBGrid;
    dtsUsuario: TDataSource;
    cdsUsuario: TClientDataSet;
    cdsUsuarioUsuario: TStringField;
    cdsUsuarioNome: TStringField;
    cdsUsuarioCargo: TIntegerField;
    cdsUsuarioCargoDesc: TStringField;
    cdsUsuarioAtivo: TIntegerField;
    cdsUsuarioAtivoDesc: TStringField;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure cdsUsuarioBeforeDelete(DataSet: TDataSet);
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
    mUsuario : String;
  end;

var
  frmCadUsuaPesq: TfrmCadUsuaPesq;

implementation


{$R *.dfm}

{ TfrmCadUsuaPesq }

procedure TfrmCadUsuaPesq.LimpaTela;
var
   xI : Integer;
begin
   for xI := 0 to pred(ComponentCount) do
   begin
      if (Components[xI] is TEdit) then
         (Components[xI] as TEdit).Text := EmptyStr;
   end;

   if (not cdsUsuario.IsEmpty) then
      cdsUsuario.EmptyDataSet;

   if (edtNome.CanFocus) then
      (edtNome.SetFocus);
end;

procedure TfrmCadUsuaPesq.ProcessaPesquisa;
var
   xListaUsuarios : TColUsuario;
   xAux           : Integer;
begin
   try
      try
         xListaUsuarios := TColUsuario.Create;

         xListaUsuarios :=
            TCadUsuaController.getInstancia.PesquisaUsuario(Trim(edtNome.Text));

         cdsUsuario.EmptyDataSet;

         if xListaUsuarios <> nil then
         begin
            for xAux := 0 to pred(xListaUsuarios.Count) do
            begin
               cdsUsuario.Append;
               cdsUsuarioUsuario.Value := xListaUsuarios.Retorna(xAux).Usuario;
               cdsUsuarioNome.Value  := xListaUsuarios.Retorna(xAux).Nome;

               cdsUsuarioAtivo.Value :=
                  IfThen(xListaUsuarios.Retorna(xAux).Ativo,1, 0);

               cdsUsuarioAtivoDesc.Value :=
                  IfThen(
                     xListaUsuarios.Retorna(xAux).Ativo, 'Sim', 'N�o');

               if (xListaUsuarios.Retorna(xAux).Cargo = 0) then
                  cdsUsuarioCargo.Value := 1
               else
                  cdsUsuarioCargo.Value := 0;

               if (xListaUsuarios.Retorna(xAux).Cargo = 0) then
                  cdsUsuarioCargoDesc.Text := 'Gerente'
               else
                  cdsUsuarioCargoDesc.Text := 'Vendedor';

               cdsUsuario.Post;
            end;
         end;

         if (cdsUsuario.RecordCount = 0) then
         begin
            if edtNome.CanFocus then
               edtNome.SetFocus;

            TMessageUtil.Alerta(
               'Nenhum usu�rio encontrado para este filtro.');
         end
         else
         begin
            cdsUsuario.First;

            if dbgResultadoBusca.CanFocus then
               dbgResultadoBusca.SetFocus;
         end;
      finally
         if (xListaUsuarios <> nil) then
            FreeAndNil(xListaUsuarios);
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

procedure TfrmCadUsuaPesq.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmCadUsuaPesq.ProcessaConfirmacao;
begin
   if not cdsUsuario.IsEmpty then
   begin
      mUsuario     := cdsUsuarioUsuario.Value;
      Self.ModalResult := mrOk;
      LimpaTela;
      Close;
   end
   else
   begin
      TMessageUtil.Alerta('Nenhum Usu�rio selecionado.');

      if edtNome.CanFocus then
         edtNome.SetFocus;
   end;
end;

procedure TfrmCadUsuaPesq.btnFiltrarClick(Sender: TObject);
begin
   mUsuario := EmptyStr;
   ProcessaPesquisa;
end;

procedure TfrmCadUsuaPesq.btnConfirmarClick(Sender: TObject);
begin
   ProcessaConfirmacao;
end;

procedure TfrmCadUsuaPesq.btnLimparClick(Sender: TObject);
begin
    mUsuario := EmptyStr;
   LimpaTela;
end;

procedure TfrmCadUsuaPesq.btnSairClick(Sender: TObject);
begin
   LimpaTela;
   Close;
end;

procedure TfrmCadUsuaPesq.cdsUsuarioBeforeDelete(DataSet: TDataSet);
begin
   Abort;
end;

procedure TfrmCadUsuaPesq.dbgResultadoBuscaDblClick(Sender: TObject);
begin
   ProcessaConfirmacao;
end;

procedure TfrmCadUsuaPesq.dbgResultadoBuscaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if (Key = VK_RETURN) and
      (btnConfirmar.CanFocus) then
      btnConfirmar.SetFocus;
end;

end.
