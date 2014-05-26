@call %~dp0userenv

@setlocal enabledelayedexpansion

@set jcp=
@for %%J in (%mercury_config_dir%\lib\java\*.jar) do @(
    if [!jcp!]==[] (
        set jcp=%%J
    ) else (
        set jcp=!jcp!;%%J
    )
)
@if not [%jcp%] == [] (
   set jcp=--java-classpath %jcp%
)
@call mercury --use-grade-subdirs --no-detect-libgrades -s java %jcp% -m %*
@endlocal
