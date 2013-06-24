if not "%ProgramNative%" == "" ( 
	exit /b 0
)

set ProgramFiles32=%ProgramFiles(x86)%
if "%ProgramFiles32%" == "" (
	set ProgramFiles64=
	set ProgramFiles32=%ProgramFiles%
	set ProgramNative=%ProgramFiles%
) else (
	set ProgramFiles64=%ProgramW6432%
	set ProgramNative=%ProgramW6432%
)

set git_url=http://msysgit.googlecode.com/
set git_version=PortableGit-1.8.3-preview20130601

path %path%;%~dp0api\git\cmd

set svn_cmd=%~dp0api\svn-win32-1.6.16\bin\svn.exe
set tidy_cmd=%~dp0tidy.exe -config %~dp0netxml.conf
set tidy_url_zip=tidy.zip
set tidy_url=http://www.paehl.com/open_source/?download=%tidy_url_zip%

set cl_cli=cmd /E:ON /V:ON /C
set cl_setenv="%ProgramNative%\Microsoft SDKs\Windows\v7.0\Bin\SetEnv.cmd"

set gv_dir=%ProgramFiles32%\Graphviz2.30\bin
set gv_dot="%gv_dir%\dot.exe"

if not exist %~dp0api mkdir %~dp0api
