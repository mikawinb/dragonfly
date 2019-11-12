program dragonfly;

uses
  Forms,
  vanda in 'vanda.pas' {Form1},
  about in 'about.pas' {AboutForm},
  fileEdit in 'fileEdit.pas' {FormFileEdit},
  Vcl.Themes,
  Vcl.Styles,
  VersionRoutine in 'VersionRoutine.pas';

{$E exe}

{$R *.RES}

begin
  Application.Initialize;
  TStyleManager.TrySetStyle('Windows10');
  Application.Title := 'Dagssländan';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.CreateForm(TFormFileEdit, FormFileEdit);
  Application.Run;
end.
