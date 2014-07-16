@setlocal enabledelayedexpansion
@if "%~1" EQU "" (
    echo Please specify a target argument 2>&1
    exit /b 1
)
@if "%~2" EQU "" (
    echo Please specify a source argument 2>&1
    exit /b 2
)

@call "%~dp0userenv"

@if exist "%~2" del "%~2"

@mklink 2>nul
@if errorlevel 8008 @(
    call "%~dp0gnu_coreutil" ln -T %1 %2
) else (
    call mklink /H "%~2" "%~1"
)
