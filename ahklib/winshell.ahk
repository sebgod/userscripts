#NoEnv
#Warn

#Include <winos>

winshell_ramdriveVolume() {
    return "B:\"
}

winshell_UserIPCFolder() {
    global SessionName
    
    return % winshell_ramdriveVolume() . A_UserName . "\" . SessionName
}

winshell_init() {
    ramDrive := winshell_ramdriveVolume()
    ; create temp folder
    if FileExist(ramDrive . "Clipboard") {
        if FileExist(ramDrive . "Temp") {
            FileRemoveDir, % ramDrive . "Clipboard", 1
        } else {
            FileMoveDir, % ramDrive . "Clipboard", % ramDrive . "Temp", R
        }
    } else if (!FileExist(ramDrive . "Temp")) {
        FileCreateDir, % ramDrive . "Temp"
    }
    ; create user specific IPC folder (with clipboard folder)
    FileCreateDir, % winshell_UserIPCFolder() . "\Clipboard"
    
    global screenLeftMonitorWidth   := 1600
    global screenLeftMonitorHeight  := 900
    global screenRightMonitorWidth  := 1920
    global screenRightMonitorHeight := 1080
}

winshell_restoreWindow(windowTitle := "A") {
    activeWindow := WinActive(windowTitle)
    if activeWindow = 0
    {
        return
    }
    WinGet, minMax, MinMax, ahk_id %activeWindow%
    if (minMax = 1) {
        WinRestore, ahk_id %activeWindow%
    } else {
        WinMaximize, ahk_id %activeWindow%
    }
}

/*
    Source: http://www.autohotkey.com/board/topic/32874-moving-the-active-window-from-one-monitor-to-the-other/
*/
winshell_swapScreen(windowTitle := "A") {
    global screenLeftMonitorWidth
    global screenLeftMonitorHeight
    global screenRightMonitorWidth
    global screenRightMonitorHeight

    activeWindow := WinActive(windowTitle)
    borderThreshold := -10
    if activeWindow = 0
    {
        return
    }
    WinGet, minMax, MinMax, ahk_id %activeWindow%
    WinGetPos, x, y, width, height, ahk_id %activeWindow%
    
    if (minMax = 1) {
        ; WinRestore, ahk_id %activeWindow%
        ; a maximized window has x,y = -8,-8 on Windows 8
        newY := y
        if (x > borderThreshold) {
            newX := x - screenLeftMonitorWidth
            newWidth := screenLeftMonitorWidth   - screenRightMonitorWidth  + width
            newHeight := screenLeftMonitorHeight - screenRightMonitorHeight + height
        } else {
            newX := x + screenLeftMonitorWidth
            newWidth := screenRightMonitorWidth   - screenLeftMonitorWidth  + width
            newHeight := screenRightMonitorHeight - screenLeftMonitorHeight + height
        }
    } else {
        WinGetPos, x, y, width, height, ahk_id %activeWindow%
        if (x > borderThreshold) {
            xScale := screenLeftMonitorWidth / screenRightMonitorWidth
            yScale := screenLeftMonitorHeight / screenRightMonitorHeight
            newX := x * xScale
            newY := y * yScale
            newWidth := width * xScale
            newHeight := height * yScale
            newX := newX - screenLeftMonitorWidth
        } else {
            xScale := screenRightMonitorWidth / screenLeftMonitorWidth
            yScale := screenRightMonitorHeight / screenLeftMonitorHeight
            x := screenLeftMonitorWidth + x
            newX := x * xScale
            newY := y * yScale
            newWidth := width * xScale
            newHeight := height * yScale
        }
    }
    WinMove, ahk_id %activeWindow%, , %newX%, %newY%, %newWidth%, %newHeight%
    /*
    if (minMax = 1) {
        WinMaximize, ahk_id %activeWindow%
    }
    */
    WinActivate ahk_id %activeWindow%  ;Needed - otherwise another window may overlap it
    return
}

winshell_active_loop() {
    wwna_id := 0
    Loop { 
        wwna_id := WinExist("A")

        _locale := tsf_get_window_locale(wwna_id, _keyboard)
        tsf_set_current_language(_locale, 0)
        
        ; OutputDebug, % "id: " . wwna_id . " kbd: " . _keyboard . " locale: " . _locale . "`n"
        WinWaitNotActive, ahk_id %wwna_id%
    }
}

winshell_toggle_alwaysOnTop() {
    WinExist("A")
    WinGet, lExStyle, ExStyle
    WinGetPos, splashX, splashY,
    splashX := "x" . (splashX + 40)
    splashY := "y" . splashY
    ; 0x8 is WS_EX_TOPMOST.
    if (lExStyle & 0x8) {
        Winset, AlwaysOnTop, off
        winshell_ShowSplash(1000, splashX, splashY, "always on top: OFF")
    }
    else
    {
        WinSet, AlwaysOnTop, on
        winshell_ShowSplash(1000, splashX, splashY, "always on top: ON")
    }
}

winshell_ShowSplash(pTime, pX, pY, pTitle) {
    SplashImage,, %pX% %pY% b fs12, %pTitle%
    TurnOffSI(pTime * -1)
}

TurnOffSI(pTime := -1000) {
    SetTimer, TurnOffSITimer, % pTime
    Return
    
TurnOffSITimer:
    SplashImage, off
Return
}


winshell_toggle_hidden_files() {
    RegRead, HiddenFiles_Status, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden 
    
    If HiddenFiles_Status = 2  
        RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 1 
    Else  
        RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 2 

    WinGetClass, eh_Class,A 
    If (eh_Class == "#32770" OR A_OSVersion == "WIN_8" OR A_OSVersion == "WIN_7" OR A_OSVersion == "WIN_VISTA") {
        send, {F5}
    } Else {
        PostMessage, 0x111, 28931,,, A 
    }
    Return
}

winshell_stikynot_run() {
    Run StikyNot
    WinWait, ahk_class Sticky_Notes_Note_Window
    WinActivate
    WinSet, AlwaysOnTop, On
}

winshell_onclipboardchange() {
    Info := A_EventInfo
    ClipId := WinExist("A")
    WinGet, ClipPid, PID, ahk_id %ClipId%
    if (ClipId = 0x0)
        return

    Name := winshell_UserIPCFolder() . "\Clipboard\" . A_NowUTC . ",info=" . Info . ",id=" . ClipId . ",pid=" . ClipPid
    if (Info < 2) {
        FileAppend, % Clipboard, *%Name%.txt
    } else {
        FileAppend, %ClipboardAll%, %Name%.data
    }
}
