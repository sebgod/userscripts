@setlocal
@set stdout="%TEMP%\__can_delete_%RANDOM%.%RANDOM%.%RANDOM%.stdout.txt"
@csc /nologo /utf8output %* >%stdout%
@type %stdout%
@endlocal