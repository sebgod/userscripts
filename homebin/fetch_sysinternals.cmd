@setlocal enabledelayedexpansion enableextensions
@call "%~dp0userenv"

@set sysinternals_www=live.sysinternals.com

@pushd %~dp0api
    @wget -nv --exclude-directories=Files,Tools,WindowsInternals -N -m http://%sysinternals_www%

    @for %%E in ("%sysinternals_www%\*.exe") do @call mkhardlink "%%~E" "%%~nxE"
@popd
