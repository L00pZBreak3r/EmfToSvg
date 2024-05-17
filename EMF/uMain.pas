unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  OrdwEmf, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Image1: TImage;
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Button3: TButton;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  end;

  TMemoPlayer = class(TOrdwEmfPlayer)
  private
    FMemo: TCustomMemo;
  protected
    procedure DoPlay(Rec: PEMR); override;
  public
    constructor Create(Memo: TCustomMemo);
  end;

  TImagePlayer = class(TOrdwEmfPlayer)
  private
    FBitmap: TBitmap;
    FGdiObj: TList;
  protected
    procedure DoPlay(Rec: PEMR); override;
  public
    constructor Create(Bitmap: TBitmap);
    destructor Destroy(); override;
  end;

var
  Form1: TForm1;

implementation

uses
  EmfToSvgUnit;

{$R *.dfm}

{ TMemoPlayer }

constructor TMemoPlayer.Create(Memo: TCustomMemo);
begin
  inherited Create();
  FMemo := Memo;
end;

procedure TMemoPlayer.DoPlay(Rec: PEMR);
begin
  case TEmfRecordType(Rec.iType) of
    emrHeader:
      with PEnhMetaHeader(Rec)^ do
      begin
        FMemo.Lines.Add('emrHeader');
        FMemo.Lines.Add(Format('    Bounds: %d %d %d %d', [rclBounds.Left, rclBounds.Top, rclBounds.Right, rclBounds.Bottom]));
        FMemo.Lines.Add(Format('    Frame: %d %d %d %d', [rclFrame.Left, rclFrame.Top, rclFrame.Right, rclFrame.Bottom]));
        FMemo.Lines.Add(Format('    RecordCount: %d', [nRecords]));
        FMemo.Lines.Add(Format('    ObjectsCount: %d', [nHandles]));
      end;
    emrCreateBrushIndirect:
      with PEMRCreateBrushIndirect(Rec)^ do
      begin
        FMemo.Lines.Add('emrCreateBrushIndirect');
        FMemo.Lines.Add(Format('    Index: %d', [ihBrush]));
        FMemo.Lines.Add(Format('    BrushStyle: %.8x', [lb.lbStyle]));
        FMemo.Lines.Add(Format('    Color: %.8x', [lb.lbColor]));
        FMemo.Lines.Add(Format('    BrushHatch: %.8x', [lb.lbHatch]));
      end;
    emrCreatePen:
      with PEMRCreatePen(Rec)^ do
      begin
        FMemo.Lines.Add('emrCreatePen');
        FMemo.Lines.Add(Format('    Index: %d', [ihPen]));
        FMemo.Lines.Add(Format('    PenStyle: %.8x', [lopn.lopnStyle]));
        FMemo.Lines.Add(Format('    Width: %.8x', [lopn.lopnWidth.X]));
        FMemo.Lines.Add(Format('    Color: %.8x', [lopn.lopnColor]));
      end;
    emrSelectObject:
      with PEMRSelectObject(Rec)^ do
      begin
        FMemo.Lines.Add('emrSelectObject');
        FMemo.Lines.Add(Format('    Index: %x', [ihObject]));
      end;
    emrBitBlt:
      FMemo.Lines.Add('emrBitBlt');
    emrComment:
      FMemo.Lines.Add('emrComment');
    emrSetBkColor:
    begin
      FMemo.Lines.Add('emrSetBkColor');
      FMemo.Lines.Add(Format('    Color: %.8x', [BkColor]));
    end;
    emrSetBkMode:
    begin
      FMemo.Lines.Add('emrSetBkMode');
      FMemo.Lines.Add(Format('    BkMode: %d', [Cardinal(BkMode)]));
    end;
    emrSetMapMode:
    begin
      FMemo.Lines.Add('emrSetMapMode');
      FMemo.Lines.Add(Format('    MapMode: %.8x', [Cardinal(MapMode)]));
    end;
    emrSetTextAlign:
    begin
      FMemo.Lines.Add('emrSetTextAlign');
      FMemo.Lines.Add(Format('    TextAlign: %.8x', [TextAlign]));
    end;
    emrSetViewportExtEx:
    begin
      FMemo.Lines.Add('emrSetViewportExtEx');
      FMemo.Lines.Add(Format('    ViewportExt: %d %d', [ViewportExt.cx, ViewportExt.cy]));
    end;
    emrSetWindowExtEx:
    begin
      FMemo.Lines.Add('emrSetWindowExtEx');
      FMemo.Lines.Add(Format('    WindowExt: %d %d', [WindowExt.cx, WindowExt.cy]));
    end;
    emrSetWindowOrgEx:
    begin
      FMemo.Lines.Add('emrSetWindowOrgEx');
      FMemo.Lines.Add(Format('    WindowOrg: %d %d', [WindowOrg.X, WindowOrg.Y]));
    end;
    else
      FMemo.Lines.Add(IntToHex(Rec.iType, 8));
  end;
