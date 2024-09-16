unit UClienteView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Buttons, Mask , UEnumerationUtil,
  UCliente, UPessoaController;

type
  TfrmClientes = class(TForm)
    stbBarraStatus: TStatusBar;
    pnlBotoes: TPanel;
    pnlArea: TPanel;
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    chkAtivo: TCheckBox;
    rdgTipoPessoa: TRadioGroup;
    lblCPFCNPJ: TLabel;
    edtCPFCNPJ: TMaskEdit;
    lblNome: TLabel;
    edtNome: TEdit;
    grbEndereco: TGroupBox;
    lblBairro: TLabel;
    edtBairro: TEdit;
    lblEndereco: TLabel;
    edtEndereco: TEdit;
    lblNumero: TLabel;
    Edit1: TEdit;
    lblComplemento: TLabel;
    edtComplemento: TEdit;
    lblUF: TLabel;
    cmbUF: TComboBox;
    lblCidade: TLabel;
    edtCidade: TEdit;
    btnIncluir: TBitBtn;
    btnAlterar: TBitBtn;
    btnExcluir: TBitBtn;
    btnConsultar: TBitBtn;
    btnListar: TBitBtn;
    btnPesquisar: TBitBtn;
    btnConfirmar: TBitBtn;
    btnCancelar: TBitBtn;
    btnSair: TBitBtn;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnListarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    vKey : Word;

    //variaveis de classe
    vEstadoTela : TEstadoTela;
    vObjCliente : TCliente;

    procedure CamposEnable(pOpcao: Boolean);
    procedure LimpaTela; //n�o precisa de parametro pois a unica fun��o � limpar a tela
    procedure DefineEstadoTela;

    function ProcessaConfirmacao : Boolean; //fun��o sem parametro com retorno T or F
    function ProcessaInclusao    : Boolean;
    function ProcessaCliente     : Boolean;

    function ProcessaPessoa      : Boolean;
    function ProcessaEndereco    : Boolean;  //todos esses metodos tem como fun��o
                                             //capturar a informa��o dos metodos(leitura cin)
                                             // e passar esses resultados para os objetos

  public
    { Public declarations }
  end;

var
  frmClientes: TfrmClientes;

implementation

uses
   uMessageUtil, Consts;

{$R *.dfm}

procedure TfrmClientes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);  //KeyDown
begin
   vKey := Key;  //nossa variavel privada recebe a variavel da procedure keydown

   case vKey of
       VK_RETURN: //correspondente a tecla <Enter> toda vez q pressionar o enter
       begin   //sistema vai pro proximo campo, pelo comando perform
          Perform(WM_NextDlgCtl, 0, 0); //passa para o proximo campo do formulario
       end;

       VK_ESCAPE: //correspondente a tecla <ESC>
       begin
          if (vEstadoTela <> etPadrao) then
          begin
             if(TMessageUtil.Pergunta(
                'Deseja realmente abortar esta opera��o?')) then
             begin
               vEstadoTela := etPadrao;
               DefineEstadoTela;
             end;
          end

          else
          begin
            if (TMessageUtil.Pergunta(
               'Deseja sair da rotina?')) then
               Close;   //fecha o formulario
          end;
       end;
    end;
end;

procedure TfrmClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree;
   frmClientes := nil;
end;

procedure TfrmClientes.CamposEnable(pOpcao: Boolean);
var
   i: Integer; //variavel auxiliar do comando de repeti��o
begin
   for i := 0 to pred(ComponentCount) do
   begin
     //se o campo for do tipo edit
      if (Components[i] is TEdit) then
         (Components[i] as TEdit).Enabled := pOpcao;

     //Se o campo for de maskEdit
      if (Components[i] is TMaskEdit) then
         (Components[i] as TMaskEdit).Enabled := pOpcao;

     //se for do tipo Radio Group
      if (Components[i] is TRadioGroup) then
         (Components[i] as TRadioGroup).Enabled := pOpcao;

      //se for do tipo Combo box
      if (Components[i] is TComboBox) then
         (Components[i] as TComboBox).Enabled := pOpcao;

      //se for do tipo check box
      if (Components[i] is TCheckBox) then
         (Components[i] as TCheckBox).Enabled := pOpcao;

   end;

   grbEndereco.Enabled := pOpcao;
end;

procedure TfrmClientes.LimpaTela;
var
  i : Integer;
begin
  for i := 0 to pred(ComponentCount) do
   begin
     if (Components[i] is TEdit) then
        (Components[i] as TEdit).Text := EmptyStr;

     if (Components[i] is TMaskEdit) then
        (Components[i] as TMaskEdit).Text := EmptyStr;

     if (Components[i] is TRadioGroup) then
        (Components[i] as TRadioGroup).ItemIndex := 0;

     if (Components[i] is TComboBox) then  //padrao -1
      begin
        (Components[i] as TComboBox).Clear;
        (Components[i] as TComboBox).ItemIndex := -1;
      end;


     if (Components[i] is TCheckBox) then //ent�o define
        (Components[i] as TCheckBox).Checked := False;

   end;
end;

