@setlocal enabledelayedexpansion
@call "%~dp0userenv"

@set git_basename=PortableGit
@set git_version=1.9.5-preview20150319
@set git_7zipfile=%git_basename%-%git_version%.7z
@set git_url=https://github.com/msysgit/msysgit/releases/download/Git-%git_version%/%git_7zipfile%
curl -k -L -o %TEMP%\%git_7zipfile% "%git_url%"

pushd %~dp0api
7za x -y -ogit "%TEMP%\%git_7zipfile%"
popd
