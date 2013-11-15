@setlocal enabledelayedexpansion
@set setupExe=Types.Setup.exe
@pushd %temp%
@wget -N http://izt.name/apps/types/%setupExe%
@start %setupExe%
@popd
@endlocal