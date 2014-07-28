@if defined ProgramNative exit /b 0

:: HOME variable is used by various GNU based scripts
@set HOME=%SystemDrive%\Users\%username%
@if not exist "%HOME%" set HOME=%userprofile%

:: This block defines OS Bitness invariant path variables
:: And the OS_ARCH_BITNESS variable with the bitness of the
:: executing OS
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

:: ANSI Colour detection
@set GNUWIN32_COLOR=no
@if defined ConEmuANSI @if /i "%ConEmuANSI%" EQU "ON" set GNUWIN32_COLOR=always

@if /i "%GNUWIN32_COLOR%" NEQ "no" (
    @prompt $E[4;32m%USERNAME%@%COMPUTERNAME%$E[0m:$E[1;35m$M$E[1;34m$P$E[0m$_$G
) else (
    @prompt %USERNAME%@%COMPUTERNAME%:$M$P$_$G
)

:: GNU System variable, this is the standard installation path
:: for GNU Win32 Modules
@set GNUWIN32_HOME=%ProgramFiles32%\gnuwin32

@set CURL_VERSION=7.34.0-win%OS_ARCH_BITNESS%
@set CURL_HOME=%~dp0api\curl-%CURL_VERSION%

:: Variables used for quick doskey-based navigation
@set GITHUB_OWNREPO=https://github.com/sebgod/
@set GITHUB_DOCS=%home%\Documents\GitHub

:: Home of the mainly used Mercury distribution (usually bootstrapped)
@set MERCURY_HOME=C:\mercury-dev
@if not exist "%MERCURY_HOME%" (
    set MERCURY_HOME=
)

:: (GNU) Make detection. On Systems with Borland Delphi installed, that will be
:: in the path first, hence we need to detect if we use the proper one,
:: if not delegate the work to the gmake script in this directory
@set MAKE_IS_GNU=0
@if not defined MAKE @set MAKE=make
@for /F "usebackq" %%C in (`%MAKE% -v ^| find /c "GNU" 2^>nul`) do @(
    set MAKE_IS_GNU=%%C
)

@if %MAKE_IS_GNU% EQU 0 @set MAKE=gmake

:: API is for external executables which wrap important WinAPI functions,
:: e.g. sysinternals distribution, or Nirsoft
@path %path%;%~dp0api\git\cmd
@path %path%;%~dp0api\svnportable\SVN
@path %path%;%CURL_HOME%\bin
@path %path%;%~dp0api
:: HACK pdate this when/if updating Visual Studio.
:: This SHOULD actually use the registry to detect the main VS version
@set MS_VS_HOME=%ProgramFiles32%\Microsoft Visual Studio 11.0
@if not exist "%MS_VS_HOME%" (
    set MS_VS_HOME=
)
@if defined MS_VS_HOME call "%MS_VS_HOME%\Common7\Tools\VsDevCmd"
@if defined MERCURY_HOME path %path%;%MERCURY_HOME%\bin
@doskey /MACROFILE="%~dp0macros.txt"
