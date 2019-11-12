unit VersionRoutine;

interface

uses
  Windows, SysUtils;

//type
  function FileVersion(const FileName: TFileName): String;

implementation

function FileVersion(const FileName: TFileName): String;
var
  VerInfoSize: Cardinal;
  VerValueSize: Cardinal;
  Dummy: Cardinal;
  PVerInfo: Pointer;
  PVerValue: PVSFixedFileInfo;
  iLastError: DWord;

begin
  Result := '';
  VerInfoSize := GetFileVersionInfoSize(PChar(FileName), Dummy);

  if VerInfoSize > 0 then
  begin
    GetMem(PVerInfo, VerInfoSize);
    try
      if GetFileVersionInfo(PChar(FileName), 0, VerInfoSize, PVerInfo) then
      begin
        if VerQueryValue(PVerInfo, '\', Pointer(PVerValue), VerValueSize) then
          with PVerValue^ do
            Result := Format('Version: %d.%d.%d build %d', [
              HiWord(dwFileVersionMS), //Major
              LoWord(dwFileVersionMS), //Minor
              HiWord(dwFileVersionLS), //Release
              LoWord(dwFileVersionLS)]); //Build
      end
      else
      begin
        iLastError := GetLastError;
        Result := Format('GetFileVersionInfo failed: (%d) %s',
                      [iLastError, SysErrorMessage(iLastError)]);
      end;
    finally
      FreeMem(PVerInfo, VerInfoSize);
    end;
  end
  else
  begin
    iLastError := GetLastError;
    Result := Format('GetFileVersionInfo failed: (%d) %s',
                     [iLastError, SysErrorMessage(iLastError)]);
  end;
end;

end.
