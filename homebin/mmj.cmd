@call userenv

@setlocal enabledelayedexpansion

@set jcp=
@for %%J in (%mercury_config_dir%\lib\java\*.jar) do @(
    if [!jcp!]==[] (
        set jcp=%%J
    ) else (
        set jcp=!jcp!;%%J
    )
)
@call %mercury_compiler% --use-grade-subdirs --no-detect-libgrades -s java --java-classpath %jcp% -m %*
@endlocal