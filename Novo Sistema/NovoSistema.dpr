program NovoSistema;

uses
  Forms,
  UPrincipalView in 'View\UPrincipalView.pas' {fmPrincipal},
  UCriptografiaUtil in 'Model\Util\UCriptografiaUtil.pas',
  UClassFuncoes in 'Model\Util\UClassFuncoes.pas',
  UConexao in 'Model\BD\UConexao.pas',
  UClienteView in 'UClienteView.pas' {frmClientes},
  uMessageUtil in 'Model\Util\uMessageUtil.pas',
  Consts in 'Model\Util\Consts.pas',
  UEnumerationUtil in 'Model\Util\UEnumerationUtil.pas',
  UPessoa in 'Model\UPessoa.pas',
  UPessoaDAO in 'Model\UPessoaDAO.pas',
  UGenericDAO in 'Model\BD\UGenericDAO.pas',
  UCliente in 'Model\UCliente.pas',
  UPessoaController in 'Controller\UPessoaController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmPrincipal, fmPrincipal);
  Application.Run;
end.
