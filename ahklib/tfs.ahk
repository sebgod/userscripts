#NoEnv
#Warn

; en: 67569673    2057
; de: 67568647    1031
; ch: 134481924    2052
; ko: 67568658    1042
tfs_init() {
    global tfs_previous_language
    global tfs_previous_shift_state
    global tfs_current_language
    global tfs_current_shift_state
    global tfs_langCode
    
    tfs_current_language := tfs_get_window_locale(DllCall("GetDesktopWindow"))
    tfs_current_shift_state=0
    tfs_previous_language := tfs_current_language
    tfs_previous_shift_state=0
    tfs_langCode := tfs_current_language * 1000 + tfs_current_shift_state
}

tfs_winSpaceHandler() {
    WinGet, _currentWindow, ID, A
    KeyWait, LWin
    Sleep, 100
    _locale := tfs_get_window_locale(_currentWindow)
    tfs_set_current_language(_locale, 0)
}

tfs_get_window_locale(pWindowID) {
    _threadID := DllCall("GetWindowThreadProcessId", "Ptr", pWindowID, "Ptr", 0)
    _hkl := DllCall("GetKeyboardLayout", "UInt", _threadID)
    ; high16:= (_hkl>>16) & 0xffff
    return _hkl & 0xffff
}

tfs_set_current_language(pLanguage, pShift) {
    global tfs_previous_language
    global tfs_previous_shift_state
    global tfs_current_language
    global tfs_current_shift_state
    global tfs_langCode
    
    tfs_previous_language=%tfs_current_language%
    tfs_previous_shift_state=%tfs_current_shift_state%
    
    tfs_current_language=%pLanguage%
    tfs_current_shift_state=%pShift%
    tfs_langCode := tfs_current_language * 1000 + tfs_current_shift_state
}

tfs_toggle_language() {
    global tfs_previous_language    
    global tfs_previous_shift_state
    
    tfs_switch(tfs_previous_language, tfs_previous_shift_state)
}

tfs_is_language(pLanguage, pShift) {
    global tfs_current_language
    global tfs_current_shift_state
    
    return (pShift == tfs_current_shift_state) && (pLanguage == tfs_current_language)
}

tfs_switch(pLanguage, pShift) {
    tfs_set_current_language(pLanguage, pShift)
    if (pLanguage == 2057) {
        PostMessage, 0x50, 0, 67569673,, A
        ; Send, ^+8
    } else if (pLanguage == 1031) {
        PostMessage, 0x50, 0, 67568647,, A
        ; Send, ^+2
    } else if (pLanguage == 2052) {
        if (pShift) {
            cnPin_init()    
        } else {
            PostMessage, 0x50, 0, 134481924,, A
            ; Send, ^+3
        }
    } else if (pLanguage == 1042) {
        if (pShift) {
            MsgBox TODO Korean using Hangeul
        } else {
            PostMessage, 0x50, 0, 67568658,, A
            ; Send, ^+4
            koRom_init()
        }
    } else {
        MsgBox Unhandled language '%pLanguage%'
    }
}
