@setlocal enabledelayedexpansion enableextensions
@set ID=%RANDOM%_%RANDOM%
@del /q /f "%TEMP%\_jssc_*.exe"
@jsc /codepage:65001 /nologo /fast+ /out:"%TEMP%\_jssc_%ID%.exe" "%~dpn0.jss" && "%TEMP%\_jssc_%ID%.exe" %*
