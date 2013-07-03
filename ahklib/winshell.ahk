#NoEnv
#Warn

winshell_init() {
	FileCreateDir, B:\Clipboard\%A_UserName%
}

winshell_active_loop() {
	wwna_id := 0
	Loop { 
		WinExist("A")
		WinGetTitle, wwna_title
		WinGet, wwna_id, ID
		WinGet, wwna_cmd, ProcessName
		WinGet, wwna_pid, PID
		WinGet, wwna_path, ProcessPath
		currentTime := winos_isotime_now()
		FileAppend, %currentTime%`t%wwna_id%`t%wwna_cmd%`t%wwna_pid%`t%wwna_path%`t%wwna_title%`n, B:\lastfound.txt
		WinWaitNotActive, ahk_id %wwna_id%
	}
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

winshell_onclipboardchange(pDesktop) {
	Info = %A_EventInfo%
	ClipId := WinExist("A")
	WinGet, ClipPid, PID, ahk_id %ClipId%
	if (ClipId == 0x0)
		return
	
	Name = B:\Clipboard\%A_UserName%\%A_NowUTC%,%Info%,%pDesktop%,%ClipId%,%ClipPid%
	if (Info < 2) {
		FileAppend, %Clipboard%, *%Name%.txt
   } else {
		FileAppend, %ClipboardAll%, %Name%.data
	}
}
