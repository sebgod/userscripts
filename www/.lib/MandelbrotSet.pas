unit MandelbrotSet;

uses
   MimeType;

procedure MandelbrotParams(const params : JSONVariant; 
   var size : integer; var z : TComplex; var zoom : float);
begin
   size := 512;
   zoom := 3.0;
   z := Complex(-2.2, -1.5); 

   if VarType(params['size']) = varDouble then size := params['size'];
   if VarType(params['zoom']) = varDouble then zoom := params['zoom'];
   if (VarType(params['i']) = varDouble) 
       and (VarType(params['j']) = varDouble) 
   then 
      z := Complex(params['i'], params['j'])
   else if (VarType(params['z']['i']) = varDouble) 
       and (VarType(params['z']['j']) = varDouble)
   then
      z := Complex(params['z']['i'], params['z']['j']);
end;
   
function MandelbrotAsImage(const imageType : TMimeType; const size: Integer; 
      const z : TComplex; const zoom: Float): String;
const
   cColors: array[0..16] of Integer = (
      $000022, $000033, $000044, $000055, $000066, $000077, $000088,
      $101099, $3030AA, $4040BB, $5050CC, $6060DD, $7070EE, $8080FF,
      $9090FF, $A0A0FF,
      $000000
      );
var
   pixmap : TPixmap;
   px, py, interation : Integer;
   x0, y0, x, y, xt, ratio : Float;

begin
   pixmap.SetLength(size*size);
   ratio := zoom / size;
   for px := 0 to size-1 do begin
      for py := 0 to size-1 do begin
         x0 := z.Re + ratio * px;
         y0 := z.Im + ratio * py;
         interation := 0;
         x := 0;
         y := 0;
         repeat
            xt := Sqr(x) - Sqr(y) + x0;
            y := 2 * x * y + y0;
            x := xt;
            interation += 1;
         until (Sqr(x) + Sqr(y) > 9) or (interation = 16);
         pixmap[py * size + px] := cColors[interation];
      end;
   end;
   
   case imageType of
      TMimeType.PNG:
         Result := PixmapToPNGData(pixmap, size, size);
      TMimeType.JPEG:
         Result := PixmapToJPEGData(pixmap, size, size);
   end;
end;