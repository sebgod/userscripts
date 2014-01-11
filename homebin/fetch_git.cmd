call %~dp0userenv

wget -P%TEMP% -N "%git_url%"

pushd %~dp0api
7za x -y -ogit "%TEMP%\%git_7zipfile%"
popd
