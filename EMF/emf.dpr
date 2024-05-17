program emf;

{$R *.res}

uses
  Forms,
  OrdwEmf in 'OrdwEmf.pas',
  uMain in 'uMain.pas' {Form1},
  EmfToSvgUnit in 'EmfToSvgUnit.pas';

begin
  Application.Initialize();
  Application.CreateForm(TForm1, Form1);
  Application.Run();
end.
