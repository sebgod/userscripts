@setlocal enabledelayedexpansion
@call %~dp0userenv

@set htmlhelp_url=http://go.microsoft.com/fwlink/?LinkId=14188

wget -P%~dp0api -N "%htmlhelp_url%"

pushd %~dp0api
start htmlhelp.exe
popd
