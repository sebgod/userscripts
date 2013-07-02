@call "%~dp0userenv"

pushd %TEMP%
wget -N %usbtreeview_url% 
7za -y x %usbtreeview_zipfile%

if "%ProgramFiles64%" == "" (
	pushd Win32
) else (
	pushd x64
)
copy /y %usbtreeview%.exe "%~dp0api"
popd

popd


