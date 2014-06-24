@setlocal enabledelayedexpansion
@call "%~dp0userenv"

@set curl_zipfile=curl-%CURL_VERSION%.zip
@set curl_url=http://www.confusedbycode.com/curl/%curl_zipfile%

wget -P%TEMP% -N "%curl_url%"

pushd %~dp0api
7za x -y "%TEMP%\%curl_zipfile%"
popd
