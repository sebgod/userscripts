:: vim: ft=dosbatch ff=unix sw=4 ts=4 tw=78 et
@setlocal enabledelayedexpansion
@call "%~dp0mercury_dev_env""
@chcp 850

@if defined MERCURY_HOME (
    call :SET_HOME "%MERCURY_HOME%" MERCURY_BIN
) else (
    call :FIND_IN_PATH mercury.bat MERCURY_BIN
)

@if defined MERCURY_BIN goto :EXEC_SHELL
@echo Cannot determine existing Mercury installation for bootstrapping 1>&2
@echo Env: MERCURY_HOME=%MERCURY_HOME% 1>&2
@exit /b 1

:EXEC_SHELL
    @set PATH=%MERCURY_BIN%;%PATH%
    @if not defined MERCURY_CC set MERCURY_CC=gcc
    @for /F "usebackq delims=" %%C in (`basename "%MERCURY_CC%"`) do @(
        set CC_NO_BLANKS=%%C
    )
    @set CC_NO_BLANKS=%CC_NO_BLANKS: =%
    @set CC_NO_BLANKS=%CC_NO_BLANKS::=%
    @if not defined MERCURY_GIT for %%T in ("%TEMP%") do @(
        set MERCURY_GIT=%%~dT/Temp/mercury-%CC_NO_BLANKS%%MERCURY_SUFFIX%
    )
    @if not defined MERCURY_LIBGRADES set MERCURY_LIBGRADES=asm_fast.gc,csharp,java,erlang
    @if not defined MERCURY_COPYMODE set MERCURY_COPYMODE=/MIR
    @set SOURCE=%~dp1
    @if "%1" EQU "" (
        @echo sh --login -i
        @call sh --login -i
    ) else (
        robocopy %SOURCE% %MERCURY_GIT% %MERCURY_COPYMODE% /DCOPY:DAT /SL /NP /NJH /NJS /NFL /NDL
        @echo sh --login "%MERCURY_GIT%\%~nx1" %*
        @call sh --login "%MERCURY_GIT%\%~nx1" %*
    )
    @exit /b 0

:SET_HOME
    @endlocal && (set %2=%~1\bin) && exit /b 0

:FIND_IN_PATH
    @set RESULT=%~dp$PATH:1
    @endlocal && (set %2=%RESULT%) && exit /b 0

