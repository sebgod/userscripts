call %~dp0userenv

wget -N -P%TEMP% --user-agent=%user_agent% -N %tidy_url%

pushd %~dp0
7z e -y %TEMP%\index.html@download=%tidy_url_zip%
popd