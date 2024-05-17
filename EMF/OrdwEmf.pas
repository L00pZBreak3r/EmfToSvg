unit OrdwEmf;

interface

{$ALIGN ON}

uses
  Windows, SysUtils, Classes, Types;

{$REGION 'Emf Enumerations'}
type
  {$MINENUMSIZE 4}
  TEmfRecordType = (
    emrHeader                  = $00000001,
    emrPolyBezier              = $00000002,
    emrPolygon                 = $00000003,
    emrPolyLine                = $00000004,
    emrPolyBezierTo            = $00000005,
    emrPolyLineTo              = $00000006,
    emrPolyPolyLine            = $00000007,
    emrPolyPolygon             = $00000008,
    emrSetWindowExtEx          = $00000009,
    emrSetWindowOrgEx          = $0000000A,
    emrSetViewportExtEx        = $0000000B,
    emrSetViewportOrgEx        = $0000000C,
    emrSetBrushOrgEx           = $0000000D,
    emrEof                     = $0000000E,
    emrSetPixelV               = $0000000F,
    emrSetMapperFlags          = $00000010,
    emrSetMapMode              = $00000011,
    emrSetBkMode               = $00000012,
    emrSetPolyFillMode         = $00000013,
    emrSetRop2                 = $00000014,
    emrSetStretchBltMode       = $00000015,
    emrSetTextAlign            = $00000016,
    emrSetColorAdjustment      = $00000017,
    emrSetTextColor            = $00000018,
    emrSetBkColor              = $00000019,
    emrOffsetClipRgn           = $0000001A,
    emrMoveToEx                = $0000001B,
    emrSetMetaRgn              = $0000001C,
    emrExcludeClipRect         = $0000001D,
    emrIntersectClipRect       = $0000001E,
    emrScaleViewportExtEx      = $0000001F,
    emrScaleWindowExtEx        = $00000020,
    emrSaveDC                  = $00000021,
    emrRestoreDC               = $00000022,
    emrSetWorldTransform       = $00000023,
    emrModifyWorldTransform    = $00000024,
    emrSelectObject            = $00000025,
    emrCreatePen               = $00000026,
    emrCreateBrushIndirect     = $00000027,
    emrDeleteObject            = $00000028,
    emrAngleArc                = $00000029,
    emrEllipse                 = $0000002A,
    emrRectangle               = $0000002B,
    emrRoundRect               = $0000002C,
    emrArc                     = $0000002D,
    emrChord                   = $0000002E,
    emrPie                     = $0000002F,
    emrSelectPalette           = $00000030,
    emrCreatePalette           = $00000031,
    emrSetPaletteEntries       = $00000032,
    emrResizePalette           = $00000033,
    emrRealizePalette          = $00000034,
    emrExtFloodFill            = $00000035,
    emrLineTo                  = $00000036,
    emrArcTo                   = $00000037,
    emrPolyDraw                = $00000038,
    emrSetArcDirection         = $00000039,
    emrSetMiterLimit           = $0000003A,
    emrBeginPath               = $0000003B,
    emrEndPath                 = $0000003C,
    emrCloseFigure             = $0000003D,
    emrFillPath                = $0000003E,
    emrStrokeAndFillPath       = $0000003F,
    emrStrokePath              = $00000040,
    emrFlattenPath             = $00000041,
    emrWidenPath               = $00000042,
    emrSelectClipPath          = $00000043,
    emrAbortPath               = $00000044,
    emrComment                 = $00000046,
    emrFillRgn                 = $00000047,
    emrFrameRgn                = $00000048,
    emrInvertRgn               = $00000049,
    emrPaintRgn                = $0000004A,
    emrExtSelectClipRgn        = $0000004B,
    emrBitBlt                  = $0000004C,
    emrStretchBlt              = $0000004D,
    emrMaskBlt                 = $0000004E,
    emrPlgBlt                  = $0000004F,
    emrSetDiBitsToDevice       = $00000050,
    emrStretchDiBits           = $00000051,
    emrExtCreateFontIndirectW  = $00000052,
    emrExtTextOutA             = $00000053,
    emrExtTextOutW             = $00000054,
    emrPolyBezier16            = $00000055,
    emrPolygon16               = $00000056,
    emrPolyLine16              = $00000057,
    emrPolyBezierTo16          = $00000058,
    emrPolyLineTo16            = $00000059,
    emrPolyPolyLine16          = $0000005A,
    emrPolyPolygon16           = $0000005B,
    emrPolyDraw16              = $0000005C,
    emrCreateMonoBrush         = $0000005D,
    emrCreateDibPatternBrushPt = $0000005E,
    emrExtCreatePen            = $0000005F,
    emrPolyTextOutA            = $00000060,
    emrPolyTextOutW            = $00000061,
    emrSetIcmMode              = $00000062,
    emrCreateColorSpace        = $00000063,
    emrSetColorSpace           = $00000064,
    emrDeleteColorSpace        = $00000065,
    emrGlsRecord               = $00000066,
    emrGlsBoundedRecord        = $00000067,
    emrPixelFormat             = $00000068,
    emrDrawEscape              = $00000069,
    emrExtEscape               = $0000006A,
    emrSmallTextOut            = $0000006C,
    emrForceUfiMapping         = $0000006D,
    emrNamedEscape             = $0000006E,
    emrColorCorrectPalette     = $0000006F,
    emrSetIcmProfileA          = $00000070,
    emrSetIcmProfileW          = $00000071,
    emrAlphaBlend              = $00000072,
    emrSetLayout               = $00000073,
    emrTransparentBlt          = $00000074,
    emrGradientFill            = $00000076,
    emrSetLinkedUfis           = $00000077,
    emrSetTextJustification    = $00000078,
    emrColorMatchToTargetW     = $00000079,
    emrCreateColorSpaceW       = $0000007A
  );

  {$MINENUMSIZE 4}
  TEmfArcDirection = (
    emadCounterClockwise = $00000001,
    emadClockwise        = $00000002
  );

  {$MINENUMSIZE 1}
  TEmfArmStyle = (
    emasAny                 = $00,
    emasNoFit               = $01,
    emasStraightHorz        = $02,
    emasStraightWedge       = $03,
    emasStraightVert        = $04,
    emasStraightSingleSerif = $05,
    emasStraightDoubleSerif = $06,
    emasBentHorz            = $07,
    emasBentWedge           = $08,
    emasBentVert            = $09,
    emasBentSingleSerif     = $0A,
    emasBentDoubleSerif     = $0B
  );

  {$MINENUMSIZE 4}
  TEmfBackgroundMode = (
    embmTransparent = $00000001,
    embmOpaque      = $00000002
  );

  {$MINENUMSIZE 2}
  TEmfColorAdjustment = (
    emcaNegative  = $0001,
    emcaLogFilter = $0002
  );

  {$MINENUMSIZE 4}
  TEmfColorMatchToTarget = (
    emcmtNotEmbedded = $00000000,
    emcmtEmbedded    = $00000001
  );

  {$MINENUMSIZE 4}
  TEmfColorSpace = (
    emcsEnable          = $00000001,
    emcsDisable         = $00000002,
    emcsDeleteTransform = $00000003
  );

  {$MINENUMSIZE 1}
  TEmfContrast = (
    emcAny        = $00,
    emcNoFit      = $01,
    emcNone       = $02,
    emcVeryLow    = $03,
    emcLow        = $04,
    emcMediumLow  = $05,
    emcMedium     = $06,
    emcMediumHigh = $07,
    emcHigh       = $08,
    emcVeryHigh   = $09
  );

  {$MINENUMSIZE 1}
  TEmfDibColors = (
    dibRgbColors  = $00,
    dibPalColors  = $01,
    dibPalIndices = $02
  );

  {$MINENUMSIZE 4}
  TEmfEmrComment = (
    emrcWindowsMetafile = Integer($80000001),
    emrcBeginGroup      = $00000002,
    emrcEndGroup        = $00000003,
    emrcMultiFormats    = $40000004,
    emrcUnicodeString   = $00000040,
    emrcUnicodeEnd      = $00000080
  );

  {$MINENUMSIZE 4}
  TEmfExtTextOutOptions = (
    etoOpaque          = $00000002,
    etoClipped         = $00000004,
    etoGlyphIndex      = $00000010,
    etoRtlReading      = $00000080,
    etoNoRect          = $00000100,
    etoSmallChars      = $00000200,
    etoNumericsLocal   = $00000400,
    etoNumericsLatin   = $00000800,
    etoIgnoreLanguage  = $00001000,
    etoPdy             = $00002000,
    etoReverseIndexMap = $00010000
  );

  {$MINENUMSIZE 1}
  TEmfFamilyType = (
    emftAny         = $00,
    emftNoFit       = $01,
    emftTextDisplay = $02,
    emftScript      = $03,
    emftDecorative  = $04,
    emftPictorial   = $05
  );

  {$MINENUMSIZE 4}
  TEmfFloodFill = (
    emffBorder  = $00000000,
    emffSurface = $00000001
  );

  {$MINENUMSIZE 4}
  TEmfFormatSignature = (
    emfsEnhMeta = $464D4520,
    emfsEps     = $46535045
  );

  {$MINENUMSIZE 4}
  TEmfGradientFill = (
    emgRectH    = $00000000,
    emgRectV    = $00000001,
    emgTriangle = $00000002
  );

  {$MINENUMSIZE 4}
  TEmfGraphicsMode = (
    gmCompatible = $00000001,
    gmAdvanced   = $00000002
  );

  {$MINENUMSIZE 2}
  TEmfHatchStyle = (
    hsSolidClr        = $0006,
    hsDitheredClr     = $0007,
    hsSolidTextClr    = $0008,
    hsDitheredTextClr = $0009,
    hsSolidBkClr      = $000A,
    hsDitheredBkClr   = $000B
  );

  {$MINENUMSIZE 1}
  TEmfIcmMode = (
    icmOff           = $01,
    icmOn            = $02,
    icmQuery         = $03,
    icmDoneOutsideDC = $04
  );

  {$MINENUMSIZE 2}
  TEmfIlluminant = (
    emiDeviceDefault = $0000,
    emiTungsten      = $0001,
    emiB             = $0002,
    emiDaylight      = $0003,
    emiD50           = $0004,
    emiD55           = $0005,
    emiD65           = $0006,
    emiD75           = $0007,
    emiFluorescent   = $0008
  );

  {$MINENUMSIZE 1}
  TEmfLetterform = (
    emlAny              = $00,
    emlNoFit            = $01,
    emlNormalContact    = $02,
    emlNormalWeighted   = $03,
    emlNormalBoxed      = $04,
    emlNormalFlattened  = $05,
    emlNormalRounded    = $06,
    emlNormalOffCenter  = $07,
    emlNormalSquare     = $08,
    emlObliqueContact   = $09,
    emlObliqueWeighted  = $0A,
    emlObliqueBoxed     = $0B,
    emlObliqueFlattened = $0C,
    emlObliqueRounded   = $0D,
    emlObliqueOffCenter = $0E,
    emlObliqueSquare    = $0F
  );

  {$MINENUMSIZE 4}
  TEmfMapMode = (
    mmText        = $00000001,
    mmLoMetric    = $00000002,
    mmHiMetric    = $00000003,
    mmLoEnglish   = $00000004,
    mmHiEnglish   = $00000005,
    mmTwips       = $00000006,
    mmIsotropic   = $00000007,
    mmAnisotropic = $00000008
  );

  {$MINENUMSIZE 4}
  TEmfMetafileVersion = (
    emvEnhanced = $00010000
  );

  {$MINENUMSIZE 1}
  TEmfMidLine = (
    emmlAny             = $00,
    emmlNoFit           = $01,
    emmlStandardTrimmed = $02,
    emmlStandardPointed = $03,
    emmlStandardSerifed = $04,
    emmlHighTrimmed     = $05,
    emmlHighPointed     = $06,
    emmlHighSerifed     = $07,
    emmlConstantTrimmed = $08,
    emmlConstantPointed = $09,
    emmlConstantSerifed = $0A,
    emmlLowTrimmed      = $0B,
    emmlLowPointed      = $0C,
    emmlLowSerifed      = $0D
  );

  {$MINENUMSIZE 1}
  TEmfModifyWorldTransformMode = (
    mwtIdentity      = $01,
    mwtLeftMultiply  = $02,
    mwtRightMultiply = $03,
    mwtSet           = $04
  );

  {$MINENUMSIZE 4}
  TEmfPenStyle = (
    psCosmetic     = $00000000,
    psEndcapRound  = $00000000,
    psJoinRound    = $00000000,
    psSolid        = $00000000,
    psDash         = $00000001,
    psDot          = $00000002,
    psDashDot      = $00000003,
    psDashDotDot   = $00000004,
    psNull         = $00000005,
    psInsideFrame  = $00000006,
    psUserStyle    = $00000007,
    psAlternate    = $00000008,
    psEndcapSquare = $00000100,
    psEndcapFlat   = $00000200,
    psJoinBevel    = $00001000,
    psJoinMiter    = $00002000,
    psGeometric    = $00010000
  );

  {$MINENUMSIZE 1}
  TEmfPoint = (
    ptCloseFigure = $01,
    ptLineTo      = $02,
    ptBezierTo    = $04,
    ptMoveTo      = $06
  );

  {$MINENUMSIZE 1}
  TEmfPolygonFillMode = (
    empfAlternate = $01,
    empfWinding   = $02
  );

  {$MINENUMSIZE 1}
  TEmfProportion = (
    empAny           = $00,
    empNoFit         = $01,
    empOldStyle      = $02,
    empModern        = $03,
    empEvenWidth     = $04,
    empExpanded      = $05,
    empCondensed     = $06,
    empVeryExpanded  = $07,
    empVeryCondensed = $08,
    empMonospaced    = $09
  );

  {$MINENUMSIZE 1}
  TEmpRegionMode = (
    rgnAnd  = $01,
    rgnOr   = $02,
    rgnXor  = $03,
    rgnDiff = $04,
    rgnCopy = $05
  );

  {$MINENUMSIZE 1}
  TEmfSerifType = (
    emstAny              = $00,
    emstNoFit            = $01,
    emstCove             = $02,
    emstObtuseCove       = $03,
    emstSquareCove       = $04,
    emstObtuseSquareCove = $05,
    emstSquare           = $06,
    emstThin             = $07,
    emstBone             = $08,
    emstExaggerated      = $09,
    emstTriangle         = $0A,
    emstNormalSans       = $0B,
    emstObtuseSans       = $0C,
    emstPerpSans         = $0D,
    emstFlared           = $0E,
    emstRounded          = $0F
  );

  {$MINENUMSIZE 4}
  TEmfStockObject = (
    emsoWhiteBrush        = Integer($80000000),
    emsoltGrayBrush       = Integer($80000001),
    emsoGrayBrush         = Integer($80000002),
    emsoDkGrayBrush       = Integer($80000003),
    emsoBlackBrush        = Integer($80000004),
    emsoNullBrush         = Integer($80000005),
    emsoWhitePen          = Integer($80000006),
    emsoBlackPen          = Integer($80000007),
    emsoNullPen           = Integer($80000008),
    emsoOemFixedFont      = Integer($8000000A),
    emsoAnsiFixedFont     = Integer($8000000B),
    emsoAnsiVarFont       = Integer($8000000C),
    emsoSystemFont        = Integer($8000000D),
    emsoDeviceDefaultFont = Integer($8000000E),
    emsoDefaultPalette    = Integer($8000000F),
    emsoSystemFizedFont   = Integer($80000010),
    emsoDefaultGuiFont    = Integer($80000011),
    emsoDcBrush           = Integer($80000012),
    emsoDcPen             = Integer($80000013)
  );

  {$MINENUMSIZE 1}
  TEmfStretchMode = (
    emsmAndScans    = $01,
    emsmOrScans     = $02,
    emsmDeleteScans = $03,
    emsmHalfTone    = $04
  );

  {$MINENUMSIZE 1}
  TEmfStrokeVariation = (
    emsvAny         = $00,
    emsvNoFit       = $01,
    emsvGradualDiag = $02,
    emsvGradualTran = $03,
    emsvGradualVert = $04,
    emsvGradualHorz = $05,
    emsvRapidVert   = $06,
    emsvRapidHorz   = $07,
    emsvInstantVert = $08
  );

  {$MINENUMSIZE 1}
  TEmfWeight = (
    emwAny       = $00,
    emwNoFit     = $01,
    emwVeryLight = $02,
    emwLight     = $03,
    emwThin      = $04,
    emwBook      = $05,
    emwMedium    = $06,
    emwDemi      = $07,
    emwBold      = $08,
    emwHeavy     = $09,
    emwBlack     = $0A,
    emwNord      = $0B
  );

  {$MINENUMSIZE 1}
  TEmfXHeight = (
    emxhAny           = $00,
    emxhNoFit         = $01,
    emxhConstantSmall = $02,
    emxhConstantStd   = $03,
    emxhConstantLarge = $04,
    emxhDuckingSmall  = $05,
    emxhDuckingStd    = $06,
    emxhDuckingLarge  = $07
  );
{$ENDREGION}

