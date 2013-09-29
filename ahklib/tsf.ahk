#NoEnv
#Warn

tsf_init() {
    global tsf_engGB := 0x0809
    global tsf_gerDE := 0x0407
    global tsf_zhoCN := 0x0804
    global tsf_korKO := 0x0412
    
    global tsf_engGB_ger := 0x04070809
    global tsf_gerDE_ger := 0x04070407
    global tsf_zhoCN_ime := 0x08040804
    global tsf_korKO_ime := 0x04120412
    
    global tsf_current_language := tsf_get_window_locale(DllCall("GetDesktopWindow"), _keyboard)
    global tsf_current_shift_state=0
    global tsf_previous_language := tsf_current_language
    global tsf_previous_shift_state=0
    global tsf_langCode := tsf_current_language * 1000 + tsf_current_shift_state
}

tsf_winSpaceHandler() {
    WinGet, _currentWindow, ID, A
    KeyWait, LWin
    Sleep, 100
    _locale := tsf_get_window_locale(_currentWindow, _keyboard)
    tsf_set_current_language(_locale, 0)
}

tsf_get_window_locale(pWindowID, ByRef oKeyboard) {
    _threadID := DllCall("GetWindowThreadProcessId", "Ptr", pWindowID, "Ptr", 0)
    _hkl      := DllCall("GetKeyboardLayout", "UInt", _threadID)
    _language := _hkl & 0xffff
    oKeyboard := (_hkl>>16) & 0xffff
    return _language
}

tsf_set_current_language(pLanguage, pShift) {
    global tsf_current_language
    global tsf_current_shift_state
    global tsf_langCode

    global tsf_previous_language := tsf_current_language
    global tsf_previous_shift_state := tsf_current_shift_state
    
    global tsf_zhoCN
    global tsf_korKO
    
    tsf_current_language := pLanguage
    tsf_current_shift_state := pShift
    tsf_langCode := tsf_current_language * 1000 + tsf_current_shift_state
    
    if (tsf_current_shift_state == 1) {
        if (tsf_current_language == tsf_korKO) {
            koRom_init()
        } else if (tsf_current_language == tsf_zhoCN) {
            cnPin_init()
        }
    }
}

tsf_toggle_language() {
    global tsf_previous_language    
    global tsf_previous_shift_state
    
    tsf_switch(tsf_previous_language, tsf_previous_shift_state)
}

tsf_is_current_language(pLanguage, pShift) {
    global tsf_current_language
    global tsf_current_shift_state
    
    return (pShift == tsf_current_shift_state) && (pLanguage == tsf_current_language)
}

tsf_switch(pLanguage, pShift) {
    ; language identifiers
    global tsf_engGB, tsf_gerDE, tsf_zhoCN, tsf_korKO
    ; keyboards and IME's
    global tsf_engGB_ger, tsf_gerDE_ger
    global tsf_zhoCN_ime, tsf_korKO_ime

    tsf_set_current_language(pLanguage, pShift)
    if (pLanguage == tsf_engGB) {
        PostMessage, 0x50, 0, % tsf_engGB_ger,, A
    } else if (pLanguage == tsf_gerDE) {
        PostMessage, 0x50, 0, % tsf_gerDE_ger,, A
    } else if (pLanguage == tsf_zhoCN) {
        if (pShift == 0) {
            PostMessage, 0x50, 0, % tsf_zhoCN_ime,, A
        }
    } else if (pLanguage == tsf_korKO) {
        PostMessage, 0x50, 0, % tsf_korKO_ime,, A
    } else {
        MsgBox % "Unhandled language: " . pLanguage
    }
}
