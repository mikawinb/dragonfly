unit fileEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormFileEdit = class(TForm)
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
    procedure CorrectButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormFileEdit: TFormFileEdit;
  fileName : String;
  fileData : TStringList;
  openDialog : TOpenDialog;

implementation

{$R *.dfm}

procedure TFormFileEdit.CorrectButtonClick(Sender: TObject);
begin
  // Clear the file display box and the label
  MemoBox.Clear;
  Label4.Caption := '';
  close;
end;

procedure TFormFileEdit.FormCreate(Sender: TObject);
begin
  // Set the title of the form - our application title
  FormFileEdit.Caption := 'Enkel fileditering';

  // Disable all except the load file button
  SaveButton.Enabled := false;
  // CorrectButton.Enabled := false;

  // Clear the file display box
  MemoBox.Clear;

  // Enable scroll bars for this memo box - this allows us to scroll up
  // and down and left and right to see all the text
  MemoBox.ScrollBars := ssBoth;

  // do not allow the user to directly type into the displayed file text
  // MemoBox.ReadOnly := true;

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
   openDialog.Filter := 'Text files (*.txt)|*.txt|Any file (*.*)|*.*';

   // Create the string list object that holds the file contents
   fileData := TStringList.Create;

end;

procedure TFormFileEdit.LoadButtonClick(Sender: TObject);
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

    SaveButton.Enabled := true;
  end;

end;

procedure TFormFileEdit.SaveButtonClick(Sender: TObject);
begin
  // Simply save the contents of the edited memobox
  if fileName <> '' then
  MemoBox.Lines.SaveToFile(fileName);
end;

end.
