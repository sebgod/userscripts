@setlocal enabledelayedexpansion enableextensions
@call "%~dp0userenv"

@rem ember that for VIM, we cannot use the UTF-8 codepage
@set newCP=850
@for /F "usebackq tokens=2 delims=:" %%A in (`chcp`) do @(
    set oldCP=%%A
    set oldCP=!oldCP: =!
    set oldCP=!oldCP:.=!
)
@if %oldCP% NEQ %newCP% chcp %newCP% 1>nul

@set VIM_REL_PATH=Vim\vim74\vim.exe
@set VIM_EXE="%ProgramNative%\%VIM_REL_PATH%"
@if not exist %VIM_EXE% set VIM_EXE="%ProgramFiles32%\%VIM_REL_PATH%"
@if not exist %VIM_EXE% set VIM_EXE=vim

@call %VIM_EXE% %*

@rem ember the previous codepage (very important for Windows XP)
@if %oldCP% NEQ %newCP% chcp %oldCP% 1>nul
@exit /b 0
