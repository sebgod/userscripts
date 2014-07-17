@setlocal enabledelayedexpansion
@call "%~dp0userenv"

@set tidy_url_base=http://www.paehl.com/open_source/?download=

@wget -N -P%TEMP% --user-agent=%user_agent% -N %tidy_url_base%tidy.zip
@wget -N -P%TEMP% --user-agent=%user_agent% -N %tidy_url_base%tidy2.7z

@pushd %TEMP%
    @7za e -y index.html@download=tidy.zip
    @7za e -y index.html@download=tidy2.7z
    @xcopy /y /i tidy.exe "%~dp0api"
    @copy /y tidy.exe "%~dp0api\tidy2.exe"
@popd
