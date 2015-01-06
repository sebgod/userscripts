@setlocal enabledelayedexpansion
@call "%~dp0userenv"

@set ppmview_url_base=http://dmitrybrant.com/files/
@set ppmview_temp=%TEMP%\ppmview

@wget -N -P"%ppmview_temp%" --user-agent=%user_agent% -N %ppmview_url_base%ppmview.zip

@pushd "%ppmview_temp%"
    @7za e -y ppmview.zip
    @xcopy /y /i ppmview.exe "%~dp0api"
@popd
