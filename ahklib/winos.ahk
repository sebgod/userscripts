#NoEnv
#Warn

Envget,LocalAppData, LOCALAPPDATA

if A_Is64bitOS {
	EnvGet,Prog32, ProgramFiles(x86)
	EnvGet,Prog64, ProgramFiles
} else {
	EnvGet,Prog32, ProgramFiles
}
