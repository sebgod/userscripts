@call %~dp0userenv

if exist "%ProgramFiles32%\Microsoft SDKs\Windows\v7.1a\Include" (
    set INCLUDE="%INCLUDE%;%ProgramFiles32%\Windows\v7.1a\Include"
)

@exit /b 0
