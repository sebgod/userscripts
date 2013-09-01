; Author: Sebastian Godelet
#Warn  ; Recommended for catching common errors.
#SingleInstance force
#NoEnv
#InstallKeybdHook

SetCapsLockState AlwaysOff
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
FileEncoding, UTF-8
CoordMode, Mouse, Screen

if (0 > 0) {
	Desktop := 0
	desktops_writereg(Desktop)
} else {
	Desktop := desktops_readreg()
}

#Include <winos>
#include <vistaswitcher>
#Include <winshell>

tfs_init()

desktops_seticon()

if (Desktop > 0) {
	vistaswitcher_startup()
}

winshell_init()
; Conserve recources winshell_active_loop()

OnClipboardChange: 
	winshell_onclipboardchange()
return

#IfWinActive ahk_class ConsoleWindowClass
Esc::send, ^{Backspace}exit{Enter}
#IfWinActive

#IfWinActive ahk_class VirtualConsoleClass
Esc::send, ^{Backspace}exit{Enter}
#IfWinActive

#IfWinActive ahk_class tSkMainForm
Esc::send, !{F4}
#IfWinActive

#IfWinActive ahk_class ahk_class CalcFrame
Esc::send, !{F4}
#IfWinActive

#IfWInActive ahk_class Photo_Lightweight_Viewer
Esc::send, !{F4}
#IfWinActive

; Sysinternals desktop movement
#UseHook ON
CapsLock & right::desktops_right(Desktop)
CapsLock & left::desktops_left(Desktop) 
#UseHook Off

; language switching
~#Space::
tfs_pressedWindowSpace := 1
return

~LWin UP::
if (tfs_pressedWindowSpace == 1) {
	Sleep, 100
	tfs_winSpaceHandler()
}
return

#UseHook ON
; en: 67569673	2057
; de: 67568647	1031
; ch: 134481924	2052
; ko: 67568658	1042
CapsLock & k::tfs_switch(1042, GetKeyState("shift"))
CapsLock & c::tfs_switch(2052, GetKeyState("shift"))
CapsLock & g::tfs_switch(1031, GetKeyState("shift"))
CapsLock & e::tfs_switch(2057, GetKeyState("shift"))
CapsLock::tfs_toggle_language()

; Versal writing and ß and ẞ and ſ and accent handling
CapsLock & ß::Send, ẞ

#UseHook OFF

#Include <accents>

:*?C:sss::ſsſ

:*?C:A?::Aẞ
:*?C:E?::Eẞ
:*?C:I?::Iẞ
:*?C:O?::Oẞ
:*?C:U?::Uẞ
:*?C:Ö?::Öẞ
:*?C:Ä?::Äẞ
:*?C:Ü?::Üẞ

<^>!s::Send, ſ
<^>!z::Send, ʒ
	
:*?C:sz::ſʒ

; Insert a random uuid
^+g::guid_sendraw()

; Start X11 Desktop
#+x::desktops_startx()

; Start VirtualBox control window
#v::Run VirtualBox

; Within the Explorer ctrl+h toggles hidden files
#IfWinActive ahk_class CabinetWClass
^h::winshell_toggle_hidden_files()
Esc::send, !{F4}
#IfWinActive

; internet explorer
#IfWinActive ahk_class IEFrame
Esc::send, ^w
#WheelDown::send, ^+{Tab}
#WheelUp::send, ^{Tab}
#IfWinActive

; vista switcher
#F11::vistaswitcher_show(1)
#F12::vistaswitcher_show()

#a::
WinGet, currentWindow, ID, A
WinGet, ExStyle, ExStyle, ahk_id %currentWindow%
if (ExStyle & 0x8)  ; 0x8 is WS_EX_TOPMOST.
{
	Winset, AlwaysOnTop, off, ahk_id %currentWindow%
	SplashImage,, x0 y0 b fs12, OFF always on top.
	Sleep, 250
	SplashImage, Off
}
else
{
	WinSet, AlwaysOnTop, on, ahk_id %currentWindow%
	SplashImage,,x0 y0 b fs12, ON always on top.
	Sleep, 250
	SplashImage, Off
}
return

#+m::
Send, !{SPACE}
Send, R
Send, !{SPACE}
Send, M
Send, {UP}
return

TurnOffSI:
SplashImage, off
SetTimer, TurnOffSI, 1000, Off
Return

;#f::
;   SendInput #+f
;   return

; Older versions of windows switched to chinese IME when pressing cntrl space
;+Space::
;return
