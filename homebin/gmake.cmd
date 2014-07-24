@setlocal enabledelayedexpansion enableextensions
@set make_is_gnu=0
@for /F "usebackq" %%C in (`make -v ^| find /c "GNU" 2^>nul`) do @(
    set make_is_gnu=%%C
)

@if %make_is_gnu% EQU 0 (
    call "%~dp0gnu_coreutil" make %*
) else (
    make %*
)
