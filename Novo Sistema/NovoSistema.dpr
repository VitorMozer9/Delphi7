program NovoSistema;

uses
  Forms,
  UPrincipalView in 'View\UPrincipalView.pas' {fmPrincipal},
  UCriptografiaUtil in 'Model\Util\UCriptografiaUtil.pas',
  UClassFuncoes in 'Model\Util\UClassFuncoes.pas',
  UConexao in 'Model\BD\UConexao.pas',
  uMessageUtil in 'Model\Util\uMessageUtil.pas',
  Consts in 'Model\Util\Consts.pas',
  UEnumerationUtil in 'Model\Util\UEnumerationUtil.pas',
  UPessoa in 'Model\UPessoa.pas',
  UPessoaDAO in 'Model\UPessoaDAO.pas',
  UGenericDAO in 'Model\BD\UGenericDAO.pas',
  UCliente in 'Model\UCliente.pas',
  UPessoaController in 'Controller\UPessoaController.pas',
  UEnderecoDAO in 'Model\UEnderecoDAO.pas',
  UEndereco in 'Model\UEndereco.pas',
  UClienteView in 'View\UClienteView.pas' {frmClientes},
  UClientesPesqView in 'View\UClientesPesqView.pas' {frmClientesPesq},
  UUnidadeProdView in 'View\UUnidadeProdView.pas' {frmUnidadeProd},
  UUnidadeProduto in 'Model\UUnidadeProduto.pas',
  UUnidadeProdDAO in 'Model\UUnidadeProdDAO.pas',
  UUnidadeProdController in 'Controller\UUnidadeProdController.pas',
  UUnidadeProdPesqView in 'View\UUnidadeProdPesqView.pas' {frmUnidadePesq},
  UProdutoView in 'View\UProdutoView.pas' {frmProdutoView},
  UProduto in 'Model\UProduto.pas',
  UProdutoDAO in 'Model\UProdutoDAO.pas',
  UProdutoController in 'Controller\UProdutoController.pas',
  UProdutoPesqView in 'View\UProdutoPesqView.pas' {frmProdutoPesq};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmPrincipal, fmPrincipal);
  Application.Run;
end.
