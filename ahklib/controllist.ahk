#Persistent
SetTimer, WatchCursor, 100
return

WatchCursor:
  MouseGetPos, , , id, control
  WinGetTitle, title, ahk_id %id%
  WinGetClass, class, ahk_id %id%
  WinGet, ControlList, ControlList, A
  ToolTip, Under Cursor:`nahk_id: %id%`nahk_class: %class%`nTitle:%title%`nControl: %control%`n`nWindow Control List:`n%ControlList%
return