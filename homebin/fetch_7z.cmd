@setlocal enabledelayedexpansion enableexpansion
@call "%~dp0userenv"

@set sevenzip_version=920
@set sevenzip_zipfile=7za%sevenzip_version%.zip
@set sevenzip_url=http://downloads.sourceforge.net/sevenzip/%sevenzip_zipfile%

@pushd "%TEMP%"
    @wget -N %sevenzip_url%

    @call "%~dp0api\7za" >nul 2>&1
    @set unzip_cmd="%~dp0api\7za" x -y
    @if errorlevel 8080 @set unzip_cmd="%~dp0unzip"
    @call %unzip_cmd% "%sevenzip_zipfile%"
    @set absFilePath=%cd%\7za.exe
@popd

@pushd %~dp0api
    @xcopy /Y %absFilePath% .
@popd
