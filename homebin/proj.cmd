@setlocal enabledelayedexpansion
@set tmplbase=%~dp0src\templates
@set projtype=%~1
@set command=%~2

@if /i "%projtype%" == "" @(
    echo Please provide a project type
    exit /b 1
)

@if /i "%command%" == "" @(
    echo Please provide a command, e.g.
    echo init, update
    exit /b 2
)

@set tmpldir=%tmplbase%\%projtype%
@if not exist "%tmpldir%" @(
    echo Cannot find templates for "%projtype%" in "%tmpldir%"
    exit /b 3
)

@set mkfile=%tmpldir%\Makefile
@if not exist "%mkfile%" @(
    echo The cannot find makefile "%mkfile%"
    exit /b 4
)

@set CMD_DIR=%~dp0
@set macros= PROJ_TYPE="%projtype%" TMPL_DIR="%tmpldir:\=/%" CMD_DIR="%CMD_DIR:\=/%"
@make -f "%mkfile%" %macros% "%command%"
