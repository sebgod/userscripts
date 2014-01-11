call %~dp0userenv

wget -P%TEMP% -N "%svn_url%"

pushd %~dp0api
7za x -y "%TEMP%\%svn_basename%_%svn_version%.zip"
popd

