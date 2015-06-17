#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^!a::clip_ActiveWindow()
^!s::clip_Release()
Return

clip_ActiveWindow() {
    WinGetPos, VarX, VarY, Width, Height, A
    VarX := VarX + 10
    VarY := VarY + 31
    VarX2 := VarX + Width - 20    ;10 + 10
    VarY2 := VarY + Height - 41   ;31 + 10
    clip_Rect( True, VarX, VarY, VarX2, VarY2)
}

clip_Release() {
    clip_Rect( False,0,0,0,0)
}

clip_Rect( Confine=True, x1=0 , y1=0, x2=1, y2=1 ) {
    VarSetCapacity(R,16,0),
    NumPut(x1,&R+0),
    NumPut(y1,&R+4),
    NumPut(x2,&R+8),
    NumPut(y2,&R+12)
    
    Return Confine
        ? DllCall( "ClipCursor", UInt,&R )
        : DllCall( "ClipCursor" )
}
