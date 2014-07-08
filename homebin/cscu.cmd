@setlocal enabledelayedexpansion
@set stdout="%TEMP%\__can_delete_%username%_%RANDOM%.%RANDOM%.%RANDOM%.stdout.txt"
@csc /nologo /utf8output %* >%stdout% 2>&1
@set csc_result=%ERRORLEVEL%
@type %stdout%
@del %stdout%
@exit /b %csc_result%
