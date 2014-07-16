@setlocal enabledelayedexpansion
@call "%~dp0userenv"

@set sysinternals_www=live.sysinternals.com

@pushd %~dp0api
@wget --exclude-directories=Files,Tools,WindowsInternals -N -m http://%sysinternals_www%
@popd

@for %%E in ("%~dp0api\%sysinternals_www%\*.exe") do @(
     if exist "%~dp0api\%%~nxE" del "%~dp0api\%%~nxE"
     call mklink /H "%~dp0api\%%~nxE" "%%~E"
)
