#NoEnv
#Warn

desktops_switchto(pNumber) {
    desktops_writereg(pNumber)
    if (pNumber == 0) { 
        Send, +{F1} 
    } else if (pNumber == 1) {
        Send, +{F2}
    } else if (pNumber == 2) {
        Send, +{F3}
    } else if (pNumber == 3) {
        Send, +{F4}
    }
}

desktops_readreg() {
    RegRead, lDesk, HKEY_CURRENT_USER, Software\Sysinternals\Desktops, CurrentDesktop
    if ErrorLevel {
        lDesk = 0
    }
    return lDesk
}

desktops_writereg(pNumber) {
    RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Sysinternals\Desktops, CurrentDesktop, %pNumber%
}

desktops_right(pDesktop) {
    desktops_switchto(mod(pDesktop + 1, 4))
}

desktops_left(pDesktop ) {
    desktops_switchto(abs(mod(pDesktop - 1, 4)))
}

desktops_seticon() {
    global Desktop
    IconFile := (Desktop + 1) . ".ico"
    IconPath = %A_MyDocuments%\AutoHotkey\lib\%IconFile%
    Menu, Tray, Icon, % IconPath
}

desktops_startx() {
    Run config.xlaunch
}