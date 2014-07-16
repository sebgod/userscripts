@setlocal enabledelayedexpansion enableextensions
@call "%~dp0userenv"
@call "%~dp0gnu_coreutil" grep --color="%GNUWIN32_COLOR%" -P %*
