unit UClienteView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Buttons, Mask , UEnumerationUtil,
  UCliente, UPessoaController, UEndereco, UClassFuncoes, frxClass, DB,
  DBClient, frxDBSet, frxExportPDF;

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
    edtNumero: TEdit;
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
    frxListagemCliente: TfrxReport;
    cdsCliente: TClientDataSet;
    cdsClienteID: TStringField;
    cdsClienteNome: TStringField;
    cdsClienteCPFCNPJ: TStringField;
    cdsClienteAtivo: TStringField;
    cdsClienteEndereco: TStringField;
    cdsClienteNumero: TStringField;
    cdsClienteComplemento: TStringField;
    cdsClienteBairro: TStringField;
    cdsClienteCidadeUF: TStringField;
    frxDBCliente: TfrxDBDataset;
    frxPDF: TfrxPDFExport;
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
    procedure edtCodigoExit(Sender: TObject);
    procedure rdgTipoPessoaClick(Sender: TObject);
    procedure edtCPFCNPJKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    { Private declarations }
    vKey : Word;

    //variaveis de classe
    vEstadoTela     : TEstadoTela;
    vObjCliente     : TCliente;
    vObjColEndereco : TColEndereco;  //podem ser varios endere�os

    procedure CamposEnable(pOpcao: Boolean);
    procedure LimpaTela; //n�o precisa de parametro pois a unica fun��o � limpar a tela
    procedure DefineEstadoTela;



    //Carrega Dados Padr�o na Tela
    procedure CarregaDadosTela;

    function ProcessaConfirmacao : Boolean; //fun��o sem parametro com retorno T or F
    function ProcessaInclusao    : Boolean;
    function ProcessaAlteracao   : Boolean;
    function ProcessaExclusao    : Boolean;
    function ProcessaConsulta    : Boolean;
    function ProcessaListagem    : Boolean;
    function ProcessaCliente     : Boolean;

    function ProcessaPessoa      : Boolean;
    function ProcessaEndereco    : Boolean;  //todos esses metodos tem como fun��o
                                             //capturar a informa��o dos metodos(leitura cin)
                                             // e passar esses resultados para os objetos
    function ValidaCliente            : Boolean;
    function ValidaEndereco           : Boolean;
    function ConfirmaValidacaoCPFCNPJ : Boolean;
  public
    { Public declarations }
  end;

var
  frmClientes: TfrmClientes;

implementation

uses
   uMessageUtil, Consts, UPessoa, UClientesPesqView, StrUtils;

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

     if (Components[i] is TComboBox) then
      begin
        (Components[i] as TComboBox).Clear;
        (Components[i] as TComboBox).ItemIndex := -1;
      end;


     if (Components[i] is TCheckBox) then //ent�o define
        (Components[i] as TCheckBox).Checked := False;

   end;

   if (vObjCliente <> nil) then
      FreeAndNil(vObjCliente);

   if (vObjColEndereco <> nil) then
      FreeAndNil(vObjColEndereco);

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

      etAlterar:
      begin
         stbBarraStatus.Panels[0].Text := 'Altera��o';


         if (edtCodigo.Text <> EmptyStr) then
         begin
            CamposEnable(True);

            edtCodigo.Enabled := False;
            btnAlterar.Enabled := False;
            btnConfirmar.Enabled := True;

            if (chkAtivo.CanFocus) then
               chkAtivo.SetFocus;

         end
         else
         begin
            lblCodigo.Enabled := True;
            edtCodigo.Enabled := True;

            if (edtCodigo.CanFocus) then
               edtCodigo.SetFocus;
         end;
      end;

      etExcluir:
      begin
         stbBarraStatus.Panels[0].Text := 'Exclus�o';

         if (edtCodigo.Text <> EmptyStr) then
            ProcessaExclusao
         else
         begin
            lblCodigo.Enabled := True;
            edtCodigo.Enabled := True;

            if (edtCodigo.CanFocus) then
               edtCodigo.SetFocus;
         end;
      end;


      etConsultar:
      begin
         stbBarraStatus.Panels[0].Text := 'Consulta';

         CamposEnable(False);

         if (edtCodigo.Text <> EmptyStr) then
         begin
            edtCodigo.Enabled    := False;
            btnAlterar.Enabled   := True;
            btnExcluir.Enabled   := True;
            btnListar.Enabled    := True;
            btnConfirmar.Enabled := False;

            if (btnAlterar.CanFocus) then
               btnAlterar.SetFocus;
         end
         else
         begin
            lblCodigo.Enabled := True;
            edtCodigo.Enabled := True;

            if edtCodigo.CanFocus then
               edtCodigo.SetFocus;
         end;
      end; 

      etListar:
      begin
         stbBarraStatus.Panels[0].Text := 'Listagem';

         if (edtCodigo.Text <> EmptyStr) then
            ProcessaListagem
         else
         begin
            lblCodigo.Enabled := True;
            edtCodigo.Enabled := True;

            if edtCodigo.CanFocus then
               edtCodigo.SetFocus;
         end;
      end;

      etPesquisar:
      begin
         stbBarraStatus.Panels[0].Text := 'Pesquisa';

         if (frmClientesPesq = nil) then
            frmClientesPesq := TfrmClientesPesq.Create(Application);

         frmClientesPesq.ShowModal;

         if (frmClientesPesq.mClienteID <> 0) then
         begin
            edtCodigo.Text := IntToStr(frmClientesPesq.mClienteID);
            vEstadoTela := etConsultar;
            ProcessaConsulta;
         end
         else
         begin
            vEstadoTela := etPadrao;
            DefineEstadoTela;
         end;

         frmClientesPesq.mClienteID   := 0;
         frmClientesPesq.mClienteNome := EmptyStr;

         if (edtNome.CanFocus) then
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
         etIncluir:   Result := ProcessaInclusao;
         etAlterar:   Result := ProcessaAlteracao;
         etExcluir:   Result := ProcessaExclusao;
         etConsultar: Result := ProcessaConsulta;
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
      try
        Result := False;

        if ProcessaCliente then
        begin
           TMessageUtil.Informacao(
           'Cliente cadastrado com sucesso.'#13+
              'C�digo cadastrado: ' + IntToStr(vObjCliente.Id));

           vEstadoTela := etPadrao;
           DefineEstadoTela;

           Result := True;
        end;

      except
         on E : Exception do
         begin
            Raise Exception.Create(
               'Falha ao incluir os dados do cliente[View]: '#13 +
               e.Message);
         end;
      end;
   finally
      if vObjCliente <> nil then
         FreeAndNil(vObjCliente);
   end;
