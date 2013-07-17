@if not "%ProgramNative%" == "" exit /b 0

@set ProgramFiles32=%ProgramFiles(x86)%
@if "%ProgramFiles32%" == "" (
	@set ProgramFiles64=
	@set ProgramFiles32=%ProgramFiles%
	@set ProgramNative=%ProgramFiles%
) else (
	@set ProgramFiles64=%ProgramW6432%
	@set ProgramNative=%ProgramW6432%
)

@set git_url=http://msysgit.googlecode.com/
@set git_version=PortableGit-1.8.3-preview20130601
@set github_raw_url=https://raw.github.com/

@set sevenzip_standalone=7za
@set sevenzip_version=920
@set sevenzip_zipfile=%sevenzip_standalone%%sevenzip_version%.zip
@set sevenzip_url=http://downloads.sourceforge.net/sevenzip/%sevenzip_zipfile%

@set mono_lib_getline_file=migueldeicaza/muget/master/getline.cs
@set mono_lib_getline_url=%github_raw_url%%mono_lib_getline_file%

@set nirsoft_www=www.nirsoft.net
@set nirsoft_x64_zip=x64tools.zip
@set nirsoft_url=http://%nirsoft_www%/packages/%nirsoft_x64_zip%

@set sysinternals_folder=live.sysinternals.com
@set sysinternals_url=http://%sysinternals_folder%

@set usbtreeview=usbtreeview
@set usbtreeview_zipfile=%usbtreeview%.zip
@set usbtreeview_url=http://www.uwe-sieber.de/files/%usbtreeview_zipfile%

@set svn_cmd=%~dp0api\svn-win32-1.6.16\bin\svn.exe
@set tidy_cmd=%~dp0tidy.exe -config %~dp0netxml.conf
@set tidy_url_zip=tidy.zip
@set tidy_url=http://www.paehl.com/open_source/?download=%tidy_url_zip%

@set cl_cli=%compsec% /E:ON /V:ON /C
@set cl_setenv="%ProgramNative%\Microsoft SDKs\Windows\v7.0\Bin\SetEnv.cmd"

@set gv_dir=%ProgramFiles32%\Graphviz2.30\bin
@set gv_dot="%gv_dir%\dot.exe"

@if not exist %~dp0api mkdir %~dp0api

@path %path%;%~dp0api\git\cmd;%~dp0api\%sysinternals_folder%;%~dp0api
