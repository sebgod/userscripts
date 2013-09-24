

;---------------------------------------------------------------------------
; Define constants
;---------------------------------------------------------------------------
ApplWin := "Skype API"
SKYPECONTROLAPI_ATTACH_SUCCESS               = 0
SKYPECONTROLAPI_ATTACH_PENDING_AUTHORIZATION = 1
SKYPECONTROLAPI_ATTACH_REFUSED               = 2
SKYPECONTROLAPI_ATTACH_NOT_AVAILABLE         = 3
SKYPECONTROLAPI_ATTACH_API_AVAILABLE         = 0x8001
WM_COPYDATA = 0x4a
WM_KEYDOWN  = 0x100
stackIndex = 0


;---------------------------------------------------------------------------
; Define GUI
;---------------------------------------------------------------------------
Gui +Resize +LabelGui +MinSize
Gui, Font, S8 CDefault, Verdana
Gui, Add, Edit, x0 y0 w320 h222 cBlue vSkypeText hwndhSkypeText Left Multi -WantReturn -Wrap
Gui, Add, StatusBar

;---------------------------------------------------------------------------
; Register Skype messages
;---------------------------------------------------------------------------
SkypeControlAPIDiscover := DllCall( "RegisterWindowMessage", Str,"SkypeControlAPIDiscover" )
SkypeControlAPIAttach := DllCall( "RegisterWindowMessage", Str,"SkypeControlAPIAttach" )

;---------------------------------------------------------------------------
; Show GUI
;---------------------------------------------------------------------------
Gui, Show, x300 y300 h245 w320, %ApplWin%

    ;---------------------------------------------------------------------------
    ; Obtain id of (this) client window
    ;---------------------------------------------------------------------------
    WinGet, hGui, ID, %ApplWin%

    ;---------------------------------------------------------------------------
    ; Register functions for incoming messages
    ;---------------------------------------------------------------------------
    OnMessage(SkypeControlAPIAttach, "SkypeAttach") 
    OnMessage(WM_COPYDATA, "SkypeReceive")
    OnMessage(WM_KEYDOWN, "KeyDown") 


    SendMessage, SkypeControlAPIDiscover, hGui,,, ahk_id 0xFFFF  
Return


;---------------------------------------------------------------------------
; Writes text to the Skype API by sending WM_COPYDATA message
;---------------------------------------------------------------------------
writeApi(textToWrite) {

    global 

    ;---------------------------------------------------------------------------
    ; Escape if Skype API is not available
    ;---------------------------------------------------------------------------
    If !hSKYPE_API
        Return

    ;---------------------------------------------------------------------------
    ; Fill the CopyDataStruct structure to be sent by WM_COPYDATA
    ;---------------------------------------------------------------------------
    DetectHiddenWindows On
    SetTitleMatchMode 2

    VarSetCapacity(CopyDataStruct, 12, 0)  ; Set up the structure's memory area.
    NumPut(StrLen(textToWrite) + 1, CopyDataStruct, 4)  ; OS requires that this be done.
    NumPut(&textToWrite, CopyDataStruct, 8)  ; Set lpData to point to the string itself.

    ;---------------------------------------------------------------------------
    ; Issue WM_COPYDATA message to Skype API
    ;---------------------------------------------------------------------------
    SendMessage, WM_COPYDATA, hGui, &CopyDataStruct,, ahk_id %hSKYPE_API%
}


;---------------------------------------------------------------------------
; This function is invoked upon incoming SkypeControlAPIAttach message
;---------------------------------------------------------------------------
SkypeAttach(wParam, lParam, msg, hwnd) {

    global

    ;---------------------------------------------------------------------------
    ; The Skype API handle is returned with WPARAM, if successfully attached
    ;---------------------------------------------------------------------------
    If (lParam = SKYPECONTROLAPI_ATTACH_SUCCESS)
        hSKYPE_API := wParam
}


