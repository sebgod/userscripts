@setlocal enabledelayedexpansion
@set newCP=850
@for /F "usebackq tokens=2 delims=:" %%A in (`chcp`) do @(
    set oldCP=%%A
    set oldCP=!oldCP: =!
)
@if %oldCP% NEQ %newCP% chcp %newCP% 1>nul
@call %~dp0userenv
@set keyfile="%userprofile%\Documents\GitHub\mercury\mercury.snk"
@call mercury --use-grade-subdirs --no-detect-libgrades --sign-assembly %keyfile% -s csharp -m %*
@set result=%ERRORLEVEL%
@if %oldCP% NEQ %newCP% chcp %oldCP% 1>nul
@exit /b %result%
