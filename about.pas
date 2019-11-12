unit about;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TAboutForm = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutForm: TAboutForm;

implementation

uses
  VersionRoutine;

{$R *.DFM}

procedure TAboutForm.FormCreate(Sender: TObject);
var
  strFileName: string;
  strVersion: string;

begin
  strFileName := 'dragonfly.exe';

  strVersion := FileVersion(strFileName);

  Version.Caption := strVersion;

end;

end.
 
