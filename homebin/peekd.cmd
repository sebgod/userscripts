@set pwd=%cd%
@set driveCurrent=%pwd:~0,1%

@setlocal enabledelayedexpansion
@for /F "usebackq tokens=1,2,3" %%P in (`net use`) do @(
    @set c1=%%P
    @set c2=%%Q
    @set c3=%%R
    
    @if "!c1!" == "OK" (
        @set drive!c2:~0,1!=!c3!
    ) else (
        @if "!c1:~1,2!" == ":" @set drive!c1:~0,1!=!c2!
    )
)

@popd
@if errorlevel 1 @exit /b %errorlevel%
@cd

@if "!drive%driveCurrent%!" == "" (
    @pushd %pwd%
) else (
    @pushd !drive%driveCurrent%!
)

@endlocal