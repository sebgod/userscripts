@call %~dp0userenv

@if [%~1] == [] (
    @echo Please specify a wildcard for the files 
    @echo Warning: recursion is on by default
) else (
    fart -c -r -C "%~1" "\t" "    "
)