@call boot2docker init
@for /F "usebackq tokens=1,2,* delims== " %%A in (`boot2docker start 2^>^&1`) do @(
    if "%%~A" EQU "set" set %%B=%%C
)
@if %ERRORLEVEL% NEQ 0 exit /b %ERRORLEVEL%

@setlocal enabledelayedexpansion enableextensions
@for %%V in (HOST CERT_PATH TLS_VERIFY) do @(
    @if not defined DOCKER_%%V exit /b 1
    @echo DOCKER_%%V=!DOCKER_%%V!
)
