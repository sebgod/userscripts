call %~dp0userenv

wget -P%TEMP% -N "%git_url%files/%git_version%.7z"

pushd %~dp0api
7z x -y -ogit %TEMP%\%git_version%.7z
popd
