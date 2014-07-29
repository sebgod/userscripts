@setlocal enabledelayedexpansion enableextensions
@set sp=%%20
@set file=%~1
@set file=!file: =%sp%!

@set usetype=0
@if [%file%]==[] @(
    mkdir B:\Temp
    pushd B:\Temp
    set file=listing.txt
    if exist !file! del !file!
    set usetype=1
) else (
    pushd %userprofile%\Videos
)

@wget -c "http://sfip1.no-ip.org:27081/%file%"

@if %usetype% equ 1 @(
    type %file%
)

@popd
