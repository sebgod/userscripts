@call %~dp0userenv

wget -N -P%TEMP% --user-agent=%user_agent% -N %tidy_url%

pushd %TEMP%
7za e -y index.html@download=%tidy_url_zip%
xcopy /y /i tidy.exe %~dp0api
popd
