pushd %~dp0
setlocal

set nirsoft_www=www.nirsoft.net
set x64tool=x64tools.zip
pushd ..\Downloads\Essentials
wget -N http://%nirsoft_www%/packages/%x64tool%
set absZipPath=%cd%\%x64tool%
popd

if not exist %nirsoft_www% mkdir %nirsoft_www%

pushd %nirsoft_www%
7z x -y %absZipPath%
popd

endlocal
popd