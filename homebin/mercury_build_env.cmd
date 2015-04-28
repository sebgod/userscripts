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
@set MERCURY_DEV=B:\temp\mercury
@set SOURCE=%~dp1
@robocopy %SOURCE% %MERCURY_DEV% /MIR /DCOPY:DAT /SL /NP /NJH /NJS /NFL /NDL
@if "%1" EQU "" (
    set PARAM=-i
) else (
    set PARAM="%MERCURY_DEV%\%~nx1"
)
@call sh --login %PARAM%
@exit /b 0

:SET_HOME
    @endlocal && (set %2=%~1\bin) && exit /b 0

:FIND_IN_PATH
    @set RESULT=%~dp$PATH:1
    @endlocal && (set %2=%RESULT%) && exit /b 0

