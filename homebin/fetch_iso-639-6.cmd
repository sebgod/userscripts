@setlocal enabledelayedexpansion

@for %%L in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do @(
    if not exist %%L.html wget -O %%L.html --post-data selectA4letter=%%L http://www.geolang.com/iso639-6/sortAlpha4.asp
)

@copy /b *.html iso-639-6.ansi
@iconv -f ISO-8859-1 -t UTF-8 iso-639-6.ansi > iso-639-6.utf8

@set /a i=0
@set line=
@for /F "tokens=2,3,4 delims=<>" %%A in (iso-639-6.utf8) do @(
    set /a m=!i! %% 3
    if not [%%C] == [] (
        if "%%B" == "div align="left"" (
            set v=%%C##
            set v=!v: ##=!
            set v=!v:##=!
            if !m! == 0 (
                if [!line!] == [] (
                    set line={
                    if exist iso-639-6.utf16.json del iso-639-6.utf16.json
                ) else (
                    set line=,
                )
                set line=!line! "!v!": { "p":
            ) else if !m! == 1 (
                set line=!line! "!v!", "d":
            ) else if !m! == 2 (
                echo !line! "!v!" }>>iso-639-6.utf16.json
            )
            set /a i+=1
        )
    )
)
@echo }>>iso-639-6.utf16.json
@iconv -f UTF-16LE -t UTF-8 iso-639-6.utf16.json > iso-639-6.json

@endlocal