@setlocal enabledelayedexpansion enableextensions
@set setupExe=Types.Setup.exe
@pushd %temp%
    @call wget -N http://izt.name/apps/types/%setupExe%
@start %setupExe%
@popd
