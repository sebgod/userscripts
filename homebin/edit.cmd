@setlocal enableextensions enabledelayedexpansion
@set file=%~1
@set pattern=*
@if not defined EDITOR set EDITOR=gvim

@if "%~2" NEQ "" (
    call %EDITOR% -p %*
) else (
    if "%file:%pattern%=%" EQU "%file%" (
        call "%~dp0execute" edit "%~1"
    ) else (
        call %EDITOR% -p "%file%"
    )
)
