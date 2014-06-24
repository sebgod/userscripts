@setlocal enabledelayedexpansion
@call "%~dp0userenv"

@set tidy_url_zip=tidy.zip
@set tidy_url=http://www.paehl.com/open_source/?download=%tidy_url_zip%


wget -N -P%TEMP% --user-agent=%user_agent% -N %tidy_url%

pushd %TEMP%
7za e -y index.html@download=%tidy_url_zip%
xcopy /y /i tidy.exe %~dp0api
popd