type
  PEmfColorAdjustmentObj = ^TEmfColorAdjustmentObj;
  TEmfColorAdjustmentObj = record
    Size: Word;
    Values: TEmfColorAdjustment;
    IlluminantIndex: TEmfIlluminant;
    RedGamma: Word;
    GreenGamma: Word;
    BlueGamma: Word;
    ReferenceBlack: Word;
    ReferenceWhite: Word;
    Contrast: SmallInt;
    Brightness: SmallInt;
    Colorfulness: SmallInt;
    RedGreenTint: SmallInt;
  end;

  PEmfDesignVectorObj = ^TEmfDesignVectorObj;
  TEmfDesignVectorObj = record
    Signature: UInt32;
    NumAxes: UInt32;
    Values: array [0 .. 0] of Int32;
  end;

  PEmfEmrFormatObj = ^TEmfEmrFormatObj;
  TEmfEmrFormatObj = record
    Signature: UInt32;
    Version: UInt32;
    SizeData: UInt32;
    offData: UInt32;
  end;

  PEmfEmrTextObj = ^TEmfEmrTextObj;
  TEmfEmrTextObj = record
    Reference: TPoint;
    Chars: UInt32;
    offString: UInt32;
    Options: TEmfExtTextOutOptions;
    Rectangle: TRect;
    offDx: UInt32;
  end;

  PEmfGradientRectangleObj = ^TEmfGradientRectangleObj;
  TEmfGradientRectangleObj = record
    UpperLeft: Cardinal;
    LowerRight: Cardinal;
  end;

  PEmfGradientTriangleObj = ^TEmfGradientTriangleObj;
  TEmfGradientTriangleObj = record
    Vertex1: Cardinal;
    Vertex2: Cardinal;
    Vertex3: Cardinal;
  end;

  IOrdwEmfRecordLoader = interface
  ['{95C72887-49C4-4013-9425-DBA1F65D81D1}']
    function LoadNext(): PEMR;
    procedure Reset();
  end;

  TOrdwEmfRecordLoaderStream = class(TInterfacedObject, IOrdwEmfRecordLoader)
  private
    FSource: TMemoryStream;
    FStartPos: Int64;
  protected
    { IOrdwEmfRecordLoader }
    function LoadNext(): PEMR;
    procedure Reset();
  public
    constructor Create(Source: TStream; Owns: Boolean);
    destructor Destroy(); override;
  end;

  TOrdwEmfPlayer = class
  private
    FStockObjects: TList;
    FObjects: TList;
    FSelectedObject: PEMR;
    FBkColor: TColorRef;
    FBkMode: TEmfBackgroundMode;
    FMapMode: TEmfMapMode;
    FTextAlign: Cardinal;
    FViewportExt: TSize;
    FWindowExt: TSize;
    FWindowOrg: TPoint;
    procedure PlayRecord(Rec: PEMR);
  protected
    procedure DoPlay(Rec: PEMR); virtual;
    property BkColor: TColorRef read FBkColor;
    property BkMode: TEmfBackgroundMode read FBkMode;
    property MapMode: TEmfMapMode read FMapMode;
    property TextAlign: Cardinal read FTextAlign;
    property ViewportExt: TSize read FViewportExt;
    property WindowExt: TSize read FWindowExt;
    property WindowOrg: TPoint read FWindowOrg;
    property SelectedObject: PEMR read FSelectedObject;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure Play(Loader: IOrdwEmfRecordLoader);
  end;

