call %~dp0userenv

wget -P%TEMP% -N "%curl_url%"

pushd %~dp0api
7za x -y "%TEMP%\%curl_zipfile%"
popd
