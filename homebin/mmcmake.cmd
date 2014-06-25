@setlocal enabledelayedexpansion
@if defined MERCURY_HOME (
   call :SET_HOME MMC
) else (
   call :FIND_IN_PATH mercury.bat MMC
)

@if defined MMC goto :MAKE
@echo Cannot find Mercury compiler executable, MERCURY_HOME=%MERCURY_HOME%
@exit /b 1

:MAKE
@make MMC=%MMC% %*
@set MAKE_RESULT=%ERRORLEVEL%
@exit /b %MAKE_RESULT%

:SET_HOME
    @endlocal && ( set %1="%MERCURY_HOME%\bin\mmc" ) && exit /b 0

:FIND_IN_PATH
    @set RESULT=%~dp$PATH:1
    @endlocal && ( set %2=%RESULT%mmc ) && exit /b 0