@setlocal enabledelayedexpansion
@set tmplbase=%~dp0src\templates
@set tmpldir=%tmplbase%\%~1
@if not exist "%tmpldir%" @(
    echo Cannot find templates for "%~1" in "%tmpldir%"
    exit /b 1
)
