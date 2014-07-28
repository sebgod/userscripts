@setlocal enabledelayedexpansion enableextensions
@call "%~dp0userenv"

@set GNU_COMP_PATH=
@set EXT=
@for %%P in ("%GNUWIN32_HOME%\bin" "%systemdrive%\MinGW\msys\1.0\bin") do @(
    @for %%E in (exe) do @(
        if exist "%%~P\%~1.%%E" @(
            set GNU_COMP_PATH=%%~P
            set EXT=%%E
            goto :CALL_WITH_PATH
        )
    )
)

@echo Cannot find a GNU compatible %~1 2>&1
@exit /b 1

:CALL_WITH_PATH
@set PATH=%GNU_COMP_PATH%;%PATH%
:: This is always the last call (just like exec)
@call %*
