@setlocal enabledelayedexpansion
@call %~dp0userenv

@set sevenzip_standalone=7za
@set sevenzip_version=920
@set sevenzip_zipfile=%sevenzip_standalone%%sevenzip_version%.zip
@set sevenzip_url=http://downloads.sourceforge.net/sevenzip/%sevenzip_zipfile%

pushd %TEMP%
wget -N %sevenzip_url%

call %~dp0unzip "%sevenzip_zipfile%"
set absFilePath=%cd%\%sevenzip_standalone%.exe
popd

pushd %~dp0api
copy /Y %absFilePath% .
popd
