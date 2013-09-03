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
winshell_active_loop()

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
~#Space::tfs_winSpaceHandler()

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

; Zero-Width space
<^>!Space::Send, {U+200B}

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

; Window shell script
#a::
winshell_toggle_alwaysOnTop()
return

#+m::
Send, !{SPACE}
Send, R
Send, !{SPACE}
Send, M
Send, {UP}
return