procedure TfrmClientes.DefineEstadoTela;
begin
   btnIncluir.Enabled   := (vEstadoTela in [etPadrao]);
   btnAlterar.Enabled   := (vEstadoTela in [etPadrao]);
   btnExcluir.Enabled   := (vEstadoTela in [etPadrao]);
   btnConsultar.Enabled := (vEstadoTela in [etPadrao]);
   btnListar.Enabled    := (vEstadoTela in [etPadrao]);
   btnPesquisar.Enabled := (vEstadoTela in [etPadrao]);

   btnConfirmar.Enabled :=
      vEstadoTela in [etIncluir, etAlterar, etExcluir, etConsultar];

   btnCancelar.Enabled :=
      vEstadoTela in [etIncluir, etAlterar, etExcluir, etConsultar];

   case vEstadoTela of
      etPadrao:
      begin
          CamposEnable(False);
          LimpaTela;

          stbBarraStatus.Panels[0].Text := EmptyStr;
          stbBarraStatus.Panels[1].Text := EmptyStr;

          if (frmClientes <> nil) and
             (frmClientes.Active) and
             (btnIncluir.CanFocus) then
             btnIncluir.SetFocus;

          Application.ProcessMessages;
      end;

      etIncluir:
      begin
         stbBarraStatus.Panels[0].Text := 'Inclus�o';
         CamposEnable(True);

         edtCodigo.Enabled := False;

         chkAtivo.Checked := True;

         if edtNome.CanFocus then
            edtNome.SetFocus;

      end;


   end;

end;
procedure TfrmClientes.btnIncluirClick(Sender: TObject);
begin
   vEstadoTela := etIncluir;
   DefineEstadoTela;
end;

procedure TfrmClientes.btnAlterarClick(Sender: TObject);
begin
   vEstadoTela := etAlterar;
   DefineEstadoTela;
end;

procedure TfrmClientes.btnExcluirClick(Sender: TObject);
begin
   vEstadoTela := etExcluir;
   DefineEstadoTela;
end;

procedure TfrmClientes.btnConsultarClick(Sender: TObject);
begin
   vEstadoTela  := etConsultar;
   DefineEstadoTela;
end;

procedure TfrmClientes.btnListarClick(Sender: TObject);
begin
   vEstadoTela := etListar;
   DefineEstadoTela;
end;

procedure TfrmClientes.btnPesquisarClick(Sender: TObject);
begin
   vEstadoTela := etPesquisar;
   DefineEstadoTela;
end;

procedure TfrmClientes.btnConfirmarClick(Sender: TObject);
begin
   ProcessaConfirmacao;
end;

procedure TfrmClientes.btnCancelarClick(Sender: TObject);
begin
   vEstadoTela := etPadrao;
   DefineEstadoTela;
end;

procedure TfrmClientes.btnSairClick(Sender: TObject);
begin //para n rolar de fechar a tela sem querer e perder os dados
  if (vEstadoTela <> etPadrao) then
  begin
     if (TMessageUtil.Pergunta('Deseja realmente abortar esta opera��o?')) then
     begin
       vEstadoTela  := etPadrao;
       DefineEstadoTela;
     end;
  end
  else;
   Close;
end;

procedure TfrmClientes.FormCreate(Sender: TObject);
begin
   vEstadoTela := etPadrao;
end;

procedure TfrmClientes.FormShow(Sender: TObject);
begin
   DefineEstadoTela;
end;

procedure TfrmClientes.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);      //quando vc pressiona a tecla e keyUp � quando vc solta a tecla, quando n�o esta mais clicada
begin
   vKey := VK_CLEAR; //LIMPA A VARIAVEL QUE ESTAVA NO KEYDOWN
end;

function TfrmClientes.ProcessaConfirmacao: Boolean;
begin
   Result := False;

   try
      case vEstadoTela of
         etIncluir: Result := ProcessaInclusao;

      end;

      if not Result then
         Exit;
   except
      on E: Exception do
         TMessageUtil.Alerta(E.Message);

   end;

   Result := True;
end;

function TfrmClientes.ProcessaInclusao: Boolean;
begin

   try
     Result := False;

     if ProcessaCliente then
     begin
        TMessageUtil.Informacao(
        'Cliente cadastrado com sucesso'#13+
           'C�digo cadastrado: ' + IntToStr(vObjCliente.Id));

        vEstadoTela := etPadrao;
        DefineEstadoTela;

        Result := True;
     end;

   except
      on E: Exception do
      begin
         Raise Exception.Create(
            'Falha ao incluir os dados do cliente[View]: '#13 +
            e.Message);

      end;
   end;

end;

function TfrmClientes.ProcessaCliente: Boolean;
begin

   try
     if(ProcessaPessoa) and
       (ProcessaEndereco) then
       begin
         //Grava��o no Banco de Dados
         TPessoaController.getInstancia.GravaPessoa(vObjCliente);
         

         Result := True;
       end;




   except
      on E : Exception do
         Raise Exception.Create(
            'Falha ao gravar os dados do cliente [View]: '#13+
             e.Message );

   end;  
end;

function TfrmClientes.ProcessaPessoa: Boolean;
begin
   try
      Result := False;

//      if not ValidaCliente then
//      Exit;

      if vEstadoTela = etIncluir then
      begin
         if vObjCliente = nil then
            vObjCliente := TCliente.Create;
      end
      else
      if vEstadoTela = etAlterar then
      begin
         if vObjCliente = nil then
            Exit;
      end;

      if (vObjCliente = nil) then
            Exit;

      vObjCliente.Tipo_Pessoa         := 0; //representa um cliente
      vObjCliente.Nome                := edtNome.Text;
      vObjCliente.Fisica_Juridica     :=  rdgTipoPessoa.ItemIndex;
      vObjCliente.Ativo               := chkAtivo.Checked;
      vObjCliente.IdentificadorPessoa := edtCPFCNPJ.Text;

      Result := True;

   except
      on E : Exception do
      begin
         raise Exception.Create(
         'Falha ao processar os dados da Pessoa[View]'#13 +
         e.Message);
      end;


   end;  

end;

function TfrmClientes.ProcessaEndereco: Boolean;
begin
   try
     Result := False;

     Result := True;

   except
     on E : Exception do
     begin
        Raise Exception.Create(
        'Falha ao preencher os dados de endere�o do cliente[View]'#13 +
        e.Message);
     end;

   end;  
end;

end.

