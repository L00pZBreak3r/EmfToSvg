unit EmfToSvgUnit;

interface

// aEmfContent: array containing the emf file
// aWithHeader: include the xml header or not
// imgWidth: Integer - desired image width (use 0 for the original width)
// imgHeight: Integer - desired image height (use 0 for the original height)
// aSvgContent: the resulting SVG text
// returns: Boolean (True = success, False = failure)
function ConvertEmfToSvg(aEmfContent: array of Byte; aWithHeader: Boolean; imgWidth, imgHeight: Integer; out aSvgContent: string): Boolean;

implementation

// aEmfContent: pointer to a buffer containing the content of the emf file
// aEmfContentLength: length of aEmfContent (in bytes)
// aOutputBuffer: a PChar string containing the resulting svg text. The string is allocated by emf2svg and must be freed with emf2svg_free.
// aOutputBufferLength: length of the string in aOutputBuffer
// emfplus: Boolean - try to scan the EMF file for the EMF+ properties or not
// svgDelimiter: Boolean - insert the xml header into the output string or not
// imgWidth: Integer - desired image width (use 0 for the original width)
// imgHeight: Integer - desired image height (use 0 for the original height)
// nameSpace: specific namespace if needed
// returns: Boolean (1 = success, 0 = failure)
function emf2svg(var aEmfContent: Byte; aEmfContentLength: UIntPtr; var aOutputBuffer: PChar; var aOutputBufferLength: UIntPtr;
  emfplus, svgDelimiter, imgWidth, imgHeight: Integer; nameSpace: PChar): Integer; stdcall; external 'EmfToSvgLibrary.dll';

// free the string buffer created by emf2svg
procedure emf2svg_free(aBuffer: PChar); stdcall; external 'EmfToSvgLibrary.dll';

function ConvertEmfToSvg(aEmfContent: array of Byte; aWithHeader: Boolean; imgWidth, imgHeight: Integer; out aSvgContent: string): Boolean;
var
  aOutBuffer: PChar;
  aOutLength, aInputLength: UIntPtr;
  aError, aWithHeaderInt: Integer;
begin
  aSvgContent := '';
  Result := False;
  aInputLength := Length(aEmfContent);
  if aInputLength > 0 then
  begin
    aOutLength := 0;
    aWithHeaderInt := 0;
    if aWithHeader then
      aWithHeaderInt := 1;
    aError := emf2svg(aEmfContent[0], aInputLength, aOutBuffer, aOutLength, 1, aWithHeaderInt, imgWidth, imgHeight, nil);
    if aError <> 0 then
    begin
      aSvgContent := aOutBuffer;
      emf2svg_free(aOutBuffer); // free the buffer
      Result := True;
    end;
  end;
end;

end.
