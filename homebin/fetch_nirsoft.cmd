@setlocal enabledelayedexpansion
@call "%~dp0userenv"

@set nirsoft_pads=pads.zip
@set nirsoft_x64_zip=x64tools.zip
@set nirsoft_www=www.nirsoft.net
@set nirsoft_x64_url=http://%nirsoft_www%/packages/%nirsoft_x64_zip%
@set nirsoft_pad_url=http://%nirsoft_www%/pad/%nirsoft_pads%

@set target=%~dp0api\%nirsoft_www%
@if not exist "%target%" mkdir "%target%"

@pushd "%TEMP%"
    @call wget -N "%nirsoft_pad_url%"
    @set abs_pad_zip="%cd%\%nirsoft_pads%"
    @if not exist nirsoft_pads mkdir nirsoft_pads
    @pushd nirsoft_pads
        @call 7za x -y %abs_pad_zip%
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
@if defined abs_64zip 7za x -o"%target%" -y %abs_64zip%

@for %%E in ("%target%\*.exe") do @(
     if exist "%~dp0api\%%~nxE" del "%~dp0api\%%~nxE"
     call mklink /H "%~dp0api\%%~nxE" "%%~E"
)
