#NoEnv
#Warn

#Include <winos>

winshell_UserIPCFolder() {
	global SessionName
	global Desktop
	Result = B:\%A_UserName%\%SessionName%_%Desktop%
	return Result
}

winshell_init() {
	userIPCFolder := winshell_UserIPCFolder()
	FileCreateDir, %userIPCFolder%\Clipboard
}

winshell_active_loop() {
	wwna_id := 0
	Loop { 
		WinExist("A")
		WinGet, wwna_id, ID
		_locale := tfs_get_window_locale(wwna_id)
		tfs_set_current_language(_locale, 0)
		WinWaitNotActive, ahk_id %wwna_id%
	}
}

winshell_toggle_alwaysOnTop() {
	WinExist("A")
	WinGet, lExStyle, ExStyle
	WinGetPos, splashX, splashY, ,
	splashX := "x" . (splashX + 40)
	splashY := "y" . splashY
	; 0x8 is WS_EX_TOPMOST.
	if (lExStyle & 0x8) {
		Winset, AlwaysOnTop, off
		winshell_ShowSplash(1000, splashX, splashY, "OFF always on top")
	}
	else
	{
		WinSet, AlwaysOnTop, on
		winshell_ShowSplash(1000, splashX, splashY, "ON always on top")
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
	If (eh_Class = "#32770" OR A_OSVersion = "WIN_8" OR A_OSVersion = "WIN_7" OR A_OSVersion = "WIN_VISTA") {
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
}

winshell_onclipboardchange() {
	userIPCFolder := winshell_UserIPCFolder()
	Info = %A_EventInfo%
	ClipId := WinExist("A")
	WinGet, ClipPid, PID, ahk_id %ClipId%
	if (ClipId == 0x0)
		return
	
	Name = %userIPCFolder%\Clipboard\%A_NowUTC%,%Info%,%ClipId%,%ClipPid%
	if (Info < 2) {
		FileAppend, %Clipboard%, *%Name%.txt
	} else {
		FileAppend, %ClipboardAll%, %Name%.data
	}
}
