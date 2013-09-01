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

winshell_add_window_history(pID) {
	userIPCFolder := winshell_UserIPCFolder()
	WinGetTitle, wwna_title
	WinGet, wwna_cmd, ProcessName
	WinGet, wwna_pid, PID
	WinGet, wwna_path, ProcessPath
	WinGetClass, wwna_class, ahk_id %wwna_id%
	currentTime := winos_isotime_now()
	FileAppend, %currentTime%`t%wwna_id%`t%wwna_cmd%`t%wwna_pid%`t%wwna_path%`t%wwna_title%`n, %userIPCFolder%\window_activity_history.txt
}

winshell_toggle_alwaysOnTop() {
	WinGet, currentWindow, ID, A
	WinGet, ExStyle, ExStyle, ahk_id %currentWindow%
	WinGetPos, splashX, splashY, , , ahk_id %currentWindow%
	splashX := "x" . (splashX + 40)
	splashY := "y" . splashY
	; 0x8 is WS_EX_TOPMOST.
	if (ExStyle & 0x8) {
		Winset, AlwaysOnTop, off, ahk_id %currentWindow%
		winshell_ShowSplash(1000, splashX, splashY, "OFF always on top")
	}
	else
	{
		WinSet, AlwaysOnTop, on, ahk_id %currentWindow%
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