end;

function TfrmClientes.ProcessaCliente: Boolean;
begin
   try
      Result := False;
      if(ProcessaPessoa) and (ProcessaEndereco) then
      begin
         //Grava��o no Banco de Dados
         TPessoaController.getInstancia.GravaPessoa(
            vObjCliente, vObjColEndereco);

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

      if not ValidaCliente then
         exit;

      if vEstadoTela = etIncluir then
      begin
         if vObjCliente = nil then
            vObjCliente := TCliente.Create;
      end
      else
      if vEstadoTela = etAlterar then
      begin
         if vObjCliente = nil then
            exit;
      end;

      if vObjCliente = nil then
         exit;

      vObjCliente.Tipo_Pessoa         := 0;
      vObjCliente.Nome                := edtNome.Text;
      vObjCliente.Fisica_Juridica     :=  rdgTipoPessoa.ItemIndex;
      vObjCliente.Ativo               := chkAtivo.Checked;
      vObjCliente.IdentificadorPessoa := edtCPFCNPJ.Text;

      Result := True;

   except
      on E : Exception do
      begin
         raise Exception.Create(
         'Falha ao processar os dados da Pessoa. [View]'#13 +
         e.Message);
      end;
   end;
end;

function TfrmClientes.ProcessaEndereco: Boolean;
var
   xEndereco  : TEndereco;
   xID_Pessoa : Integer;
begin
   try
     Result := False;


     xEndereco := nil;
     xID_Pessoa := 0;

     if (not ValidaEndereco) then
     exit;

     if (vObjColEndereco <> nil) then
        FreeAndNil(vObjColEndereco);

     vObjColEndereco := TColEndereco.Create;     //criando o objeto

     if vEstadoTela = etAlterar then
        xID_Pessoa := StrToIntDef(edtCodigo.Text , 0);

      xEndereco               := TEndereco.Create; //obj de apenas endereco
      xEndereco.ID_Pessoa     := xID_Pessoa;
      xEndereco.Tipo_Endereco := 0;
      xEndereco.Endereco      := edtEndereco.Text;
      xEndereco.Numero        := edtNumero.Text;
      xEndereco.Complemento   := edtComplemento.Text;
      xEndereco.Bairro        := edtBairro.Text;
      xEndereco.UF            := cmbUF.Text;
      xEndereco.Cidade        := edtCidade.Text;

     vObjColEndereco.Adiciona(xEndereco);

     Result := True;
   except
     on E : Exception do
     begin
        Raise Exception.Create(
        'Falha ao preencher os dados de endere�o do cliente. [View]'#13 +
        e.Message);
     end;

   end;
end;

