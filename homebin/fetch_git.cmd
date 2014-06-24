@setlocal enabledelayedexpansion
@call "%~dp0userenv"

@set git_basename=PortableGit
@set git_version=1.8.4-preview20130916
@set git_7zipfile=%git_basename%-%git_version%.7z
@set git_url=http://msysgit.googlecode.com/files/%git_7zipfile%

wget -P%TEMP% -N "%git_url%"

pushd %~dp0api
7za x -y -ogit "%TEMP%\%git_7zipfile%"
popd
