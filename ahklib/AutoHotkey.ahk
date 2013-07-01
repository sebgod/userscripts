; Author: Sebastian Godelet
#Warn  ; Recommended for catching common errors.
#SingleInstance force
#NoEnv
#InstallKeybdHook

SetCapsLockState AlwaysOff
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
FileEncoding, UTF-8

if (%0% > 0) {
	Desktop := %1%
} else {
	Desktop := 0
}

#Include <winos>
#Include <tfs>
#include <vistaswitcher>

desktops_seticon(%Desktop%)

if (Desktop > 0) {
	vistaswitcher_startup()
}

OnClipboardChange:
	winshell_onclipboardchange(%Desktop%)
return

#IfWinActive ahk_class ConsoleWindowClass
;Tab::MsgBox Pressed Tab!
Esc::send, exit{Enter}
#IfWinActive

#IfWinActive ahk_class VirtualConsoleClass
Esc::send, exit{Enter}
#IfWinActive

#IfWinActive ahk_class ahk_class CalcFrame
Esc::send, !{F4}
#IfWinActive

#IfWInActive ahk_class Photo_Lightweight_Viewer
Esc::send, !{F4}
#IfWinActive

; Sysinternals desktop movement
#UseHook ON
CapsLock & right::desktops_right(%Desktop%)
CapsLock & left::desktops_left(%Desktop%) 

; language switching
CapsLock & k::tfs_switch("korean", GetKeyState("shift"))
CapsLock & c::tfs_switch("chinese", GetKeyState("shift"))
CapsLock & g::tfs_switch("german", GetKeyState("shift"))
CapsLock & e::tfs_switch("english", GetKeyState("shift"))
CapsLock::tfs_toggle_language()

#UseHook OFF

; Insert a random uuid
^+g::guid_sendraw()

; Start X11 Desktop
#+x::desktops_startx()

; Start VirtualBox window
#v::Run VirtualBox

; Within the Explorer ctrl+h toggles hidden files
#IfWInActive ahk_class CabinetWClass
^h::winshell_toggle_hidden_files()
Esc::send, !{F4}
#IfWinActive


;vista switcher
#F11::vistaswitcher_show(1)
#F12::vistaswitcher_show()

;#f::
;   SendInput #+f
;   return

; Older versions of windows switched to chinese IME when pressing cntrl space
;+Space::
;return