function TfrmClientes.ValidaCliente: Boolean;
begin
   Result := False;

   if (edtNome.Text = EmptyStr) then
   begin
      TMessageUtil.Alerta('Nome do cliente n�o pode ficar em branco.');

      if edtNome.CanFocus then
         edtNome.SetFocus;
      exit;
   end;

   if not(TFuncoes.SoNumero(edtCPFCNPJ.Text) = EmptyStr) then
     if not ConfirmaValidacaoCPFCNPJ then
      Exit;

   Result := True;
end;

function TfrmClientes.ProcessaConsulta: Boolean;
begin
   try
      Result := False;

      if (edtCodigo.Text = EmptyStr) then
      begin
         TMessageUtil.Alerta('Codigo do cliente n�o pode ficar em branco.');

         if (edtCodigo.CanFocus) then
            edtCodigo.SetFocus;

         exit;
      end;

      vObjCliente :=
         TCliente(TPessoaController.getInstancia.BuscaPessoa(
            StrToIntDef(edtCodigo.Text, 0)));

      vObjColEndereco :=
         TPessoaController.getInstancia.BuscaEnderecoPessoa(
            StrToIntDef(edtCodigo.Text, 0));

      if (vObjCliente <> nil) then
         CarregaDadosTela
      else
      begin
         TMessageUtil.Alerta(
            'Nenhum cliente encontrado para o c�digo informado.');

         LimpaTela;

         if (edtCodigo.CanFocus) then
            edtCodigo.SetFocus;

         Exit;
      end;

      DefineEstadoTela;

      Result := True;

   except
      on E: Exception do
      begin
         raise Exception.Create(
         'Falha ao consultar os dados do cliente [View]:'#13 +
         e.Message);
      end;
   end;
end;

procedure TfrmClientes.CarregaDadosTela;
var
   i : Integer;
begin
   if (vObjCliente = nil) then     //valida��o de objeto
   exit;

   edtCodigo.Text          := IntToStr(vObjCliente.Id);
   rdgTipoPessoa.ItemIndex := vObjCliente.Fisica_Juridica;
   edtNome.Text            := vObjCliente.Nome;
   chkAtivo.Checked        := vObjCliente.Ativo;
   edtCPFCNPJ.Text         := vObjCliente.IdentificadorPessoa;

   // pelo fato de ser uma cole��o devo usar o for
   if (vObjColEndereco <> nil) then
   begin
      for i := 0 to pred(vObjColEndereco.Count) do
      begin
         edtEndereco.Text     := vObjColEndereco.Retorna(i).Endereco;
         edtNumero.Text       := vObjColEndereco.Retorna(i).Numero;
         edtComplemento.Text  := vObjColEndereco.Retorna(i).Complemento;
         edtBairro.Text       := vObjColEndereco.Retorna(i).Bairro;
         cmbUF.Text           := vObjColEndereco.Retorna(i).UF;
         edtCidade.Text       := vObjColEndereco.Retorna(i).Cidade;

      end;
   end;

end;

function TfrmClientes.ProcessaAlteracao: Boolean;
begin
   try
      Result := False;

      if ProcessaCliente then
      begin
         TMessageUtil.Informacao('Dados alterados com sucesso.');

         vEstadoTela := etPadrao;
         DefineEstadoTela;

         Result := True;
      end;
   except
      on E: Exception do
      begin
         raise Exception.Create(
            'Falha ao alterar os dados do cliente [View]: '#13+
            e.Message);
      end;
   end;  
end;

procedure TfrmClientes.edtCodigoExit(Sender: TObject);
begin
   if vKey = VK_RETURN then
      ProcessaConsulta;

   vKey := VK_CLEAR;
end;

function TfrmClientes.ProcessaExclusao: Boolean;
begin
   try
      Result := False;

      if (vObjCliente = nil) or (vObjColEndereco = nil) then
      begin
         TMessageUtil.Alerta(
         'N�o foi poss�vel carregar todos os dados cadastrados do cliente.');

         LimpaTela;
         vEstadoTela := etPadrao;
         DefineEstadoTela;
         exit;
      end;

      try
         if TMessageUtil.Pergunta('Confirma a exclus�o do cliente?') then
         begin
            //Exclus�o
            Screen.Cursor := crHourGlass;
            TPessoaController.getInstancia.ExcluiPessoa(vObjCliente);

            TMessageUtil.Informacao('Cliente exclu�do com sucesso. ');

         end
         else
         begin
            LimpaTela;
            vEstadoTela := etPadrao;
            DefineEstadoTela;
            Exit;
         end;
      finally
         Screen.Cursor := crDefault;
         Application.ProcessMessages;
      end;

      Result := True;

      LimpaTela;
      vEstadoTela := etPadrao;
      DefineEstadoTela;

   except

      on E: Exception do
      begin
         Raise Exception.Create(
            'Falha ao excluir os dados do cliente [View].'#13 +
            e.Message);
      end;

   end;
