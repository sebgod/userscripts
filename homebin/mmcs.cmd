@setlocal enabledelayedexpansion

:: For the C# compiler, we MUST NOT use the UTF-8 codepage
@set newCP=850
@for /F "usebackq tokens=2 delims=:" %%A in (`chcp`) do @(
    set oldCP=%%A
    set oldCP=!oldCP: =!
    set oldCP=!oldCP:.=!
)
@if %oldCP% NEQ %newCP% chcp %newCP% 1>nul

@call "%~dp0userenv"

@set mdev=%HOME%\Documents\GitHub\mercury
@set did_copy_snk=0
@if /i "%cd%" NEQ "%mdev%" @(
    if not exist mercury.snk (
        mklink /H mercury.snk "%mdev%\mercury.snk" 1>nul 2>nul
        if errorlevel 1 copy "%mdev%\mercury.snk" . 1>nul 2>nul
        set did_copy_snk=1
    )
)

@call mercury --use-grade-subdirs --no-detect-libgrades --sign-assembly mercury.snk -s csharp -m %*
@set result=%ERRORLEVEL%
@if %result% GEQ 1 @(
    if %did_copy_snk% EQU 1 del mercury.snk
)

:: Restoring the previous codepage
@if %oldCP% NEQ %newCP% chcp %oldCP% 1>nul
@exit /b %result%
