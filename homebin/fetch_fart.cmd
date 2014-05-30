@setlocal enabledelayedexpansion
@call %~dp0userenv

@set fart_basename=fart
@set fart_version=199b_win64
@set fart_url=http://sourceforge.net/projects/%fart_basename%-it/files/latest/download

wget -P%TEMP% -N "%fart_url%"

pushd %~dp0api
7za x -y "%TEMP%\%fart_basename%%fart_version%.zip"
popd