end;

function TfrmClientes.ValidaEndereco: Boolean;
begin
   Result := False;
   //comando trim � para n gravar os espa�os em branco
   if (Trim(edtEndereco.Text) = EmptyStr) then
   begin
      TMessageUtil.Alerta('Endere�o do cliente n�o pode ficar em branco.');

      if edtEndereco.CanFocus then
         edtEndereco.SetFocus;
         exit;
   end;

   if (Trim(edtNumero.Text) = EmptyStr ) then
   begin
      TMessageUtil.Alerta(
         'O n�mero de endere�o do cliente n�o pode ficar em branco.');

      if edtNumero.CanFocus then
         edtNumero.SetFocus;
         exit;
   end;

   if (Trim(edtBairro.Text) = EmptyStr ) then
   begin
      TMessageUtil.Alerta('O Bairro do cliente n�o pode ficar em branco.');

      if edtBairro.CanFocus then
         edtBairro.SetFocus;
         exit;
   end;

   if (Trim(edtCidade.Text) = EmptyStr ) then
   begin
      TMessageUtil.Alerta('A cidade do cliente n�o pode ficar em branco.');

      if edtCidade.CanFocus then
         edtCidade.SetFocus;
         exit;
   end;

   if (Trim(cmbUF.Text) = EmptyStr) then
   begin
      TMessageUtil.Alerta('O estado do cliente n�o pode ficar em branco.');

      if cmbUF.CanFocus then
         cmbUF.SetFocus;
         exit;
   end;

   Result := True;

end;
procedure TfrmClientes.rdgTipoPessoaClick(Sender: TObject);
begin
   if rdgTipoPessoa.ItemIndex = 1 then
   begin
      edtCPFCNPJ.Clear;
      edtCPFCNPJ.EditMask := '##\.###\.###\/####\-##;1;_'
   end
   else
   begin
      edtCPFCNPJ.Clear;
      edtCPFCNPJ.EditMask := '000\.000\.000\-00;1;_';
   end;
end;

procedure TfrmClientes.edtCPFCNPJKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if vKey = VK_RETURN then
      ConfirmaValidacaoCPFCNPJ;
end;

function TfrmClientes.ConfirmaValidacaoCPFCNPJ : Boolean;
begin
   Result := False;

   if (rdgTipoPessoa.ItemIndex = 0) then
   if (TPessoaController.getInstancia.ValidaCPF(TFuncoes.SoNumero(edtCPFCNPJ.Text)))then
   begin
      Result := True;
      exit
   end
   else
      TMessageUtil.Alerta('CPF inv�lido, favor informar um novo n�mero.');

   if (rdgTipoPessoa.ItemIndex = 1) then
   if (TPessoaController.getInstancia.ValidaCNPJ(TFuncoes.SoNumero(edtCPFCNPJ.Text))) then
   begin
      Result := True;
      exit;
   end
   else
     TMessageUtil.Alerta('CNPJ inv�lido, favor informar um novo n�mero.');

   edtCPFCNPJ.Text := '';

   if edtCPFCNPJ.CanFocus then
      edtCPFCNPJ.SetFocus;
end;

function TfrmClientes.ProcessaListagem: Boolean;
begin
   try
      if (not cdsCliente.Active) then
         exit;

      cdsCliente.Append;
      cdsClienteID.Value          := edtCodigo.Text;
      cdsClienteNumero.Value      := edtNumero.Text;
      cdsClienteNome.Value        := edtNome.Text;
      cdsClienteCPFCNPJ.Value     := edtCPFCNPJ.Text;
      cdsClienteAtivo.Value       := IfThen (chkAtivo.Checked, 'Sim', 'N�o');
      cdsClienteEndereco.Value    := edtEndereco.Text;
      cdsClienteComplemento.Value := edtComplemento.Text;
      cdsClienteBairro.Value      := edtBairro.Text;
      cdsClienteCidadeUF.Value    := edtCidade.Text + '/' + cmbUF.Text;
      cdsCliente.Post;

      frxListagemCliente.Variables['DATAHORA']    :=
         QuotedStr(FormatDateTime('DD/MM/YYYY hh:mm', Date + Time));
      frxListagemCliente.Variables['NOMEEMPRESA'] :=
         QuotedStr('Nome da empresa');
      frxListagemCliente.ShowReport();

   finally
      vEstadoTela := etPadrao;
      DefineEstadoTela;
      cdsCliente.EmptyDataSet;
   end;
end;

end.

