program dragonfly;

uses
  Forms,
  vanda in 'vanda.pas' {Form1},
  about in 'about.pas' {AboutForm},
  spellingCorrector in 'spellingCorrector.pas' {Form2};

{$E exe}

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Dagssländan';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
