@setlocal enabledelayedexpansion
@if defined MERCURY_HOME (
   call :SET_HOME MMC
) else (
   call :FIND_IN_PATH mercury.bat MMC MERCRUY_HOME
)

@if defined MMC goto :MAKE
@echo Cannot find Mercury compiler executable, MERCURY_HOME=%MERCURY_HOME%
@exit /b 1

:MAKE
    make MMC=%MMC% MERCURY_HOME=%MERCURY_HOME% %*
    @set MAKE_RESULT=%ERRORLEVEL%
    @exit /b %MAKE_RESULT%

:SET_HOME
    @setlocal enabledelayedexpansion
    @endlocal && ( set %1="%MERCURY_HOME%\bin\mmc" ) && exit /b 0

:FIND_IN_PATH
    @setlocal enabledelayedexpansion
    @set RESULT=%~dp$PATH:1
    @set STRIP=%RESULT%~~~
    @set HOME=%STRIP:bin~~~=%
    @endlocal && ( set %2=%RESULT%mmc ) && ( set %3=%HOME% ) && exit /b 0
