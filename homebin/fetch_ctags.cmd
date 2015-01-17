@setlocal enabledelayedexpansion
@call "%~dp0userenv"

@set ctags_version=58
@set ctags_url_base=http://prdownloads.sourceforge.net/ctags/

@wget -N -P%TEMP% --user-agent=%user_agent% -N %ctags_url_base%ctags%ctags_version%.zip

@pushd %TEMP%
    @7za x -y ctags%ctags_version%.zip
    xcopy /y /i ctags%ctags_version%\ctags.exe "%~dp0api"
@popd
