@if not "%ProgramNative%" == "" exit /b 0

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

@set git_url=http://msysgit.googlecode.com/
@set git_version=PortableGit-1.8.3-preview20130601
@set github_raw_url=https://raw.github.com/

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

@set usbtreeview=usbtreeview
@set usbtreeview_zipfile=%usbtreeview%.zip
@set usbtreeview_url=http://www.uwe-sieber.de/files/%usbtreeview_zipfile%

@set tidy_cmd=%~dp0tidy.exe -config %~dp0netxml.conf
@set tidy_url_zip=tidy.zip
@set tidy_url=http://www.paehl.com/open_source/?download=%tidy_url_zip%

@set cl_cli=%compsec% /E:ON /V:ON /C
@set cl_tooldir=%ProgramFiles32%\Microsoft Visual Studio 11.0\Common7\Tools
@set cl_vsdevcmd="%cl_tooldir%\VsDevCmd"

@set gv_dir=%ProgramFiles32%\Graphviz2.30\bin
@set gv_dot="%gv_dir%\dot.exe"

@set npp_userdefinedlang_src=http://notepad-plus.sourceforge.net/commun/userDefinedLang/
@set mercury_userlangxml=%npp_userdefinedlang_src%userDefineLang_Mercury.xml

@set sagethumbs_version=2.0.0.17
@set sagethumbs_setup=sagethumbs_%sagethumbs_version%_setup.exe
@set sagethumbs_url=http://sagethumbs.googlecode.com/files/%sagethumbs_setup%

@if not exist %~dp0api mkdir %~dp0api

@path %path%;%~dp0api\git\cmd;%~dp0api\%sysinternals_folder%;%svn_basedir%;%~dp0api
@call %cl_vsdevcmd%
