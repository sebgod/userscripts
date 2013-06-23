#NoEnv
#Warn

tfs_switch_korean(pShift := false) {
	if (pShift) {
		MsgBox TODO Korean using Hangeul
	} else {
		MsgBox TODO Korean using Romaja
	}
	return
}

tfs_switch_chinese(pShift := false) {
	if (GetKeyState("shift")) {
		MsgBox Pinyin using ASCII
	} else {
		Send, ^+3
	}
	return
}

tfs_switch_german(pShift := false) {
	Send, ^+2
	return
}

tfs_switch_english(pShift := false) {
	Send, ^+8
	return
}