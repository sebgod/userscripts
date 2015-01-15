@setlocal enabledelayedexpansion
@call userenv.cmd
@set out="%~dp0api\%~n0.exe"
@set src="%~n0.cs"
@call cscu /target:winexe /out:%out% %src%
@call %out% 1600 900
