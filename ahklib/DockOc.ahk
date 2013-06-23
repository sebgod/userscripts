;DockOc.ahk
; Dock as many windows as you like to the screen's edges
; Usage: Grab a window by the caption and drop it on a screen edge
;Skrommel @ 2008

#NoEnv
#SingleInstance,Force
DetectHiddenWindows,On
SetWinDelay,0
CoordMode,Mouse,Screen

applicationname=DockOc

Gosub,MENU
showing=0
SetTimer,CHECK,500
OnExit,EXIT
Return


~LButton Up::
MouseGetPos,mx,my,mwin,mctrl
If (mx=monitorLeft)
  edge=left
Else
If (mx=monitorRight-1)
  edge=right
Else
If (my=monitorTop)
  edge=top
Else
If (my=monitorBottom-1)
  edge=bottom
Else
  Return
MouseGetPos,mx,my,mwin 
SendMessage,0x84,,(my<<16)|mx,,ahk_id %mwin% 
part:=ErrorLevel
If part<>2
  Return

WinGetPos,wx,wy,ww,wh,ahk_id %mwin%
If (edge="left")
  WinMove,ahk_id %mwin%,,0,
Else
If (edge="right")
  WinMove,ahk_id %mwin%,,% A_ScreenWidth-ww,
Else
If (edge="top")
  WinMove,ahk_id %mwin%,,,0
Else
If (edge="bottom")
  WinMove,ahk_id %mwin%,,,% A_ScreenHeight-wh
WinSet,AlwaysOntop,On,ahk_id %mwin%
WinHide,ahk_id %mwin%
%edge%=% "" %edge% . mwin ","
showing=0
Return


CHECK:
SysGet,monitor,MonitorWorkArea 
MouseGetPos,mx,my,mwin,mctrl
edge=
If (mx=0)
  edge=left
Else
If (mx=A_ScreenWidth-1)
  edge=right
Else
If (my=0)
  edge=top
Else
If (my=A_ScreenHeight-1)
  edge=bottom

If (edge="left" Or edge="right")
  orientation=y
Else
If (edge="top" Or edge="bottom")
  orientation=x
Else
{
  If (mwin<>showingid)
  {
    WinHide,ahk_id %showingid%
    showing=0
  }
  Return
}

closestid=
shortest=9999
Loop,Parse,%edge%,`,
{
  id:=A_LoopField
  If id=
    Break
  IfWinNotExist,ahk_id %id%
    StringReplace,%edge%,%edge%,%id%`,,
  WinGetPos,wx,wy,ww,wh,ahk_id %id%
  distance:=Abs(m%orientation%-w%orientation%)
  If (distance<shortest) ; And my-wy>0 And my-wy<wh)
  {
    shortest:=distance
    closestid:=id
  }
}
If closestid=
  Return
If (showingid<>closestid)
  WinHide,ahk_id %showingid%
showingid:=closestid
WinShow,ahk_id %showingid%
showing=1
Return


EXIT:
edges=left,right,top,bottom
Loop,Parse,edges,`,
{
  edge:=A_LoopField
  Loop,Parse,%edge%,`,
  {
    id:=A_LoopField
    WinSet,AlwaysOntop,Off,ahk_id %id%
    WinShow,ahk_id %id%
  }
}
ExitApp


MENU:
Menu,Tray,DeleteAll
Menu,Tray,NoStandard
Menu,Tray,Add,%applicationname%,ABOUT
Menu,Tray,Add,
Menu,Tray,Add,&About...,ABOUT
Menu,Tray,Add,E&xit,EXIT
Menu,Tray,Tip,%applicationname%
Menu,Tray,Default,%applicationname%
Return


ABOUT:
Gui,Destroy
Gui,Margin,20,20
Gui,Add,Picture,xm Icon1,%applicationname%.exe
Gui,Font,W700
Gui,Add,Text,x+10 yp+10 Bold,%applicationname% v1.0
Gui,Font,W400
Gui,Add,Text,y+10,Dock as many windows as you like to the screen's edges
Gui,Add,Text,xp y+5,Usage: Grab a window by the caption and drop it on a screen edge

Gui,Add,Picture,xm y+20 G1HOURSOFTWARE Icon2,%applicationname%.exe
Gui,Add,Text,x+10 yp,For more tools, information and donations, please visit 
Gui,Font,W700 CBlue
Gui,Add,Text,y+5 G1HOURSOFTWARE,www.1HourSoftware.com
Gui,Font,W400 CBlack

Gui,Add,Picture,xm y+20 GDONATIONCODER Icon7,%applicationname%.exe
Gui,Add,Text,x+10 yp,Please support the contributors at
Gui,Font,W700 CBlue
Gui,Add,Text,y+5 GDONATIONCODER,www.DonationCoder.com
Gui,Font,W400 CBlack

Gui,Add,Picture,xm y+20 GAUTOHOTKEY Icon6,%applicationname%.exe
Gui,Add,Text,x+10 yp,This tool was made using the powerful
Gui,Font,W700 CBlue
Gui,Add,Text,y+5 GAUTOHOTKEY,www.AutoHotkey.com
Gui,Font,W400 CBlack

Gui,Show,,%applicationname% - About
Gui,+LastFound
guiid:=WinExist()
hCurs:=DllCall("LoadCursor","UInt",NULL,"Int",32649,"UInt") ;IDC_HAND
OnMessage(0x200,"WM_MOUSEMOVE")
Return

1HOURSOFTWARE:
Run,www.1HourSoftware.com
Return

DONATIONCODER:
Run,www.DonationCoder.com
Return

AUTOHOTKEY:
Run,www.AutoHotkey.com
Return

WM_MOUSEMOVE(wParam,lParam)
{
  Global hCurs
  Global guiid
  MouseGetPos,,,mwin,mctrl
  If mwin in %guiid%
  If mctrl in Static7,Static10,Static13
    DllCall("SetCursor","UInt",hCurs)
  Return
}

GuiEscape:
GuiClose:
  Gui,Destroy
  OnMessage(0x200,"") 
  DllCall("DestroyCursor","Uint",hCurs) 
Return