implementation

{ TOrdwEmfRecordLoaderStream }

constructor TOrdwEmfRecordLoaderStream.Create(Source: TStream; Owns: Boolean);
begin
  if Assigned(Source) then
  begin
    FStartPos := Source.Position;
    if (Source is TMemoryStream) and Owns then
      FSource := TMemoryStream(Source)
    else
    begin
      FSource := TMemoryStream.Create();
      FSource.CopyFrom(Source, 0);
      if Owns then
        Source.Free();
      FSource.Position := FStartPos;
    end;
  end
  else
  begin
    FSource := TMemoryStream.Create();
    FStartPos := 0;
  end;
end;

destructor TOrdwEmfRecordLoaderStream.Destroy();
begin
  FreeAndNil(FSource);
  inherited Destroy();
end;

function TOrdwEmfRecordLoaderStream.LoadNext(): PEMR;
var
  pRecord: PEnhMetaRecord;
begin
  pRecord := PEnhMetaRecord(PByte(FSource.Memory) + FSource.Position);
  if (FSource.Read(pRecord^, SizeOf(TEMR)) = SizeOf(TEMR))
    and (pRecord.nSize >= SizeOf(TEMR))
    and (FSource.Read(pRecord.dParm[0], pRecord.nSize - SizeOf(TEMR))
      = Integer(pRecord.nSize - SizeOf(TEMR))) then
    Result := PEMR(pRecord)
  else
    Result := nil;
