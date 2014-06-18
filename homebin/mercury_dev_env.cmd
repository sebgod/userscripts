@call %~dp0userenv

@set INCLUDE_ORIG=%INCLUDE%
@call :FIND_IN_INCLUDE Win32.Mak
@if errorlevel 1 ( exit /b 0 )

@set INCLUDE=%INCLUDE_ORIG%%ProgramFiles32%\Microsoft SDKs\Windows\v7.0\Include
@call :FIND_IN_INCLUDE Win32.Mak
@if errorlevel 1 ( exit /b 0 )

@set INCLUDE=%INCLUDE_ORIG%%ProgramFiles32%\Microsoft SDKs\Windows\v7.1\Include
@call :FIND_IN_INCLUDE Win32.Mak
@if errorlevel 1 ( exit /b 0 )

@set INCLUDE=%INCLUDE_ORIG%%ProgramFiles32%\Microsoft SDKs\Windows\v7.1a\Include
@call :FIND_IN_INCLUDE Win32.Mak
@if errorlevel 1 ( exit /b 0 )

@exit /b 1

:FIND_IN_INCLUDE
    @if /I "%~dp$INCLUDE:1" EQU "" (
        exit /b 0
    ) else (
        exit /b 1
    )
