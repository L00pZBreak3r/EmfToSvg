object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 539
  ClientWidth = 900
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 8
    Top = 39
    Width = 865
    Height = 250
  end
  object Label1: TLabel
    Left = 268
    Top = 8
    Width = 30
    Height = 13
    Caption = 'Input:'
  end
  object Label2: TLabel
    Left = 504
    Top = 8
    Width = 38
    Height = 13
    Caption = 'Output:'
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Play EMF'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 295
    Width = 884
    Height = 234
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
    WordWrap = False
  end
  object Button2: TButton
    Left = 89
    Top = 8
    Width = 75
    Height = 25
    Caption = 'EMF to SVG'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 304
    Top = 8
    Width = 177
    Height = 21
    TabOrder = 3
    Text = 'formula.emf'
  end
  object Edit2: TEdit
    Left = 548
    Top = 8
    Width = 253
    Height = 21
    TabOrder = 4
    Text = 'formula.svg'
  end
  object Button3: TButton
    Left = 807
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 5
    OnClick = Button3Click
  end
  object CheckBox1: TCheckBox
    Left = 170
    Top = 8
    Width = 79
    Height = 17
    Caption = 'with header'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
end