end;

procedure TOrdwEmfRecordLoaderStream.Reset();
begin
  FSource.Position := FStartPos;
end;

{ TOrdwEmfPlayer }

constructor TOrdwEmfPlayer.Create();
begin
  FStockObjects := TList.Create();
  FObjects := TList.Create();
end;

destructor TOrdwEmfPlayer.Destroy();
begin
  FreeAndNil(FObjects);
  FreeAndNil(FStockObjects);
  inherited Destroy();
end;

procedure TOrdwEmfPlayer.DoPlay(Rec: PEMR);
begin
end;

procedure TOrdwEmfPlayer.Play(Loader: IOrdwEmfRecordLoader);
var
  Rec: PEMR;
  i: Integer;
begin
  FObjects.Clear();
  FSelectedObject := nil;
  if Assigned(Loader) then
  begin
    Loader.Reset();
    Rec := Loader.LoadNext();
    if Assigned(Rec) and (Rec.iType = Cardinal(emrHeader)) then
    begin
      FObjects.Count := PEnhMetaHeader(Rec).nHandles;
      i := PEnhMetaHeader(Rec).nRecords - 1;
      while (i >= 0) and Assigned(Rec) do
      begin
        PlayRecord(Rec);
        Rec := Loader.LoadNext();
        Dec(i);
      end;
    end;
  end;
