; [SYS] handles tooltips

SYS_ToolTipShow(pText, pMillis = 1000, pX = 0, pY = 0) {
    CoordMode, Mouse, Screen
    CoordMode, ToolTip, Screen
    If ( pX = 0 or pY = 0 )
    {
        MouseGetPos, pX, pY
        pX += 16
        pY += 24
    }
    ToolTip, %pText% x=%pX% y=%pY%, %pX%, %pY%
    SetTimer, SYS_ToolTipHandler, %pMillis%
}

SYS_ToolTipHandler:
    SetTimer,, Off
    ToolTip
Return