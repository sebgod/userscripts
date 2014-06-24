@setlocal enabledelayedexpansion
@call "%~dp0userenv"

@set mercury_config_dir=mercury
@for %%P in (mercury.bat) do @(
    @set mercury_config_dir=%%~dp$PATH:P
    @set mercury_compiler=!mercury_config_dir!mercury_compile
    @set mercury_config_dir=!mercury_config_dir:\bin\=\lib\mercury!
)
@set jcp=
@for %%J in (%mercury_config_dir%\lib\java\*.jar) do @(
    if [!jcp!]==[] (
        set jcp=%%J
    ) else (
        set jcp=!jcp!;%%J
    )
)

@if defined %jcp% (
   @set jcp=--java-classpath %jcp%
)

@call "%mercury_compiler%" --use-grade-subdirs --no-detect-libgrades -s java %jcp% -m %*
