@setlocal enabledelayedexpansion
@call "%~dp0userenv"

:: maybe use http://launcher.nirsoft.net/download.html
@set nirsoft_www=www.nirsoft.net
@set nirsoft_x64_zip=x64tools.zip
@set nirsoft_url=http://%nirsoft_www%/packages/%nirsoft_x64_zip%

pushd %~dp0

pushd %TEMP%
wget -N %nirsoft_url%
set absZipPath=%cd%\%nirsoft_x64_zip%
popd

set target=api\%nirsoft_www%
if not exist %target% mkdir %target%

pushd %target%
7za x -y %absZipPath%
popd

popd
