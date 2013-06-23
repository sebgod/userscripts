;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Author: Lior Gotian 
; Date:   09.05.06
; URL:    http://SoftwareCustom4u.com
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#NoEnv
SendMode Input
#SingleInstance force 

; Default Text
defaultText = Type your text in the field and press the talk button.

;;;;;;;;;;;;;;;;;;;;;;;
;GUI Config
;;;;;;;;;;;;;;;;;;;;;;;
Gui, Show, w400 h60, Ms-Agent Talk 
Gui, Add, Text, x5 y5 w40 h20, Text: 
Gui, Add, Edit, vTXT x40 y5 w345 r1, %defaultText% 
Gui, Add, Button, w60 h20 gButtonMsAgentTalk, TALK 
return 

;;;;;;;;;;;;;;;;;;;;;;;
;ButtonMsAgentTalk
;;;;;;;;;;;;;;;;;;;;;;;
ButtonMsAgentTalk: 
  Gui, Submit, NoHide 
  agentControl := ComObjCreate("Agent.Control.2")
  agentControl.Connected := true
  
  AgentControl.Characters.Load("Links","C:\WINDOWS\msagent\chars\offcat.acs")
    
  agent := AgentControl.Characters["Links"]
  agent.MoveTo(10, 10)
  agent.Show()
  
  return
myVBS =
(
Dim AgentControl
On Error Resume Next
Set AgentControl = CreateObject("Agent.Control.1")
If IsObject(AgentControl) Then 'it loaded ok
  AgentControl.Connected = True
  Dim myAgent
  On Error Resume Next
  AgentControl.Characters.Load "Peedy", "C:\WINDOWS\msagent\chars\merlin.acs"
  set myAgent= AgentControl.Characters ("Merlin")
  myAgent.Get "state", "Showing"
  myAgent.Get "state", "Speaking"
  myAgent.MoveTo 10, 10
  myAgent.Show
  myAgent.Get "state", "Moving"
  myAgent.MoveTo 257, 177
  myAgent.Speak ("%TXT%")
  myAgent.Hide
End If
 Wscript.Sleep 500
DO
 Wscript.Sleep 250
Loop while myAgent.Visible=TRUE
)

  IfExist, %TEMPFILE% 
     FileDelete, %TEMPFILE% 
  FileAppend, %myVBS%, %TEMPFILE% 
  RunWait, %TEMPFILE% 
  FileDelete, %TEMPFILE% 
Return

;;;;;;;;;;;;;;;;;;;;;;;
;GuiClose
;;;;;;;;;;;;;;;;;;;;;;;
GuiClose: 
ExitApp 