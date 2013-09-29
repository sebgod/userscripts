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

#Include <winos>
#include <vistaswitcher>
#Include <winshell>

Menu, Tray, Icon, % A_MyDocuments . "\AutoHotkey\lib\icons\enter_key.ico"
tsf_init()
winshell_init()
winshell_active_loop()

OnClipboardChange: 
    winshell_onclipboardchange()
return

#Include <accents>
#Include <composeKey>

#IfWinActive ahk_class ConsoleWindowClass
Esc::send, ^{Backspace}exit{Enter}
#IfWinActive

#IfWinActive ahk_class VirtualConsoleClass
Esc::
    WinGetTitle, vcc_title
    if (RegExMatch(vcc_title, "Debian|VIM") == 0) {
        send, ^{Backspace}exit{Enter}    
    } else {
        send, {Esc}
    }
return
#IfWinActive
    
#IfWinActive ahk_class tSkMainForm
Esc::send, !{F4}
#IfWinActive

#IfWinActive ahk_class AcrobatSDIWindow
ESC::Send, !{F4}    
#IfWinActive 

#IfWinActive ahk_class CalcFrame
Esc::send, !{F4}
#IfWinActive

#IfWInActive ahk_class Photo_Lightweight_Viewer
Esc::send, !{F4}
#IfWinActive

#+t::
Pwb :=  ComObjCreate("InternetExplorer.Application")
Pwb.Visible:=True
Pwb.Navigate("http://www.google.com") 
Pwb.Navigate("http://stackoverflow.com", 2048)
Pwb.Navigate("http://news.google.com", 2048)
Pwb.Navigate("https://www.quora.com/", 2048)
Return

; language switching
~#Space::tsf_winSpaceHandler()

; ---------------------------------- HOOK START -------------------------------
#UseHook ON
; en: 67569673    2057
; de: 67568647    1031
; ch: 134481924    2052
; ko: 67568658    1042
CapsLock & k::tsf_switch(1042, GetKeyState("shift"))
CapsLock & c::tsf_switch(2052, GetKeyState("shift"))
CapsLock & g::tsf_switch(1031, GetKeyState("shift"))
CapsLock & e::tsf_switch(2057, GetKeyState("shift"))
CapsLock::tsf_toggle_language()

; Versal writing and ß and ẞ and ſ and accent handling
CapsLock & ß::Send, ẞ
#UseHook OFF
; ---------------------------------- HOOK END ---------------------------------

; German helpers majuscle ß and fractured s and z
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

; AltGr and ^ enhancements
<^>!c::Send, ©
<^>!r::Send, ®
<^>!t::Send, ™
<^>!n::Send, ñ
<^>!+e::Send, ë

:cB0*:^c::
Send, {BS 2}ç
return

:cB0*:^C::
Send, {BS 2}Ç
return

<^>!Space::Send, {U+200B} ; Zero-Width space

; Insert a random uuid
^+g::guid_sendraw()

; Start X11 Desktop
#+x::Run config.xlaunch

; Start VirtualBox control window
#v::Run VirtualBox

; Within the Explorer ctrl+h toggles hidden files
#IfWinActive ahk_class CabinetWClass
^h::winshell_toggle_hidden_files()
Esc::send, !{F4}
#IfWinActive

; Internet explorer enhancements
#IfWinActive ahk_class IEFrame
Esc::send, ^w
^Space::send, {Browser_Favorites}
^+Space::winshell_IETabTreeGui()

CapsLock & Left::Send, {Browser_Back}
CapsLock & Right::Send, {Browser_Forward}
#IfWinActive

; Window shell script
#a::winshell_toggle_alwaysOnTop()

#PgUp::Send, #+{Right}
#WheelUp::Send, #+{Right}

#PgDn::Send, #+{Left}
#WheelDown::Send #+{Left}

; Assign right click and wheel movement to CTRL-Tab
#if GetKeyState("RControl")
*WheelDown::send, {Tab}
*WheelUp::send, +{Tab}
#if

#if not GetKeyState("RControl")
+WheelDown::send, {RControl Down}+{Tab}
+WheelUp::send, {RControl Down}{Tab}
#if

#If GetKeyState("RControl")
*~LShift UP::send, {RControl UP}
#If

#If not GetKeyState("RControl") and GetKeyState("LControl")
*LWin::send, ^{Tab}
#If
