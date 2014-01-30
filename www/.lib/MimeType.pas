unit MimeType;

type TMimeType = enum (PNG, JPEG, SVG, UTF8Text, JS, JSON, HTML, XHTML);

function MimeToString(const mime : TMimeType): string;
begin
   case mime of
      TMimeType.PNG: Result := 'image/png';
      TMimeType.JPEG: Result := 'image/jpeg';
      TMimeType.SVG: Result := 'image/svg+xml';
      TMimeType.UTF8Text: Result := 'text/plain; charset=utf-8';
      TMimeType.JS: Result := 'application/javascript; charset=utf-8';
      TMimeType.JSON: Result := 'application/json; charset=utf-8';
      TMimeType.HTML: Result := 'text/html; charset=utf-8';
      TMimeType.XHTML: Result := 'application/xhtml+xml';
      else raise Exception.Create(Format('%s is not a recognized MIME Type', [mime]));
   end;
end;