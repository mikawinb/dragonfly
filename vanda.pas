unit vanda;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Menus, ActnList, System.Actions, Vcl.ExtDlgs;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    BitBtnVand: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtnPermut: TBitBtn;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    BitBtnRensa: TBitBtn;
    BitBtn5: TBitBtn;
    MainMenu1: TMainMenu;
    Arkiv1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    ActionList1: TActionList;
    Action1: TAction;
    BitBtnFlytta: TBitBtn;
    Kommandon1: TMenuItem;
    Hjalp1: TMenuItem;
    HjalpHjalp2: TMenuItem;
    N3: TMenuItem;
    Om1: TMenuItem;
    Spara1: TMenuItem;
    BitBtn7: TBitBtn;
    Label3: TLabel;
    SaveTextFileDialog: TSaveTextFileDialog;
    Oppna1: TMenuItem;
    Vnd1: TMenuItem;
    Permut1: TMenuItem;
    FlyttaX1: TMenuItem;
    Rensa1: TMenuItem;
    procedure Permute(x, y: string);
    procedure BitBtnVandClick(Sender: TObject);
    procedure BitBtnPermutClick(Sender: TObject);
    procedure BitBtnRensaClick(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure BitBtnFlyttaClick(Sender: TObject);
    procedure Om1Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Oppna1Click(Sender: TObject);
    procedure Permut1Click(Sender: TObject);
    procedure Spara1Click(Sender: TObject);
    procedure Vnd1Click(Sender: TObject);
    procedure FlyttaX1Click(Sender: TObject);
    procedure Rensa1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses about, fileEdit;

{$R *.DFM}

procedure TForm1.Permut1Click(Sender: TObject);
begin
  BitBtnPermutClick(Permut1);
end;

procedure TForm1.Permute(x, y: string);
var
  i, j, k: integer;
  res: string;

  { Algoritm för att hitta alla kombinationer av ett antal bokstäver. (Max 7 st). }
begin
  j := Length(y);
  if j < 2 then
  begin
    Memo1.Lines.Add(x + y);
  end
  else
    { Vänder på bokstäverna. }
    for i := 1 to j do
    begin
      for k := Length(y) downto 1 do
      begin
        res := res + y[k];
      end;
      { Rekursivt anrop. }
      Permute(x + copy(y, i, 1), (copy(y, 1, i - 1) + copy(res, 1, j - i)));
    end;
end;

procedure TForm1.Rensa1Click(Sender: TObject);
begin
  BitBtnRensaClick(Rensa1);
end;

procedure TForm1.Spara1Click(Sender: TObject);
begin
  BitBtn5Click(Spara1);
end;

procedure TForm1.Vnd1Click(Sender: TObject);
begin
  BitBtnVandClick(Vnd1);
end;

procedure TForm1.BitBtnVandClick(Sender: TObject);
var
  instring, res: string;
  i: integer;
begin
  { Rensar memoPaden. }
  Memo1.Lines.Clear;

  { Vänder på en sträng. }
  res := '';
  instring := Edit1.Text;
  for i := Length(instring) downto 1 do
  begin
    res := res + instring[i];
  end;
  Memo1.Lines.Add(res);
end;

procedure TForm1.BitBtnPermutClick(Sender: TObject);
var
  instring: string;

begin
  // Kontroll av hur många tecken det är i textboxen.
  if Length(Edit1.Text) > 7 then
  begin
    ShowMessage('Går inte med fler än 7 tecken! Korrigera det.');
    Edit1.SetFocus;
  end
  else
  begin
    { Läser av ordet som ska kombineras. }
    instring := Edit1.Text;
    { Rensar memoPaden. }
    Memo1.Lines.Clear;
    { Anropar annan procedur. }
    Permute('', instring);
  end;
end;

procedure TForm1.BitBtnRensaClick(Sender: TObject);
begin
  { Tömmer Edit rutan, MemoPaden och sätter focus till Edit rutan. }
  Edit1.Text := '';
  Memo1.Lines.Clear;
  Edit1.SetFocus;

end;

procedure TForm1.BitBtn5Click(Sender: TObject);
var
  word: string;
  // mapp: string;

begin
  { Hämtar ordet. }
  word := Edit1.Text;
  // Create the save dialog object - assign to our save dialog variable
  SaveTextFileDialog := TSaveTextFileDialog.Create(self);

  // Set up the starting directory to be the current one
  // SaveTextFileDialog.InitialDir := GetCurrentDir;
  // SaveTextFileDialog.InitialDir := '.';

  ForceCurrentDirectory := False;

  // Filter
  SaveTextFileDialog.Filter := 'Text files (*.txt)|*.txt|Any file (*.*)|*.*';

  // Default extension
  SaveTextFileDialog.DefaultExt := 'txt';

  // Select text files as the starting filter type
  saveTextFileDialog.FilterIndex := 1;

  // Förslag på filnamn
  SaveTextFileDialog.FileName := word;

  // Display the open text file dialog.
  if SaveTextFileDialog.Execute then
  // First check if the file exists.
    if FileExists(SaveTextFileDialog.FileName) then
      // If it exists, raise an exception.
      raise Exception.Create('Fil finns redan. Går inte att skriva över.')
    else
    begin
      { Otherwise, save the memo box lines into the file. }
      Memo1.Lines.SaveToFile(SaveTextFileDialog.FileName);
      // Free up the dialog
      SaveTextFileDialog.Free;
    end;

  //  { Skriver till fil. }
  //  Memo1.Lines.SaveToFile('Permutation of ' + word + ' .txt');
  //  GetDir(0, mapp); { 0 = Current drive }
  //  MessageDlg('Fil är skapad, med sökväg och namn: ' + mapp + '\Permutation of '
  //    + word + ' .txt', mtInformation, [mbOk], 0);
    { ShowMessage('Fil är skapad, med sökväg och namn: ' + mapp +'\Permutation of ' + word + ' .txt'); }
end;

procedure TForm1.Edit1Change(Sender: TObject);
var
  chars: integer;
  Text: string;

begin
  chars := Edit1.GetTextLen;
  str(chars, Text);
  Label3.Caption := Text + ' tecken';

end;


procedure TForm1.FlyttaX1Click(Sender: TObject);
begin
  BitBtnFlyttaClick(FlyttaX1);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Label3.Caption := '';
end;

procedure TForm1.Action1Execute(Sender: TObject);
begin
  Close;
end;

procedure TForm1.BitBtnFlyttaClick(Sender: TObject);
var
  SAntalTecken: string;
  ClickedOK: Boolean;
  IAntalTecken: integer;
  instring, del, rest, result: string;

begin
  { Rensar memoPaden. }
  { Memo1.Lines.Clear; }

  SAntalTecken := '0';
  { Frågar efter antalet tecken att flytta. }
  ClickedOK := InputQuery('DAGSSLÄNDAN', 'Antal tecken att flytta till slutet:',
    SAntalTecken);
  if ClickedOK then
  begin
    IAntalTecken := StrToInt(SAntalTecken);
    { Tar ett antal tecken i början från ordet och flyttar det till slutet. }
    result := '';
    instring := Edit1.Text;
    del := copy(instring, 1, IAntalTecken);
    rest := copy(instring, IAntalTecken + 1, (Length(instring) - IAntalTecken));
    result := Concat(rest, del);
    { Lägger till ordet i listan. }
    Memo1.Lines.Add(result);
  end;

end;

procedure TForm1.BitBtn7Click(Sender: TObject);
begin
  FormFileEdit.Show;
end;

procedure TForm1.Om1Click(Sender: TObject);
begin
  { Visa Om rutan }
  AboutForm.ShowModal;
end;

procedure TForm1.Oppna1Click(Sender: TObject);
begin
  FormFileEdit.Show;
end;

end.
