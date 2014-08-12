@setlocal enabledelayedexpansion enableextensions
@jsc /codepage:65001 /nologo /fast+ "%~dpn0.jss" && "%~dpn0" %*
