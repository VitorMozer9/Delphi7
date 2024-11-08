unit UVendaView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Mask, NumEdit, DB,
  DBClient, Grids, DBGrids, UEnumerationUtil, uMessageUtil, UVenda, UVendaController,
  UPessoaController, UVendaItem;

type
  TfrmVendasView = class(TForm)
    stbBarraStatus: TStatusBar;
    pnlBotoes: TPanel;
    btnIncluir: TBitBtn;
    btnConsultar: TBitBtn;
    btnPesquisar: TBitBtn;
    btnConfirmar: TBitBtn;
    btnCancelar: TBitBtn;
    btnSair: TBitBtn;
    pnlPagamentos: TPanel;
    pnlPedidos: TPanel;
    gbrPedidos: TGroupBox;
    pnlProdutos: TPanel;
    gbrProdutos: TGroupBox;
    lblNome: TLabel;
    edtNome: TEdit;
    btnCliente: TSpeedButton;
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    mskData: TMaskEdit;
    lblData: TLabel;
    lblNumeroVenda: TLabel;
    edtNumeroVenda: TEdit;
    cmbPagamento: TComboBox;
    lblPagamento: TLabel;
    lblDesconto: TLabel;
    edtDesconto: TNumEdit;
    lblValor: TLabel;
    edtValor: TNumEdit;
    lblValorTotal: TLabel;
    edtTotalValor: TNumEdit;
    dtsProdutos: TDataSource;
    cdsProdutos: TClientDataSet;
    cdsProdutosID: TIntegerField;
    cdsProdutosDescricao: TStringField;
    cdsProdutosUniPreco: TFloatField;
    cdsProdutosUniSaida: TStringField;
    cdsProdutosQuantidade: TFloatField;
    cdsProdutosTotalPreco: TFloatField;
    btnLimpar: TBitBtn;
    dbgProdutos: TDBGrid;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnClienteClick(Sender: TObject);
    procedure edtCodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtDescontoExit(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure dbgProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure cdsProdutosAfterPost(DataSet: TDataSet);
    procedure cdsProdutosBeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
   vKey : Word;
   vEstadoTela : TEstadoTela;
   vObjVenda   : TVenda;
   vTotalPreco : Double;
//   vObjColVendaItem : TColVendaItem;

   procedure CamposEnable(pOpcao : Boolean);
   procedure LimpaTela;
   procedure DefineEstadoTela;
   procedure CarregaDadosTela;
   procedure ProcessaItemVenda;


   function CarregaCliente      : Boolean;
   function ProcessaConfirmacao : Boolean;
   function ProcessaInclusao    : Boolean;
   function ProcessaVenda       : Boolean;
   function ProcessaConsulta    : Boolean;
   function ValidaCampos        : Boolean;
   function InsereDesconto(pDesconto : Double; pValorTotal : Double) : Double;

  public
    { Public declarations }

  end;

var
  frmVendasView: TfrmVendasView;

implementation

uses Types, Math, UClientesPesqView, UClienteView,UPessoa,UProduto,UProdutoController,
   UVendaItemController;

{$R *.dfm}

procedure TfrmVendasView.CamposEnable(pOpcao: Boolean);
var
   xI : Integer;
begin
   for xI := 0 to pred(ComponentCount) do
   begin

      if (Components[xI] is TEdit) then
         (Components[xI] as TEdit).Enabled := pOpcao;

      if (Components[xI] is TNumEdit) then
         (Components[xI] as TNumEdit).Enabled := pOpcao;

      if (Components[xI] is TMaskEdit) then
         (Components[xI] as TMaskEdit).Enabled := pOpcao;

      if (Components[xI] is TDBGrid) then
         (Components[xI] as TDBGrid).Enabled := pOpcao;

      if (Components[xI] is TComboBox) then
         (Components[xI] as TComboBox).Enabled := pOpcao;

   end;
end;

procedure TfrmVendasView.DefineEstadoTela;
begin
   btnIncluir.Enabled   := (vEstadoTela in [etPadrao]);
   btnConsultar.Enabled := (vEstadoTela in [etPadrao]);
   btnPesquisar.Enabled := (vEstadoTela in [etPadrao]);

   btnConfirmar.Enabled :=
      vEstadoTela in [etIncluir,etConsultar];

   btnCancelar.Enabled :=
      vEstadoTela in [etIncluir,etConsultar];

   case vEstadoTela of
      etPadrao:
      begin
         CamposEnable(False);
         cmbPagamento.Enabled := False;
         btnLimpar.Enabled := False;
         LimpaTela;

         stbBarraStatus.Panels[0].Text := EmptyStr;
         stbBarraStatus.Panels[1].Text := EmptyStr;

         if (frmVendasView <> nil) and
            (frmVendasView.Active) and
            (btnConfirmar.CanFocus)then
            btnConfirmar.SetFocus;

         cmbPagamento.Text := EmptyStr;

         Application.ProcessMessages;
      end;

      etIncluir:
      begin
         stbBarraStatus.Panels[0].Text := 'Inclus�o';
         CamposEnable(True);

         btnLimpar.Enabled      := True;
         btnCliente.Enabled     := True;
         cmbPagamento.Enabled   := True;
         edtTotalValor.Enabled  := False;
         edtNumeroVenda.Enabled := False;
         edtNome.Enabled        := False;
         mskData.Enabled        := False;

         mskData.Text := DateTimeToStr(Now);

         if (edtCodigo.CanFocus) then
            edtCodigo.SetFocus;
      end;

      etConsultar:
      begin
         stbBarraStatus.Panels[0].Text := 'Consulta';

         CamposEnable(False);
         btnLimpar.Enabled := True;

         if (edtNumeroVenda.Text <> EmptyStr) then
         begin
            edtNumeroVenda.Enabled  := False;
            btnConfirmar.Enabled := False;

            if (btnConfirmar.CanFocus) then
               btnConfirmar.SetFocus;
         end
         else
         begin
            lblNumeroVenda.Enabled := True;
            edtNumeroVenda.Enabled := True;

            if edtNumeroVenda.CanFocus then
               edtNumeroVenda.SetFocus;
         end;
      end;
   end;
end;

procedure TfrmVendasView.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   vKey := Key;

   case vKey of
      VK_RETURN:
      begin
         //dbgProdutos.SelectedIndex := 4;
         //Perform(WM_NEXTDLGCTL,0,0);
      end;

      VK_ESCAPE:
      begin
         if vEstadoTela <> etPadrao then
         begin
            if (TMessageUtil.Pergunta(
               'Deseja abortar esta opera��o?')) then
            begin
               vEstadoTela := etPadrao;
               DefineEstadoTela;
            end;
         end
         else
         begin
            if (TMessageUtil.Pergunta(
               'Deseja sair da rotina?')) then
               Close;
         end;
      end;
   end;
end;

procedure TfrmVendasView.LimpaTela;
var
   xI : Integer;
begin
   edtTotalValor.Value := 0;
   edtValor.Value := 0;
   mskData.Text := EmptyStr;
   edtDesconto.Value := 0;
   vTotalPreco := 0;

   for xI := 0 to pred(ComponentCount) do
   begin
     if (Components[xI] is TEdit) then
        (Components[xI] as TEdit).Text := EmptyStr;


     if (Components[xI] is TComboBox) then
      begin
        (Components[xI] as TComboBox).ItemIndex := -1;
      end;

      if (not cdsProdutos.IsEmpty) then
         cdsProdutos.EmptyDataSet;
   end;
end;

procedure TfrmVendasView.btnIncluirClick(Sender: TObject);
begin
   vEstadoTela := etIncluir;
   DefineEstadoTela;
end;

procedure TfrmVendasView.btnConsultarClick(Sender: TObject);
begin
   vEstadoTela := etConsultar;
   DefineEstadoTela;
end;

procedure TfrmVendasView.btnPesquisarClick(Sender: TObject);
begin
   vEstadoTela := etPesquisar;
   DefineEstadoTela;
end;

procedure TfrmVendasView.btnConfirmarClick(Sender: TObject);
begin
   ProcessaConfirmacao;
end;

procedure TfrmVendasView.btnCancelarClick(Sender: TObject);
begin
    vEstadoTela := etPadrao;
   DefineEstadoTela;
end;

procedure TfrmVendasView.btnSairClick(Sender: TObject);
begin
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

function TfrmVendasView.ProcessaConfirmacao: Boolean;
begin
   Result := False;

   try
      case vEstadoTela of
         etIncluir: Result := ProcessaInclusao;
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

function TfrmVendasView.ProcessaInclusao: Boolean;
begin
    Result := False;
   try
      try
        if ProcessaVenda then
        begin
           TMessageUtil.Informacao('Venda cadastrada com sucesso'#13 +
             'C�digo cadastrado: ' + IntToStr(vObjVenda.ID));

           vEstadoTela := etPadrao;
           DefineEstadoTela;

           Result := True;
        end;

      except
         on E : Exception do
         begin
            Raise Exception.Create(
               'Falha ao incluir os dados da venda[View]: '#13 +
               e.Message);
         end;
      end;
   finally
      if vObjVenda <> nil then
         FreeAndNil(vObjVenda);
   end;
end;

function TfrmVendasView.ProcessaVenda: Boolean;
begin
   try
      Result := False;

      if not ValidaCampos then
         exit;

      if vEstadoTela = etIncluir then
      begin
         if vObjVenda = nil then
            vObjVenda := TVenda.Create;
      end;

      if (vObjVenda = nil) then
         Exit;

      vObjVenda.ID_Cliente     := StrToInt(edtCodigo.Text);
      vObjVenda.TotalDesconto  := edtDesconto.Value;
      vObjVenda.ValorVenda     := edtValor.Value;
      vObjVenda.DataVenda      := Now;
      vObjVenda.TotalVenda     := InsereDesconto(edtDesconto.Value, edtTotalValor.Value);
      vObjVenda.FormaPagamento := cmbPagamento.Text;

      TVendaController.getInstancia.GravaVenda(vObjVenda);

      Result := True;

   except
      on E : Exception do
      begin
         raise Exception.Create(
         'Falha ao processar os dados da venda[View]'#13 +
         e.Message);
      end;
   end;
end;

function TfrmVendasView.ValidaCampos: Boolean;
begin
   Result := False;

   if (edtCodigo.Text = EmptyStr) then
   begin
      TMessageUtil.Alerta(
         'O c�digo do cliente n�o pode ficar em branco.  ');

      if (edtCodigo.CanFocus) then
         edtCodigo.SetFocus;
         exit;
   end;

   if (edtNome.Text = EmptyStr) then
   begin
      TMessageUtil.Alerta(
         'O nome do cliente n�o pode ficar em branco.  ');

      if (edtNome.CanFocus) then
         edtNome.SetFocus;
         exit;
   end;

   if (cmbPagamento.Text = EmptyStr) then
   begin
      TMessageUtil.Alerta(
         'A forma de pagamento da venda n�o pode ficar em branco.  ');

      if (cmbPagamento.CanFocus) then
         cmbPagamento.SetFocus;
         exit;
   end;

   if CompareValue(edtValor.Value,0,0.001) = EqualsValue then
   begin
      TMessageUtil.Alerta(
         'O valor da venda n�o pode ficae em branco. ');

      if (edtValor.CanFocus) then
         edtValor.SetFocus;
         exit;
   end;


   Result := True;
end;

procedure TfrmVendasView.FormCreate(Sender: TObject);
begin
   vEstadoTela := etPadrao;
end;

procedure TfrmVendasView.FormShow(Sender: TObject);
begin
   DefineEstadoTela;
   cmbPagamento.Items.Clear;
   cmbPagamento.Items.Add('Cart�o de cr�dito');
   cmbPagamento.Items.Add('Cart�o de D�bito');
   cmbPagamento.Items.Add('Dinheiro');
   cmbPagamento.Items.Add('Pix');

   cdsProdutos.Open;
end;

procedure TfrmVendasView.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   vKey := VK_CLEAR;
end;

function TfrmVendasView.ProcessaConsulta: Boolean;
begin
   try
      Result := False;

      if (edtNumeroVenda.Text = EmptyStr) and (frmClientesPesq.mClienteID = 0) then
      begin
         TMessageUtil.Alerta('N�mero da venda n�o pode ficar em branco.');

         if (edtNumeroVenda.CanFocus) then
            edtNumeroVenda.SetFocus;

         exit;
      end;

      vObjVenda :=
         TVendaController.getInstancia.BuscaVenda(
            StrToIntDef(edtNumeroVenda.Text, 0));

      if (vObjVenda <> nil) then
      begin
         CarregaDadosTela;
         CarregaCliente;
      end
      else
      begin
         TMessageUtil.Alerta('Nenhum dado de venda encontrado.');

         edtNumeroVenda.Clear;

         if (edtNumeroVenda.CanFocus) then
            edtNumeroVenda.SetFocus;
         exit;
      end;

      Result := True;
   except
      on E : Exception do
      begin
         raise Exception.Create(
            'Falha ao processar dados de consulta de venda [View]: '#13 +
            e.Message);
      end;
   end;
end;

procedure TfrmVendasView.CarregaDadosTela;
begin
   if (vObjVenda = nil) and (frmClientesPesq.mClienteID <> 0) then
      CarregaCliente
   else
   begin
      edtNumeroVenda.Text        := IntToStr(vObjVenda.ID);
      edtCodigo.Text             := IntToStr(vObjVenda.ID_Cliente);
      mskData.Text               := DateTimeToStr(vObjVenda.DataVenda);
      cmbPagamento.Text          := vObjVenda.FormaPagamento;
      edtValor.Value             := vObjVenda.ValorVenda;
      edtDesconto.Value          := vObjVenda.TotalDesconto;
      edtTotalValor.Value        := InsereDesconto(vObjVenda.TotalDesconto, vObjVenda.TotalVenda);
      btnCancelar.Enabled        := True;
   end;
end;

procedure TfrmVendasView.btnClienteClick(Sender: TObject);
begin
   try
      Screen.Cursor := crHourGlass;

      if frmClientes  = nil then
            frmClientes := TfrmClientes.Create(Application);

         frmClientes.Show;

   finally
      Screen.Cursor := crDefault;
   end;
end;

procedure TfrmVendasView.edtCodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if vKey = VK_RETURN then
   begin
      if (edtCodigo.Text = EmptyStr) Then
      begin
         Screen.Cursor := crHourGlass;
         if frmClientesPesq  = nil then
            frmClientesPesq := TfrmClientesPesq.Create(Application);

         frmClientesPesq.ShowModal;
         if (frmClientesPesq.mClienteID <> 0) then
         begin
            edtCodigo.Text := IntToStr(frmClientesPesq.mClienteID);
            CarregaCliente;
         end;
         Screen.Cursor := crDefault;
      end
      else
         CarregaCliente;
   end;
   vKey := VK_CLEAR;
end;


function TfrmVendasView.CarregaCliente: Boolean;
var
   xPessoa : TPessoa;
begin
   try
      Result := False;
      xPessoa := TPessoa.Create;

      xPessoa :=
         TPessoa(TPessoaController.getInstancia.BuscaPessoa(
            StrToIntDef(edtCodigo.Text, 0)));

      if (xPessoa <> nil) then
         edtNome.Text := xPessoa.Nome
      else
      begin
         TMessageUtil.Alerta('Nenhum cliente encontrado para o c�digo informado.');
         LimpaTela;
         if (edtCodigo.CanFocus) then
            edtCodigo.SetFocus;

         Exit;
      end;
      DefineEstadoTela;
   finally
      if (xPessoa <> nil) then
         FreeAndNil(xPessoa);
   end;
end;


procedure TfrmVendasView.edtCodigoExit(Sender: TObject);
begin
   if (edtCodigo.Text = EmptyStr) then
      edtNome.Text := EmptyStr;
end;



function TfrmVendasView.InsereDesconto(pDesconto: Double;
pValorTotal : Double): Double;
var
   xDesconto : Double;
begin
   xDesconto := pValorTotal * (pDesconto / 100);
   Result := pValorTotal - xDesconto;
end;

procedure TfrmVendasView.edtDescontoExit(Sender: TObject);
begin
   if (CompareValue(edtDesconto.Value,100,0.001) = GreaterThanValue) then
   begin
      edtDesconto.Value := 100;
   end;
end;

procedure TfrmVendasView.btnLimparClick(Sender: TObject);
begin
   LimpaTela;
end;

Procedure TfrmVendasView.ProcessaItemVenda;
var
   xIDProduto : Integer;
   xProduto : TProduto;
begin
   try
      try
         xProduto := nil;

         xProduto := TProduto.Create;

         xIDProduto :=
            dbgProdutos.DataSource.DataSet.FieldByName('ID').AsInteger;
         xProduto :=
            TProdutoController.getInstancia.BuscaProduto(xIDProduto);

         if xProduto <> nil then
         begin
            dbgProdutos.DataSource.DataSet.Edit;
            dbgProdutos.DataSource.DataSet.FieldByName('Descricao').AsString := xProduto.Descricao;
            dbgProdutos.DataSource.DataSet.FieldByName('UniPreco').AsFloat := xProduto.PrecoVenda;
            dbgProdutos.DataSource.DataSet.FieldByName('UniSaida').AsString := xProduto.Unidade;
            dbgProdutos.DataSource.DataSet.FieldByName('Quantidade').AsFloat := 1;
            dbgProdutos.DataSource.DataSet.FieldByName('TotalPreco').AsFloat := xProduto.PrecoVenda;
            dbgProdutos.DataSource.DataSet.Post;
         end
         else
            TMessageUtil.Alerta('Nenhum Produto Encontrado para este c�digo');

//         edtTotalValor.Value :=
//            dbgProdutos.DataSource.DataSet.FieldByName('TotalPreco').AsFloat;
      finally
         //dbgProdutos.SetFocus(4);
         if (xProduto <> nil) then
            FreeAndNil(xProduto);
      end;
   except
      on E : Exception do
      begin
         raise Exception.Create(
            'Falha ao processar dados da venda do item [View]'+#13 +
            e.Message);
      end;
   end;
end;

procedure TfrmVendasView.dbgProdutosKeyPress(Sender: TObject;
  var Key: Char);
begin
   if (vKey = VK_RETURN) then
   begin
      if (dbgProdutos.SelectedIndex = 0) then
         ProcessaItemVenda;

      if(dbgProdutos.SelectedIndex = 0) then
         dbgProdutos.SelectedIndex := 0
      else
         dbgProdutos.SelectedIndex := 4;

      if (dbgProdutos.DataSource.DataSet.FieldByName('Descricao').AsString <> EmptyStr) then
      begin
         dbgProdutos.DataSource.DataSet.Append;
      end;

   end;

   vKey := VK_CLEAR;
end;

procedure TfrmVendasView.cdsProdutosAfterPost(DataSet: TDataSet);
begin
   vTotalPreco :=
      vTotalPreco + dbgProdutos.DataSource.DataSet.FieldByName('UniPreco').AsFloat;

      edtTotalValor.Text := FloatToStr(vTotalPreco);
end;

procedure TfrmVendasView.cdsProdutosBeforeDelete(DataSet: TDataSet);
begin
   vTotalPreco := vTotalPreco - dbgProdutos.DataSource.DataSet.FieldByName('UniPreco').AsFloat;

   edtTotalValor.Text := FloatToStr(vTotalPreco);
end;

end.
