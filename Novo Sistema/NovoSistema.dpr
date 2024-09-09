program NovoSistema;

uses
  Forms,
  UPrincipalView in 'View\UPrincipalView.pas' {fmPrincipal},
  UCriptografiaUtil in 'Model\Util\UCriptografiaUtil.pas',
  UClassFuncoes in 'Model\Util\UClassFuncoes.pas',
  UConexao in 'Model\BD\UConexao.pas',
  Unit1 in 'Model\BD\Unit1.pas' {frmClientes};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmPrincipal, fmPrincipal);
  Application.Run;
end.
