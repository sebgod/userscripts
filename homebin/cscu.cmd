@setlocal
@set stdout="%TEMP%\__can_delete_%username%_%RANDOM%.%RANDOM%.%RANDOM%.stdout.txt"
@csc /nologo /utf8output %* >%stdout% 2>&1
@type %stdout%
@del %stdout%
@endlocal