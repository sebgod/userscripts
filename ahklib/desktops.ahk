#NoEnv
#Warn

desktops_right(pDesktop) {
	lNextDesktop := mod(%pDesktop% + 1, 2)
	if (lNextDesktop == 1) { 
		Send, +{F2}
	} else {
		Send, +{F1}
	}
}

desktops_left(pDesktop ) {
	lNextDesktop := abs(mod(%pDesktop% - 1, 2))
	if (lNextDesktop == 1) { 
		Send, +{F2}
	} else {
		Send, +{F1}
	}
}

desktops_seticon(pDesktop) {
	IconFile := (%pDesktop% + 1) . ".ico"
	IconPath = %A_MyDocuments%\AutoHotkey\lib\%IconFile%
	Menu, Tray, Icon, %IconPath%
}