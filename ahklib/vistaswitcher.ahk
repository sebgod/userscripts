#NoEnv
#Warn

#include <winos>

if A_Is64bitOS {
	VistaSwitcherExePath = %Prog64%\VistaSwitcher\vswitch64.exe
} else {
	MsgBox Please check if the path: %Prog32%\VistaSwitcher is valid
	VistaSwitcherExePath = %Prog32%\VistaSwitcher\vswitch.exe
}

vistaswitcher_startup() {
	global VistaSwitcherExePath
	IfExist, %VistaSwitcherExePath%
	Run %VistaSwitcherExePath% /startup
}

vistaswitcher_show(lApps := 0) {
	global VistaSwitcherExePath
	if (lApps == 1) {
		Run %VistaSwitcherExePath% /app
	} else {
		Run %VistaSwitcherExePath%
	}
}
