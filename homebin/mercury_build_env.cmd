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
@if not defined MERCURY_GIT set MERCURY_GIT=B:\temp\mercury
@if not defined MERCURY_CC  set MERCURY_CC=gcc
@if not defined MERCURY_LIBGRADES set MERCURY_LIBGRADES=asm_fast.gc,csharp,java,erlang
@set SOURCE=%~dp1
@if "%1" EQU "" (
    set PARAM=-i
) else (
    robocopy %SOURCE% %MERCURY_GIT% /MIR /DCOPY:DAT /SL /NP /NJH /NJS /NFL /NDL 1>nul
    set PARAM="%MERCURY_GIT%\%~nx1"
)
@call sh --login %PARAM%
@exit /b 0

:SET_HOME
    @endlocal && (set %2=%~1\bin) && exit /b 0

:FIND_IN_PATH
    @set RESULT=%~dp$PATH:1
    @endlocal && (set %2=%RESULT%) && exit /b 0

