@setlocal enabledelayedexpansion
@call :FIND_IN_PATH mtags MTAGS_PERLSCRIPT
@call perl -s %MTAGS_PERLSCRIPT% %*

@exit /b 0

:FIND_IN_PATH
    @set RESULT=%~f$PATH:1
    @endlocal && ( set %2=%RESULT% ) && exit /b 0
