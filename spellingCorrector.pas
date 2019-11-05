unit spellingCorrector;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    MemoBox: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LoadButton: TButton;
    SaveButton: TButton;
    CorrectButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure LoadButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  fileName : String;
  fileData : TStringList;
  openDialog : TOpenDialog;

implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
  // Set the title of the form - our application title
  Form2.Caption := 'Enkel stavningskorrigering';

  // Disable all except the load file button
  SaveButton.Enabled := false;
  CorrectButton.Enabled := false;

  // Clear the file display box
  MemoBox.Clear;

  // Enable scroll bars for this memo box - this allows us to scroll up
  // and down and left and right to see all the text
  MemoBox.ScrollBars := ssBoth;

  // do not allow the user to directly type into the displayed file text
  MemoBox.ReadOnly := true;

  // Set the font of the memo box to a mono-spaced one to ease reading
   MemoBox.Font.Name := 'Courier New';

   // Set all of the labels to blank
   Label1.Caption := '';
   Label2.Caption := '';
   Label3.Caption := '';
   Label4.Caption := '';

   // Create the open dialog object - used by the GetTextFile routine
   openDialog := TOpenDialog.Create(self);

   // Ask for only files that exist
   openDialog.Options := [OfFileMustExist];

   // Ask only for text files
   openDialog.Filter := 'Text files|*.txt';

   // Create the string list object that holds the file contents
   fileData := TStringList.Create;

end;

procedure TForm2.LoadButtonClick(Sender: TObject);
begin
  // Display the file selection dialog
  if openDialog.Execute then
  begin
    // Save the filename
    fileName := openDialog.FileName;

    // Now that we have a file loaded, enable the text correction button
    CorrectButton.Enabled := True;

    // Load the file into our string list
    fileData.LoadFromFile(fileName);

    // Display the file in the file display box
    MemoBox.Text := fileData.Text;

    // Clear the changed lines information
    Label1.Caption := '';
    Label2.Caption := '';
    Label3.Caption := '';

    // Display the number of lines in the file
    Label4.Caption := fileName+' har ' +IntToStr(fileData.Count)+ ' rader med text';
  end;

end;

end.
