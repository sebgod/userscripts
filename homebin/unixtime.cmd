@setlocal enabledelayedexpansion enableextensions
@jsc /codepage:65001 /nologo /fast+ /out:"%~dpn0.exe" "%~dpn0.jss" && "%~dpn0.exe" %*
