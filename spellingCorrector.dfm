object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 549
  ClientWidth = 511
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 416
    Width = 185
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 8
    Top = 440
    Width = 185
    Height = 13
    Caption = 'Label2'
  end
  object Label3: TLabel
    Left = 8
    Top = 464
    Width = 185
    Height = 13
    Caption = 'Label3'
  end
  object Label4: TLabel
    Left = 8
    Top = 483
    Width = 185
    Height = 13
    Caption = 'Label4'
  end
  object MemoBox: TMemo
    Left = 8
    Top = 8
    Width = 495
    Height = 401
    Lines.Strings = (
      'MemoBox')
    TabOrder = 0
  end
  object LoadButton: TButton
    Left = 56
    Top = 516
    Width = 100
    Height = 25
    Caption = 'Ladda fil'
    TabOrder = 1
    OnClick = LoadButtonClick
  end
  object SaveButton: TButton
    Left = 208
    Top = 516
    Width = 100
    Height = 25
    Caption = 'Spara fil'
    TabOrder = 2
  end
  object CorrectButton: TButton
    Left = 352
    Top = 516
    Width = 100
    Height = 25
    Caption = 'Korrigera'
    TabOrder = 3
  end
end
