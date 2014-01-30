unit FormatHelper;


function FormatMiB(const size : Integer) : String;
begin
   Result:=Format('%.1f MiB', [size/(1024*1024)]);
end;

function PluralizeUnit(const count : integer; const suffix: string; plural : string = 's') : string
begin
   Result := Format('%d %s%s', [count, suffix, if count <> 1 then plural else '']);
end;
