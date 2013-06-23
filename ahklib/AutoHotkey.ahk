; Author: Sebastian Godelet
#Warn  ; Recommended for catching common errors.
#SingleInstance force
#NoEnv
#InstallKeybdHook

SetCapsLockState AlwaysOff
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
FileEncoding, UTF-8

#Include <winos>
#Include <tfs>
#include <vistaswitcher>

if (%0% > 0) {
	Desktop := %1%
} else {
	Desktop := 0
}

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

; WINDOWS KEY + shift + H TOGGLES HIDDEN FILES 
#+h::winshell_toggle_hidden_files()

;vista switcher
#F11::vistaswitcher_show(1)
#F12::vistaswitcher_show()

;#f::
;   SendInput #+f
;   return

; Older versions of windows switched to chinese IME when pressing cntrl space
;+Space::
;return
