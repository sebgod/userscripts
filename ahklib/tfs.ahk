#NoEnv
#Warn

tfs_current_language=english
tfs_current_shift_state=0
tfs_previous_language=english
tfs_previous_shift_state=0
tfs_write_versal_state=0

tfs_set_current_language(pLanguage, pShift) {
	global tfs_previous_language
	global tfs_previous_shift_state
	global tfs_current_language
	global tfs_current_shift_state
	
	tfs_previous_language=%tfs_current_language%
	tfs_previous_shift_state=%tfs_current_shift_state%
	
	tfs_current_language=%pLanguage%
	tfs_current_shift_state=%pShift%
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
	global tfs_write_versal_state
	tfs_set_current_language(pLanguage, pShift)
	if (pLanguage == "english") {
		Send, ^+8
	} else if (pLanguage == "german") {
		Send, ^+2
	} else if (pLanguage == "chinese") {
		if (!pShift) {
			Send, ^+3
		}
	} else if (pLanguage == "korean") {
		if (pShift) {
			MsgBox TODO Korean using Hangeul
		} else {
			MsgBox TODO Korean using Romaja
		}
	} else if (pLanguage == "versal") {
		tfs_write_versal_state = 1
	} else {
		MsgBox Unhandled language '%pLanguage%'
	}
}
