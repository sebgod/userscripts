unit HtmlLib;

type Uri = class

end;

type HElement = class
protected
   function GetTagName : String;
   begin
      exit(LowerCase(SubStr(ClassName, 1)));
   end;

public
   property TagName : String read GetTagName;
   
   function AsHtml: String; virtual;
   begin
      exit(Format('<%1:s></%1:s>', [TagName]));
   end;
end;

type HSelfClosingElement = class(HElement)
public
   function AsHtml: String; override;
   begin
      exit(Format('<%s/>', [TagName]));
   end;
end;

type HElementWithChildren = class(HElement)
end;

type HA = class(HElementWithChildren)
public
   constructor Create(const href : Uri);
   begin
   end;
end;

type HXMLNSElement = class(HElement)
end;

type HImg = class(HSelfClosingElement)
public
   constructor HImg(const src : Uri);
   begin
   end;
end;

type HTime = class(HElementWithChildren)
public
   constructor DateAndTime(const dt : Float);
   begin
      
   end;
end;

type HSVG = class(HXMLNSElement)

end;

