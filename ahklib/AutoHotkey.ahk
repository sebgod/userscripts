; Author: Sebastian Godelet <sebastian.godelet@gmail.com>
#Warn  ; Recommended for catching common errors.
#SingleInstance force
#NoEnv
#InstallKeybdHook

SetCapsLockState AlwaysOff
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
FileEncoding, UTF-8
CoordMode, Mouse, Screen

GroupAdd BrokenDXGames, ahk_class DX2MainUnrealWWindowsViewportWindow
GroupAdd BrokenDXGames, ahk_class DeusExHR

GroupAdd PDFViewerAndEditor, ahk_class PXE:{C5309AD3-73E4-4707-B1E1-2940D8AF3B9D}
GroupAdd PDFViewerAndEditor, ahk_class DSUI:PDFXCViewer

GroupAdd, MetroWindowGroup, ahk_class Windows.UI.Core.CoreWindow
GroupAdd, MetroWindowGroup, ahk_class ImmersiveLauncher

#Include <winos>
#Include <winshell>

Menu, Tray, Icon, % A_MyDocuments . "\AutoHotkey\lib\icons\enter_key.ico"
tsf_init()
winshell_init()
winshell_active_loop()

OnClipboardChange: 
    winshell_onclipboardchange()
return

#Include <composeKey>
#Include <diablo2>

^!F1::clip_ActiveWindow()
^!F2::clip_Release()

#IfWinActive ahk_class HH Parent
Esc::send, !{F4}
#IfWinActive

#IfWinActive QQ ahk_class TXGuiFoundation
Esc::send, !{F4}
#IfWinActive

#IfWinActive ahk_class TXGuiFoundation
Pause::
    send, !+L
    send, !{F4}
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

#IfWinActive ahk_group PDFViewerAndEditor
Esc::
    send, ^w
    Sleep, 20
    WinGetTitle, pdfXChangeTitle
    if (SubStr(pdfXChangeTitle, 1, 11) == "PDF-XChange")
    {
        send, !{F4}
    }
return
#IfWinActive

##::
    pressedWinHash := true
    Send, ^c
return
   
!Pause::
    winshell_activateAndLockQQ()
    DllCall("LockWorkStation")
return

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

; per mil
<^>!%::Send, ‰

; for ç and Ç
:c?B0*:^,::
Send, {BS 2}{U+0327}
return

; hotkey for ł AltGr-l
<^>!l::Send, ł 

; hotstring for ¢ 
:c?B0*:c^|::
Send, {BS 3}¢
return

; currency signs
<^>!y::¥        ; Chinese Yuan or Japanese Yen
<^>!p::£        ; Pound
<^>!w::₩        ; Korean Won
<^>!i::¤        ; generic currency sign
:c?:tögrög$::₮  ; Mongolian Tögrög

; COMBINING DOUBLE ACUTE ACCENT (U+030B)
:c?B0*:^2aa::
Send, {BS 4}{U+030B}
return

; COMBINING LONG SOLIDUS OVERLAY (U+0338)
:c?B0*:^lso::
Send, {BS 4}{U+0338}
return

; COMBINING LONG SOLIDUS OVERLAY (U+0338), precomposed
:c?B0*:O^/::
Send, {BS 3}Ø
return

:c?B0*:o^/::
Send, {BS 3}ø
return

:c?B0*:=^/::
Send, {BS 3}≠
return

:c?B0*:=^/::
Send, {BS 3}≠
return

; COMBINING DOT ABOVE (U+0307)

:c?B0*:^.::
Send, {BS 2}{U+0307}
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

; Insert a random UUID
^+g::guid_sendraw()

; Start X11 Desktop
#+x::Run config.xlaunch

; Start VirtualBox control window
#v::Run VirtualBox
return

; Within the Explorer CTRL+h toggles hidden files
#IfWinActive ahk_class CabinetWClass
^h::winshell_toggle_hidden_files()
Esc::send, !{F4}
#IfWinActive

; Internet explorer and metro enhancements
CapsLock & Left::Send, {Browser_Back}
CapsLock & Right::Send, {Browser_Forward}

#IfWinActive ahk_class IEFrame
^y::send, {Browser_Favorites}
^+Space::winshell_IETabTreeGui()
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

#IfWinActive ahk_group BrokenDXGames
RButton::Send, {LAlt}
#IfWinActive