end;

procedure TOrdwEmfPlayer.PlayRecord(Rec: PEMR);
var
  Index: Integer;
begin
  case TEmfRecordType(Rec.iType) of
    emrCreateBrushIndirect:
    begin
      Index := PEMRCreateBrushIndirect(Rec).ihBrush;
      if (Index > 0) and (Index < FObjects.Count) then
        FObjects[Index] := Rec;
    end;
    emrCreatePen:
    begin
      Index := PEMRCreatePen(Rec).ihPen;
      if (Index > 0) and (Index < FObjects.Count) then
        FObjects[Index] := Rec;
    end;
    emrSelectObject:
    begin
      Index := PEMRSelectObject(Rec).ihObject;
      if (Index and $80000000) <> 0 then
      begin
        Index := Index and $7FFFFFFF;
        if (Index >= 0) and (Index < FStockObjects.Count) then
          FSelectedObject := FStockObjects[Index]
        else
          FSelectedObject := nil;
      end
      else if (Index > 0) and (Index < FObjects.Count) then
        FSelectedObject := FObjects[Index]
      else
        FSelectedObject := nil;
    end;
    emrSetBkColor:
      FBkColor := PEMRSetBkColor(Rec).crColor;
    emrSetBkMode:
      Cardinal(FBkMode) := PEMRSetBkMode(Rec).iMode;
    emrSetMapMode:
      Cardinal(FMapMode) := PEMRSetMapMode(Rec).iMode;
    emrSetTextAlign:
      FTextAlign := PEMRSetTextAlign(Rec).iMode;
    emrSetViewportExtEx:
      FViewportExt := PEMRSetViewportExtEx(Rec).szlExtent;
    emrSetWindowExtEx:
      FWindowExt := PEMRSetWindowExtEx(Rec).szlExtent;
    emrSetWindowOrgEx:
      FWindowOrg := PEMRSetWindowOrgEx(Rec).ptlOrigin;
  end;
  DoPlay(Rec);
end;

end.

