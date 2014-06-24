@call "%~dp0userenv"
@pushd %MERCURY_HOME%\lib\mercury\lib\csharp
@for %%F in (*.dll) do @(
    gacutil /i "%%F"
)
@popd
