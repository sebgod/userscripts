@setlocal enabledelayedexpansion enableextensions
@jsc /codepage:65001 /nologo /utf8output /fast+ /out:"%TEMP%\_jssc.exe" "%~dpn0.jss" && "%TEMP%\_jssc.exe" %*
@set res=%ERRORLEVEL%
@del /q "%TEMP%\_jssc.exe"
@exit /b %res%