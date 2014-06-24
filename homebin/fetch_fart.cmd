@setlocal enabledelayedexpansion
@call "%~dp0userenv"

@set fart_basename=fart
@set fart_version=199b_win%OS_ARCH_BITNESS%
@set fart_url=http://sourceforge.net/projects/fart-it/files/fart-it/1.99b/fart%fart_version%.zip/download
@wget -P%TEMP% -N "%fart_url%"

@pushd %~dp0api
@7za x -y "%TEMP%\fart%fart_version%.zip"
@popd
