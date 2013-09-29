call %~dp0userenv

pushd %~dp0
setlocal enabledelayedexpansion

pushd %TEMP%
wget -N %nirsoft_url%
set absZipPath=%cd%\%nirsoft_x64_zip%
popd

set target=api\%nirsoft_www%
if not exist %target% mkdir %target%

pushd %target%
7za x -y %absZipPath%
popd

endlocal
popd