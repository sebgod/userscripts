@setlocal enabledelayedexpansion enableextensions
@jsc /codepage:65001 /nologo /utf8output /fast+ "%~dpn0.jss" && "%~dpn0" %*
