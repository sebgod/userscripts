@setlocal enabledelayedexpansion
@set inputFile=%~1
@if not defined inputFile exit /b 1
@if not exist "%inputFile%" exit /b 2
@copy /y "%~dp0\empty_utf16le_bom.txt" "%inputFile%.utf16" 1>nul 2>nul
@iconv -f utf-8 -t utf-16le <"%inputFile%" >>"%inputFile%.utf16"
@type "%inputFile%.utf16"
@del "%inputFile%.utf16"
@exit /b 0