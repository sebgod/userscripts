@setlocal enabledelayedexpansion
@call "%~dp0userenv"

@set htmlhelp_url=http://go.microsoft.com/fwlink/?LinkId=14188

@wget -P"%TEMP%" -N "%htmlhelp_url%"

@call "%TEMP%\htmlhelp.exe"
