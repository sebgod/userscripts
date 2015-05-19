@if defined ProgramNative exit /b 0

:: Use a ramdisk for temp
@set MAYBE_TEMP=b:\%username%\Temp
@if exist "%MAYBE_TEMP%" (
    set TEMP=%MAYBE_TEMP%
    set TMP=%MAYBE_TEMP%
)
@set MAYBE_TEMP=

:: HOME variable is used by various GNU based scripts
@set HOME=%SystemDrive%\Users\%username%
@if not exist "%HOME%" set HOME=%userprofile%

:: This block defines OS bitness invariant path variables
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
    @prompt %USERNAME%@%COMPUTERNAME%:$E[1;35m$M$E[1;34m$P$S$E[1;36m$+$E[0m$_$G
) else (
    @prompt %USERNAME%@%COMPUTERNAME%:$M$P$S$+$_$G
)

:: GNU System variable, this is the standard installation path
:: for GNU Win32 Modules
@set GNUWIN32_HOME=%ProgramFiles32%\gnuwin32

@set CURL_VERSION=7.39.0-win%OS_ARCH_BITNESS%
@set CURL_HOME=%~dp0api\curl-%CURL_VERSION%

:: Variables used for quick doskey-based navigation
@set GITHUB_OWNREPO=https://github.com/sebgod/
@set GITHUB_DOCS=%home%\Documents\GitHub
@set GIT_EDITOR=gvim

:: Home of the mainly used Mercury distribution (usually bootstrapped)
@if not defined MERCURY_HOME set MERCURY_HOME=C:\mercury-dev
@if not exist "%MERCURY_HOME%" set MERCURY_HOME=C:\mercury\dev-gcc
@if not exist "%MERCURY_HOME%" set MERCURY_HOME=
:: Ensure that the ramdisk is used for temporary files if available
@if not defined MERCURY_TMP set MERCURY_TMP=%TEMP%

:: (GNU) Make detection. On Systems with Borland Delphi installed, that will be
:: in the path first, hence we need to detect if we use the proper one,
:: if not delegate the work to the gmake script in this directory
@set MAKE_IS_GNU=0
@if not defined MAKE @set MAKE=make
@for /F "usebackq" %%C in (`%MAKE% -v ^| find /c "GNU" 2^>nul`) do @(
    set MAKE_IS_GNU=%%C
)

@if %MAKE_IS_GNU% EQU 0 @(
    @call Utils
    for /f "usebackq delims=" %%M in (`gmake_path`) do @(
        set MAKE=%%M
        if errorlevel 9009 (set MAKE_IS_GNU=0) else (set MAKE_IS_GNU=1)
    )
)

:: API is for external executables which wrap important WinAPI functions,
:: e.g. sysinternals distribution, or Nirsoft
@path %path%;%~dp0api\git\cmd
@path %path%;%~dp0api\svnportable\SVN
@path %path%;%CURL_HOME%\bin
@path %path%;%~dp0api
:: HACK update this when/if updating Visual Studio.
:: This SHOULD actually use the registry to detect the main VS version
@set MS_VS_HOME=%ProgramFiles32%\Microsoft Visual Studio 11.0
@if not exist "%MS_VS_HOME%" set MS_VS_HOME=

@if defined MS_VS_HOME call "%MS_VS_HOME%\Common7\Tools\VsDevCmd"
@if defined LIB set LIB=%LIB%%AWE_DIR%build\lib
@if defined INCLUDE set INCLUDE=%INCLUDE%%AWE_DIR%include
@path %path%;%AWE_DIR%build\bin

:: add adb toolkit path
@set ADB_HOME=%LOCALAPPDATA%\Android\sdk\tools\lib
@if exist "%ADB_HOME%" path %path%;%ADB_HOME%

:: add native compiled Mercury to path
@if exist "%MERCURY_HOME%\bin\mmc" path %path%;%MERCURY_HOME%\bin

:: Doskey macros
@doskey /MACROFILE="%~dp0macros.txt"
