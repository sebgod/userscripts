@setlocal enabledelayedexpansion
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
@set mercury_config_dir=mercury
@for %%P in (mercury.bat) do @(
    @set mercury_config_dir=%%~dp$PATH:P
    @set mercury_compiler=!mercury_config_dir!mercury_compile
    @set mercury_config_dir=!mercury_config_dir:\bin\=\lib\mercury!
)
@call "%mercury_compiler%" --use-grade-subdirs --no-detect-libgrades --sign-assembly mercury.snk -s csharp -m %*
@set result=%ERRORLEVEL%
@if %result% GEQ 1 @(
    if %did_copy_snk% EQU 1 del mercury.snk
)
@if %oldCP% NEQ %newCP% chcp %oldCP% 1>nul
@exit /b %result%
