@echo off

setlocal
set file=%~1
set usetype=0
if [%file%]==[] (
	mkdir B:\Temp
	pushd B:\Temp
	set file=listing.txt
	set usetype=1
) else (
	pushd %userprofile%\Videos
)

wget -N "http://sfip1.no-ip.org:27081/%file%"

if %usetype% equ 1 (
	type %file%
)

popd

endlocal