@setlocal enabledelayedexpansion
@call %~dp0userenv

@set iso-639-6_www=www.geolang.com
@set iso-639-6_url=http://%iso-639-6_www%/iso639-6
@set isoName=iso-639-6
@set targetDir=%~dp0data\%isoName%
@set tempDir=%temp%\%isoName%
@if not exist "%tempDir%" mkdir "%tempDir%"
@if not exist "%targetDir%" mkdir "%targetDir%" 

@pushd %tempDir%
@for %%L in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do @(
    if not exist %%L.html wget -O %%L.html --post-data selectA4letter=%%L %iso-639-6_url%/sortAlpha4.asp
)

@copy /b *.html %isoName%.ansi
@iconv -f ISO-8859-1 -t UTF-8 %isoName%.ansi >%isoName%.utf8

@set /a i=0
@set line=
@for /F "tokens=2,3,4 delims=<>" %%A in (%isoName%.utf8) do @(
    set /a m=!i! %% 3
    if not [%%C] == [] (
        if "%%B" == "div align="left"" (
            set v=%%C##
            set v=!v: ##=!
            set v=!v:##=!
            if !m! == 0 (
                if [!line!] == [] (
                    set line={
                    if exist %isoName%.utf16.json del %isoName%.utf16.json
                ) else (
                    set line=,
                )
                set line=!line! "!v!": { "p":
            ) else if !m! == 1 (
                set line=!line! "!v!", "d":
            ) else if !m! == 2 (
                echo !line! "!v!" }>>%isoName%.utf16.json
            )
            set /a i+=1
        )
    )
)
@echo }>>%isoName%.utf16.json
@iconv -f UTF-16LE -t UTF-8 %isoName%.utf16.json >"%targetDir%\%isoName%.json"

@rem popd %tempDir%
@popd
@endlocal
