@if defined ProgramNative exit /b 0

@set HOME=%userprofile%

@set ProgramFiles32=%ProgramFiles(x86)%
@if defined ProgramFiles32 (
    @set ProgramFiles64=%ProgramW6432%
    @set ProgramNative=%ProgramW6432%
    @set OS_ARCH_BITNESS=64
) else (
    @set ProgramFiles64=
    @set ProgramFiles32=%ProgramFiles%
    @set ProgramNative=%ProgramFiles%
    @set OS_ARCH_BITNESS=32
)

@set GNUWIN32_COLOR=no
@if defined ConEmuANSI @if /i "%ConEmuANSI%" EQU "ON" set GNUWIN32_COLOR=always

@if /i "%GNUWIN32_COLOR%" NEQ "no" (
    @prompt $E[4;32m%USERNAME%@%COMPUTERNAME%$E[0m:$E[1;35m$M$E[1;34m$P$E[0m$_$G
) else (
    @prompt %USERNAME%@%COMPUTERNAME%:$M$P$_$G
)

@set GNUWIN32_HOME=%ProgramFiles32%\gnuwin32

@set CURL_VERSION=7.34.0-win%OS_ARCH_BITNESS%
@set CURL_HOME=%~dp0api\curl-%CURL_VERSION%

@set GITHUB_OWNREPO=https://github.com/sebgod/

@set MERCURY_HOME=C:\mercury-dev
@if not exist "%MERCURY_HOME%" (
    set MERCURY_HOME=
)

@if not exist "%~dp0api" mkdir "%~dp0api"

@path %path%;%~dp0api\git\cmd
@path %path%;%~dp0api\svnportable\SVN
@path %path%;%~dp0api\live.sysinternals.com
@path %path%;%CURL_HOME%\bin
@path %path%;%~dp0api
@set MS_VS_HOME=%ProgramFiles32%\Microsoft Visual Studio 11.0
@if not exist "%MS_VS_HOME%" (
    set MS_VS_HOME=
)
@if defined MS_VS_HOME call "%MS_VS_HOME%\Common7\Tools\VsDevCmd"
@if defined MERCURY_HOME path %path%;%MERCURY_HOME%\bin
@doskey /MACROFILE="%~dp0macros.txt"
