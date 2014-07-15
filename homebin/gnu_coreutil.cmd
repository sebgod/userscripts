@setlocal enabledelayedexpansion enableextensions
@call "%~dp0userenv"

@for %%P in ("%GNUWIN32_HOME%\bin") do @(
    if exist "%%~P\%~1.exe" @(
        set GNU_COMP_PATH=%%~P
        goto :CALL_GNU_COMP
    )
)

@echo Cannot find a GNU compatible %~1 2>&1
@exit /b 1

:CALL_GNU_COMP
@set PATH=%GNU_COMP_PATH%;%PATH%
@call %*
