@setlocal enabledelayedexpansion
@call "%~dp0mercury_dev_env""
@chcp 850

@if defined MERCURY_HOME (
    call :SET_HOME "%MERCURY_HOME%" MERCURY_BIN
) else (
    call :FIND_IN_PATH mercury.bat MERCURY_BIN
)

@if defined MERCURY_BIN goto :EXEC_SHELL
@echo Cannot determine existing Mercury installation for bootstrapping
@echo Env: MERCURY_HOME=%MERCURY_HOME%
@exit /b 1

:EXEC_SHELL
@set PATH=%MERCURY_BIN%;%PATH%
@echo Env: PATH=%PATH%
@sh --login -i
@exit /b 0

:SET_HOME
    @endlocal && (set %2=%~1\bin) && exit /b 0

:FIND_IN_PATH
    @set RESULT=%~dp$PATH:1
    @endlocal && (set %2=%RESULT%) && exit /b 0

