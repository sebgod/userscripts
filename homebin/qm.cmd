@setlocal enabledelayedexpansion enableextensions
@call pgrepc -n -r --include="*.m" "%~1" .
