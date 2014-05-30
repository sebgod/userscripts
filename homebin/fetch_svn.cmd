@setlocal enabledelayedexpansion
@call %~dp0userenv

@set svn_url=http://sourceforge.net/projects/svnportable/files/latest/download
@set svn_version=v1.00BETA_(SVN_1.6.15)

wget -P%TEMP% -N "%svn_url%"

pushd %~dp0api
7za x -y "%TEMP%\svnportable_%svn_version%.zip"
popd

