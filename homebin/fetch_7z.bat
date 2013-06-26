call %~dp0userenv

setlocal
pushd %TEMP%
wget -N %sevenzip_url%

call %~dp0unzip "%sevenzip_zipfile%"
set absFilePath=%cd%\%sevenzip_standalone%.exe
popd

pushd %~dp0api
copy /Y %absFilePath% .
popd

endlocal
