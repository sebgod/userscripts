@setlocal enabledelayedexpansion
@call "%~dp0userenv"

@set sysinternals_url=http://live.sysinternals.com

@pushd %~dp0api
@wget --exclude-directories=Files,Tools,WindowsInternals -N -m %sysinternals_url%
@popd
