unit vanda;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Menus, ActnList, System.Actions;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    MainMenu1: TMainMenu;
    Arkiv1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    ActionList1: TActionList;
    Action1: TAction;
    BitBtn6: TBitBtn;
    Kommandon1: TMenuItem;
    Hjlp1: TMenuItem;
    Hjlp2: TMenuItem;
    N3: TMenuItem;
    Om1: TMenuItem;
    Spara1: TMenuItem;
    Rensa1: TMenuItem;
    BitBtn7: TBitBtn;
    Label3: TLabel;
    procedure Permute(x, y: string);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    // procedure Edit1Exit(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure Om1Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses about, spellingCorrector;

{$R *.DFM}

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

procedure TForm1.BitBtn1Click(Sender: TObject);
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

procedure TForm1.BitBtn3Click(Sender: TObject);
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

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
  { Tömmer Edit rutan, MemoPaden och sätter focus till Edit rutan. }
  Edit1.Text := '';
  Memo1.Lines.Clear;
  Edit1.SetFocus;

end;

procedure TForm1.BitBtn5Click(Sender: TObject);
var
  word: string;
  mapp: string;

begin
  { Hämtar ordet. }
  word := Edit1.Text;
  { Skriver till fil. }
  Memo1.Lines.SaveToFile('Permutation of ' + word + ' .txt');
  GetDir(0, mapp); { 0 = Current drive }
  MessageDlg('Fil är skapad, med sökväg och namn: ' + mapp + '\Permutation of '
    + word + ' .txt', mtInformation, [mbOk], 0);
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

// procedure TForm1.Edit1Exit(Sender: TObject);
// begin
// if Length(Edit1.Text) > 7 then
// BitBtn3.Enabled := False;
// ShowMessage('Går inte med fler än 7 tecken!');
// end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Label3.Caption := '';
end;

procedure TForm1.Action1Execute(Sender: TObject);
begin
  Close;
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
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
  Form2.Show;
end;

procedure TForm1.Om1Click(Sender: TObject);
begin
  { Visa Om rutan }
  AboutForm.ShowModal;
end;

end.
