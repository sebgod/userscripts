#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#IfWinActive ahk_class Diablo II

*MButton::send, i
*WheelUp::send, {PgUp}
*WheelDown::send, {PgDn}
*XButton2::send, {F2}{RButton}{F1}

#IfWinActive
