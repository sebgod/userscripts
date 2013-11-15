@setlocal enabledelayedexpansion
@call :CallPS "%~1" "%~2"

@endlocal

@exit /b 0

::Call powershell
:CallPS
@powershell -Command Start-Process -Verb \"%~1\" -FilePath \"%~2\"
@exit /b 0