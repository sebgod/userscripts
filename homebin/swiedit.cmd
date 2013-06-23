@echo off

setlocal
set prologFile=%~1
set prologFile=%prologFile:\=/%
if "%~1" == "" (
	echo Please specify a file to edit
) else (
	start swipl-win -g "edit(file('%prologFile%'))."
)
endlocal