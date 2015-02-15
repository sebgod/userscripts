'A VBScript that loads an MSAgent Character on the screen
' and make it say the current time and date

'Compiled by Pramod S Nair
'http://www.wisdombay.com
'Written  10:52 PM 14-03-2006

'''''''''''''''''''''''''''''''''''''''''''

'Create an MSAgent Object
Set objAgent = CreateObject("Agent.Control.2")

objAgent.Connected = true
objAgent.Characters.Load "Links", "offcat.acs"

'generate a character object for the agent object
Set objChar = objAgent.Characters.Character("Links")

objChar.Left = 1400
objChar.Top  = 780
'Show the Agent
objChar.Show
objChar.Play "Greeting"
objChar.Play "DeepIdleA"
 ' objChar.Speak "The time is now " & time()
 ' objChar.Play "Idle3_1"
 ' objChar.Speak "Yup, it's now time to go home."
 ' objChar.MoveTo 800, 600
 ' objChar.Play "Idle3_1"
 ' objChar.Play "Wave"
 ' objChar.Speak "Goodbye! "
 
 do while objChar.Visible = true
    wscript.sleep 1000
loop
