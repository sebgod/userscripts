'
' UnZip a file script
'

' Dim ArgObj, var1, var2
Set ArgObj = WScript.Arguments
 
strFileZIP = ArgObj(0)

'The location of the zip file.
REM Set WshShell = CreateObject("Wscript.Shell")
REM CurDir = WshShell.ExpandEnvironmentStrings("%cd%")
Dim sCurPath
sCurPath = CreateObject("Scripting.FileSystemObject").GetAbsolutePathName(".")
strZipFile = sCurPath & "\" & strFileZIP
'The folder the contents should be extracted to.
outFolder = sCurPath & "\"

Set objShell = CreateObject( "Shell.Application" )
Set objSource = objShell.NameSpace(strZipFile).Items()
Set objTarget = objShell.NameSpace(outFolder)
objTarget.CopyHere objSource, &H214&
