@call "%~dp0userenv"

@set INCLUDE_ORIG=%INCLUDE%
@call :FIND_IN_INCLUDE Win32.Mak
@if errorlevel 1 goto :SUCCESS

@set INCLUDE=%INCLUDE_ORIG%%ProgramFiles32%\Microsoft SDKs\Windows\v7.1\Include
@call :FIND_IN_INCLUDE Win32.Mak
@if errorlevel 1 goto :SUCCESS

@set INCLUDE=%INCLUDE_ORIG%%ProgramFiles32%\Microsoft SDKs\Windows\v7.1a\Include
@call :FIND_IN_INCLUDE Win32.Mak
@if errorlevel 1 goto :SUCCESS

@set INCLUDE=%INCLUDE_ORIG%%ProgramFiles32%\Microsoft SDKs\Windows\v7.0\Include
@call :FIND_IN_INCLUDE Win32.Mak
@if errorlevel 1 goto :SUCCESS

:FAIL
@set INCLUDE=%INCLUDE_ORIG%
@set INCLUDE_ORIG=
@exit /b 1

:SUCCESS
@set INCLUDE_ORIG=
@exit /b 0

:FIND_IN_INCLUDE
    @if /I "%~dp$INCLUDE:1" EQU "" (
        exit /b 0
    ) else (
        exit /b 1
    )
