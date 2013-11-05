﻿; Author: Sebastian Godelet <sebastian.godelet@gmail.com>
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

#Include <composeKey>

#IfWinActive ahk_class ConsoleWindowClass
Esc::send, ^{Backspace}exit{Enter}
#IfWinActive

#IfWinActive ahk_class VirtualConsoleClass
Esc::
    WinGetTitle, vcc_title
    if (RegExMatch(vcc_title, "Debian|VIM") == 0) {
        send, {Home}exit{Space}{Enter}    
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

#+e::
Pwb :=  ComObjCreate("InternetExplorer.Application")
Pwb.Visible:=True
Return

; language switching
~#Space::tsf_winSpaceHandler()

; ---------------------------------- HOOK START -------------------------------
#UseHook ON
#if !GetKeyState("CapsLock", "T") 
!CapsLock::SetCapsLockState On
; en: 67569673    2057
; de: 67568647    1031
; ch: 134481924   2052
; ko: 67568658    1042
CapsLock & k::tsf_switch(1042, GetKeyState("shift"))
CapsLock & c::tsf_switch(2052, GetKeyState("shift"))
CapsLock & g::tsf_switch(1031, GetKeyState("shift"))
CapsLock & e::tsf_switch(2057, GetKeyState("shift"))
CapsLock::tsf_toggle_language()
#if GetKeyState("CapsLock", "T")
!CapsLock::SetCapsLockState AlwaysOff
ß::Send, {U+1E9E}
#if

#UseHook OFF
; ---------------------------------- HOOK END ---------------------------------

; capital ß, ſ and ʒ
!ß::Send, {U+1E9E}
<^>!s::Send, ſ
<^>!z::Send, ʒ

; AltGr and ^ enhancements
<^>!c::Send, ©
<^>!r::Send, ®
<^>!t::Send, ™
<^>!n::Send, ñ

; for ñ, ...
:c?B0*:^~::
Send, {BS 2}{U+1DC9}
return

; for ï, ë
:c?B0*:^d::
Send, {BS 2}{U+0308}
return

; for top °
:c?B0*:^°::
Send, {BS 2}{U+030A}
return

; for Hungarian ű, ő, ...
:c?B0*:^"::
;" this comment is just for the AHK notepad++ parser
Send, {BS 2}{U+030B}
return

; these are to be in sync with á,...
:c?B0*:´ü::
Send, {BS 2}ű
return

:c?B0*:´ä::
Send, {BS 2}a̋
return

:c?B0*:´ö::
Send, {BS 2}ő
return

:c?B0*:^2aa::
Send, {BS 4}{U+030B}
return

; per mil
<^>!%::Send, ‰

; for ç and Ç
:c?B0*:^,::
Send, {BS 2}{U+0327}
return

; currency signs
<^>!y::¥   ; Chinese yuan or Japanese yuan
<^>!p::£   ; Pound
<^>!w::₩   ; Korean won
<^>!i::¤   ; generic currency sign
:c?:zloty$::zł  ; Polish złoty
:c?:tögrög$::₮  ; Mongolian tögrög
:c?:cent$::¢    ; cents
; mathematical chars
:c?B0*:=^/::
Send, {BS 3}≠
return

:c?B0*:=^/::
Send, {BS 3}≠
return

; mathematical chars
:c?*:delta_=::≜
:c?*:def_=::≝
:c?*:~_=::≅
:c?*:°_=::≗
:c?*:^_=::≙
:c?*:m_=::≞
:c?*:?_=::≟
:c?*:*_=::≛

:c?B0*:||^/::
Send, {BS 4}{U+2226}
return

:c?B0*:|^/::
Send, {BS 3}{U+2224}
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
^B::send, {Browser_Favorites}
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

~#t::
    WinGetPos, taskBarX, taskbarY, taskbarW, taskbarH, ahk_class Shell_TrayWnd
    DllCall("SetCursorPos", int, taskBarX + 100, int, taskbarY + (taskbarH / 2))
return

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