;---------------------------------------------------------------------------
; This function is invoked upon incoming WM_COPYDATA message
; It is the sample on the bottom of the OnMessage() help page
;---------------------------------------------------------------------------
SkypeReceive(wParam, lParam) {

    global hSkypeText

    ;---------------------------------------------------------------------------
    ; This is the address of CopyDataStruct's lpData member
    ;---------------------------------------------------------------------------
    lpDataAddress := lParam + 8  ; .
    lpData := 0

    ;---------------------------------------------------------------------------
    ; For each byte in the lpData integer
    ;---------------------------------------------------------------------------
    Loop 4  ; For each byte in the lpData integer
    {
        ;---------------------------------------------------------------------------
        ; Build the integer from its bytes
        ;---------------------------------------------------------------------------
        lpData := lpData | (*lpDataAddress << 8 * (A_Index - 1))
        ;---------------------------------------------------------------------------
        ; Move on to the next byte
        ;---------------------------------------------------------------------------
        lpDataAddress += 1
    }
    
    ;---------------------------------------------------------------------------
    ; lpData contains the address of the string to be copied
    ; (must be a zero-terminated string)
    ;---------------------------------------------------------------------------
    DataLength := DllCall("lstrlen", UInt, lpData)
    If DataLength <= 0
        Control, EditPaste, A blank string was received or there was an error`r`n,, ahk_id %hSkypeText%
    Else
    {
        VarSetCapacity(textReceived, DataLength)
        DllCall("lstrcpy", "str", textReceived, "uint", lpData)  ; Copy the string out of the structure.
        
        if textReceived contains DURATION
        if textReceived not contains BODY
        {
            tooltip, %TextReceived%
            sleep, 999
            Tooltip ;clear tooltip
        }
    }    
    if textReceived not contains DURATION
    {
        Control, EditPaste, %textReceived%`r`n,, ahk_id %hSkypeText%
        ;msgbox, %textReceived%
        controlsend, EditPaste, ^{End},, ahk_id %hSkypeText%
    }
   
    Return true
}

;---------------------------------------------------------------------------
; This function is invoked upon incoming WM_KEYDOWN message
;---------------------------------------------------------------------------
KeyDown(wParam, lParam, msg, hwnd) {

    global hSkypeText, cmdStack, stackIndex

    ;---------------------------------------------------------------------------
    ; Process edit control events only
    ;---------------------------------------------------------------------------
    If (hwnd = hSkypeText)
    {
        ;---------------------------------------------------------------------------
        ; On ENTER key go and send command to Skype API
        ;---------------------------------------------------------------------------
        If (wParam = 13)  ;Enter
            Gosub SkypeSend

        ;---------------------------------------------------------------------------
        ; On UP key step backward and paste command from stack to current line
        ;---------------------------------------------------------------------------
        Else If (wParam = 38)  ;Up
        {
            StringSplit, cmd, cmdStack, `n
            command := cmd%stackIndex%
            Send +{Home}
            Control, EditPaste, %command%,, ahk_id %hSkypeText%
            Send ^{End}
            stackIndex -= 1
            If (stackIndex = 0)
                stackIndex := cmd0-1
        }

        ;---------------------------------------------------------------------------
        ; On DOWN key step forward and paste command from stack to current line
        ;---------------------------------------------------------------------------
        Else If (wParam = 40)  ;Down
        {
            StringSplit, cmd, cmdStack, `n
            command := cmd%stackIndex%
            Send +{Home}
            Control, EditPaste, %command%,, ahk_id %hSkypeText%
            Send ^{End}
            stackIndex += 1
            If (stackIndex > cmd0-1)
                stackIndex := 1
        }
    }
}


;---------------------------------------------------------------------------
; Send entered line command from GUI to the Skype API
;---------------------------------------------------------------------------
SkypeSend:

    ;---------------------------------------------------------------------------
    ; Extract last line (the command just entered) from the edit control
    ;---------------------------------------------------------------------------
    GuiControlGet, SkypeText
    StringSplit, cmd, SkypeText, `n
    command := cmd%cmd0%

    ;---------------------------------------------------------------------------
    ; Return if no command entered
    ;---------------------------------------------------------------------------
    If !command
        Return
    
    ;---------------------------------------------------------------------------
    ; Append command to stack
    ;---------------------------------------------------------------------------
    cmdStack := cmdStack . command . "`n"
    StringSplit, cmd, cmdStack, `n
    stackIndex := cmd0-1

    ;---------------------------------------------------------------------------
    ; Add CRLF
    ;---------------------------------------------------------------------------
    Control, EditPaste, `r`n,, ahk_id %hSkypeText%

    ;---------------------------------------------------------------------------
    ; Send command to Skype API and re-focus edit control for the next input
    ;---------------------------------------------------------------------------
    writeApi(command)
    ControlFocus,, ahk_id %hSkypeText%
Return


;---------------------------------------------------------------------------
; Re-scales imbedded edit control when resizing the main window
;---------------------------------------------------------------------------
GuiSize:

    ControlGetPos, px, py, pw, ph,, ahk_id %hSkypeText%
    ControlMove,, px, py, A_GuiWidth, A_GuiHeight-23, ahk_id %hSkypeText%
Return


;---------------------------------------------------------------------------
; Exit
;---------------------------------------------------------------------------
GuiClose:
    ExitApp
Return