end;

{ TImagePlayer }

constructor TImagePlayer.Create(Bitmap: TBitmap);
begin
  inherited Create();
  FBitmap := Bitmap;
  FGdiObj := TList.Create();
end;

destructor TImagePlayer.Destroy();
var
  i: Integer;
begin
  if Assigned(FGdiObj) then
  begin
    for i := 0 to FGdiObj.Count - 1 do
      DeleteObject(HGDIOBJ(FGdiObj[i]));
    FreeAndNil(FGdiObj);
  end;
  inherited Destroy();
end;

procedure TImagePlayer.DoPlay(Rec: PEMR);
var
  hObj: HGDIOBJ;
  aLogBrush: TLogBrush;
begin
  case TEmfRecordType(Rec.iType) of
    emrHeader:
      with PEnhMetaHeader(Rec)^ do
      begin
        FBitmap.SetSize(rclBounds.Width + 1, rclBounds.Height + 1);
        FGdiObj.Count := nHandles;
      end;
    emrCreateBrushIndirect:
      with PEMRCreateBrushIndirect(Rec)^ do
      begin
        aLogBrush.lbStyle := lb.lbStyle;
        aLogBrush.lbColor := lb.lbColor;
        aLogBrush.lbHatch := lb.lbHatch;

        hObj := CreateBrushIndirect(aLogBrush);
        if hObj <> 0 then
          FGdiObj[ihBrush] := Pointer(hObj);
      end;
    emrCreatePen:
      with PEMRCreatePen(Rec)^ do
      begin
        hObj := CreatePen(lopn.lopnStyle, lopn.lopnWidth.X, lopn.lopnColor);
        if hObj <> 0 then
          FGdiObj[ihPen] := Pointer(hObj);
      end;
    emrSelectObject:
      with PEMRSelectObject(Rec)^ do
      begin
        if (ihObject and $80000000) <> 0 then
        begin
          hObj := GetStockObject(ihObject and $7FFFFFFF);
          SelectObject(FBitmap.Canvas.Handle, hObj);
        end
        else
          SelectObject(FBitmap.Canvas.Handle, HGDIOBJ(FGdiObj[ihObject]));
      end;
  end;
end;

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  Emf: TStream;
  Loader: IOrdwEmfRecordLoader;
  Player: TOrdwEmfPlayer;
begin
  Memo1.Clear();
  Emf := TFileStream.Create(Edit1.Text, fmOpenRead or fmShareDenyWrite);
  Loader := TOrdwEmfRecordLoaderStream.Create(Emf, True);
  Player := TMemoPlayer.Create(Memo1);
  try
    Player.Play(Loader);
  finally
    FreeAndNil(Player);
  end;
  Player := TImagePlayer.Create(Image1.Picture.Bitmap);
  try
    Player.Play(Loader);
  finally
    FreeAndNil(Player);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  aEmf: TFileStream;
  aOutStr: string;
  aInputBuffer: array of Byte;
begin
  aEmf := TFileStream.Create(Edit1.Text, fmOpenRead or fmShareDenyWrite);
  SetLength(aInputBuffer, aEmf.Size);
  aEmf.Read(aInputBuffer[0], Length(aInputBuffer));
  FreeAndNil(aEmf);
  Memo1.Clear;
  if ConvertEmfToSvg(aInputBuffer, CheckBox1.Checked, 0, 0, aOutStr) then
  begin
    Memo1.Text := aOutStr;
  end
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Memo1.Lines.SaveToFile(Edit2.Text, TEncoding.Unicode);
end;

end.
