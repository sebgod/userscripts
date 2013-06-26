call %~dp0userenv

pushd %~dp0
setlocal

pushd %TEMP%
wget -N %nirsoft_url%
set absZipPath=%cd%\%nirsoft_x64_zip%
popd

if not exist %nirsoft_www% mkdir %nirsoft_www%

pushd %nirsoft_www%
7za x -y %absZipPath%
popd

endlocal
popd