@if not "%ProgramNative%" == "" exit /b 0

@prompt $E[4;32m%USERNAME%@%COMPUTERNAME%$E[0m:$E[1;35m$M$E[1;34m$P$E[0m$G
@set HOME=%userprofile%

@set ProgramFiles32=%ProgramFiles(x86)%
@if "%ProgramFiles32%" == "" (
    @set ProgramFiles64=
    @set ProgramFiles32=%ProgramFiles%
    @set ProgramNative=%ProgramFiles%
    @set OS_ARCH_BITNESS=32
) else (
    @set ProgramFiles64=%ProgramW6432%
    @set ProgramNative=%ProgramW6432%
    @set OS_ARCH_BITNESS=64
)

@set curl_version=7.34.0-win%OS_ARCH_BITNESS%
@set curl_zipfile=curl-%curl_version%.zip
@set curl_basedir=%~dp0api\curl-%curl_version%
@set curl_url=http://www.confusedbycode.com/curl/%curl_zipfile%

@set git_basename=PortableGit
@set git_version=1.8.4-preview20130916
@set git_7zipfile=%git_basename%-%git_version%.7z
@set git_url=http://msysgit.googlecode.com/files/%git_7zipfile%

@set github_raw_url=https://raw.github.com/
@set github_ownrepo=https://github.com/sebgod/

@set svn_basename=svnportable
@set svn_url=http://sourceforge.net/projects/%svn_basename%/files/latest/download
@set svn_version=v1.00BETA_(SVN_1.6.15)
@set svn_basedir=%~dp0api\%svn_basename%\SVN
@set svn_cmd=%svn_basedir%\svn.exe

@set sevenzip_standalone=7za
@set sevenzip_version=920
@set sevenzip_zipfile=%sevenzip_standalone%%sevenzip_version%.zip
@set sevenzip_url=http://downloads.sourceforge.net/sevenzip/%sevenzip_zipfile%

@set fart_basename=fart
@set fart_version=199b_win64
@set fart_url=http://sourceforge.net/projects/%fart_basename%-it/files/latest/download

@set mono_lib_getline_file=migueldeicaza/muget/master/getline.cs
@set mono_lib_getline_url=%github_raw_url%%mono_lib_getline_file%

:: maybe use http://launcher.nirsoft.net/download.html
@set nirsoft_www=www.nirsoft.net
@set nirsoft_x64_zip=x64tools.zip
@set nirsoft_url=http://%nirsoft_www%/packages/%nirsoft_x64_zip%

@set sysinternals_folder=live.sysinternals.com
@set sysinternals_url=http://%sysinternals_folder%

@set usbtreeview_zipfile=usbtreeview.zip
@set usbtreeview_url=http://www.uwe-sieber.de/files/%usbtreeview_zipfile%

@set tidy_cmd=%~dp0api\tidy.exe -config %~dp0netxml.conf
@set tidy_url_zip=tidy.zip
@set tidy_url=http://www.paehl.com/open_source/?download=%tidy_url_zip%

@set cl_cli=%compsec% /E:ON /V:ON /C
@set cl_tooldir=%ProgramFiles32%\Microsoft Visual Studio 11.0\Common7\Tools
@set cl_vsdevcmd="%cl_tooldir%\VsDevCmd"

@set gv_version=2.37
@set gv_dir=%ProgramFiles32%\Graphviz%gv_version%\bin
@set gv_dot="%gv_dir%\dot.exe"

@set npp_userdefinedlang_src=http://notepad-plus.sourceforge.net/commun/userDefinedLang/
@set mercury_userlangxml=%npp_userdefinedlang_src%userDefineLang_Mercury.xml
@set MERCURY_HOME=C:/mercury-14.01-mingw
@set MERCURY_CONFIG_DIR=%MERCURY_HOME%/lib/mercury
@set MERCURY_COMPILER=%MERCURY_HOME%/bin/mercury_compile

@set sagethumbs_version=2.0.0.17
@set sagethumbs_setup=sagethumbs_%sagethumbs_version%_setup.exe
@set sagethumbs_url=http://sagethumbs.googlecode.com/files/%sagethumbs_setup%

@set unicodeconsole_proj=UnicodeConsole
@set unicodeconsole_url=%github_ownrepo%%unicodeconsole_proj%/archive/master.zip

@set unicode_www=www.unicode.org
@set unicode_version=6.3.0
@set unicode_url=http://%unicode_www%/Public/zipped/%unicode_version%/
@set unicode_reports=http://%unicode_www%/reports/

@set jq_url=http://stedolan.github.io/jq/download/win%OS_ARCH_BITNESS%/jq.exe

@set iso-639-6_www=www.geolang.com
@set iso-639-6_url=http://%iso-639-6_www%/iso639-6

@if not exist %~dp0api mkdir %~dp0api

@path %path%;%~dp0api\git\cmd;%MERCURY_HOME%\bin;%~dp0api\%sysinternals_folder%;%svn_basedir%;%curl_basedir%\bin;%~dp0api
@call %cl_vsdevcmd%
@doskey /MACROFILE=%~dp0macros.txt
