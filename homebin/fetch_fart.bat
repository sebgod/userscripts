call %~dp0userenv

wget -P%TEMP% -N "%fart_url%"

pushd %~dp0api
7za x -y "%TEMP%\%fart_basename%%fart_version%.zip"
popd
