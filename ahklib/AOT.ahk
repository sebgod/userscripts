#include <SYS>

AOT_WinIDs=
AOT_CheckWinIDs:
	DetectHiddenWindows, On
	Loop, Parse, AOT_WinIDs, |
		If ( A_LoopField )
			IfWinNotExist, ahk_id %A_LoopField%
				StringReplace, AOT_WinIDs, AOT_WinIDs, |%A_LoopField%, , All
Return

#SC029::
#LButton::
AOT_SetToggle:
	Gosub, AOT_CheckWinIDs
	SetWinDelay, -1
	
	IfInString, A_ThisHotkey, LButton
	{
		MouseGetPos, , , AOT_WinID
		If ( !AOT_WinID )
			Return
		IfWinNotActive, ahk_id %AOT_WinID%
			WinActivate, ahk_id %AOT_WinID%
	}
	
	IfWinActive, A
	{
		WinGet, AOT_WinID, ID
		If ( !AOT_WinID )
			Return
		WinGetClass, AOT_WinClass, ahk_id %AOT_WinID%
		If ( AOT_WinClass = "Progman" )
			Return
			
		WinGet, AOT_ExStyle, ExStyle, ahk_id %AOT_WinID%
		If ( AOT_ExStyle & 0x8 ) ; 0x8 is WS_EX_TOPMOST
		{
			SYS_ToolTipText = Always on Top: OFF
			Gosub, AOT_SetOff
		}
		Else
		{
			SYS_ToolTipText = Always on Top: ON
			Gosub, AOT_SetOn
		}
		Gosub, SYS_ToolTipFeedbackShow
	}
Return

AOT_SetOn:
	Gosub, AOT_CheckWinIDs
	SetWinDelay, -1
	IfWinNotExist, ahk_id %AOT_WinID%
		Return
	IfNotInString, AOT_WinIDs, |%AOT_WinID%
		AOT_WinIDs = %AOT_WinIDs%|%AOT_WinID%
	WinSet, AlwaysOnTop, On, ahk_id %AOT_WinID%
Return

AOT_SetOff:
	Gosub, AOT_CheckWinIDs
	SetWinDelay, -1
	IfWinNotExist, ahk_id %AOT_WinID%
		Return
	StringReplace, AOT_WinIDs, AOT_WinIDs, |%A_LoopField%, , All
	WinSet, AlwaysOnTop, Off, ahk_id %AOT_WinID%
Return

AOT_SetAllOff:
	Gosub, AOT_CheckWinIDs
	Loop, Parse, AOT_WinIDs, |
		If ( A_LoopField )
		{
			AOT_WinID = %A_LoopField%
			Gosub, AOT_SetOff
		}
Return