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
    global pressedWinHash := false
    ramDrive := winshell_ramdriveVolume()
    ; create temp folder
    if (FileExist(ramDrive . "Clipboard")) {
        if (FileExist(ramDrive . "Temp")) {
            FileRemoveDir, % ramDrive . "Clipboard", 1
        } else {
            FileMoveDir, % ramDrive . "Clipboard", % ramDrive . "Temp", R
        }
    } else if (!FileExist(ramDrive . "Temp")) {
        FileCreateDir, % ramDrive . "Temp"
    }
    ; create user specific IPC folder (with clipboard folder)
    FileCreateDir, % winshell_UserIPCFolder() . "\Clipboard"
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

winshell_onclipboardchange(pClip) {
    global pressedWinHash

    Info := A_EventInfo
    ClipId := WinExist("A")
    WinGet, ClipPid, PID, ahk_id %ClipId%
    if (ClipId = 0x0)
        return

    Name := winshell_UserIPCFolder() . "\Clipboard\" . A_NowUTC . ",info=" . Info . ",id=" . ClipId . ",pid=" . ClipPid
    if (Info < 2) {
        FileAppend, % pClip, *%Name%.txt
        if (pressedWinHash) {
            pressedWinHash := false
        } else {
            return
        }
    } else {
        FileAppend, %ClipboardAll%, %Name%.data
        return
    }
}

winshell_IETabActivate(TabName, WinTitle="") {
    ControlGet, hTabUI , hWnd,, DirectUIHWND3, % WinTitle = "" ? "ahk_class IEFrame" : WinTitle
    Tabs := Acc_ObjectFromWindow(hTabUI).accChild(1) ; access "Tabs" control
    Loop, % Tabs.accChildCount {
        if (Tabs.accChild(A_Index).accName(0) = TabName) {
            return, Tabs.accChild(A_Index).accDoDefaultAction(0)
        }
    }
}

winshell_IETabTreeGui() {
    MsgBox, "Show Tab Tree Gui"
}


winshell_activateAndLockQQ() {
    WinActivate, ahk_class TXGuiFoundation
    Send, !+l
    WinMinimize, A    
}