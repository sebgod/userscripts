@setlocal enabledelayedexpansion enableextensions
@jsc /t:library /codepage:65001 /nologo /fast+ /out:"%~dpn0.dll" "%~dpn0.jss"
