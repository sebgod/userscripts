@setlocal enabledelayedexpansion
@call "%~dp0userenv"

@set nirsoft_pads=pads.zip
@set nirsoft_x64_zip=x64tools.zip
@set nirsoft_x64_url=http://www.nirsoft.net/packages/%nirsoft_x64_zip%
@set nirsoft_pad_url=http://www.nirsoft.net/pad/%nirsoft_pads%

@set target=%~dp0api\live.sysinternals.com
@if not exist "%target%" mkdir "%target%"

@pushd "%TEMP%"
    @call wget -N "%nirsoft_pad_url%"
    @set absPadZip="%cd%\%nirsoft_pads%"
    @if not exist nirsoft_pads mkdir nirsoft_pads
    @pushd nirsoft_pads
        @call 7za x -y %absPadZip%
        :: iterating over the pad.xml files
        :: assumes that the tags and their content are on the same line
        @for %%X in (*.xml) do @(
            @for /F "usebackq tokens=2,3 delims=^<^>" %%A in (%%X) do @(
                if /i "%%A" == "Primary_Download_URL" call wget -N "%%B"
            )
        )
        :: extract each program to the target directory
        @for %%Z in (*.zip) do @(
            call 7za x -o"%target%" -y "%%Z"
            if exist "%target%\readme.txt" (
                move "%target%\readme.txt" "%target%\%%~nZ_readme.txt"
            )
        )
    @popd

    @call wget -N "%nirsoft_x64_url%"
    @if %OS_ARCH_BITNESS% EQU 64 set abs_64zip="%cd%\%nirsoft_x64_zip%"
@popd

:: if we have an x64 system, then overwrite the bitness specific programs
@if defined abs64zip 7za x -o"%target%" -y %abs_64zip%
