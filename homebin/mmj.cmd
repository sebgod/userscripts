@setlocal enabledelayedexpansion
@call "%~dp0userenv"

@set mercury_config_dir=mercury
@for %%P in (mercury.bat) do @(
    @set mercury_config_dir=%%~dp$PATH:P
    @set mercury_compiler=!mercury_config_dir!mercury_compile
    @set mercury_config_dir=!mercury_config_dir:\bin\=\lib\mercury!
)

@set next_ml=0
:check_for_ml
@if "%~1" NEQ "" (
    if !next_ml! EQU 1 (
        echo Library: %~1
    )

    if "%~1" EQU "--ml" (
        set next_ml=1
    ) else (
        if "%~1" EQU "--mercury-library" (
            set next_ml=1
        ) else (
            set next_ml=0
        )
    )

    shift
    goto :check_for_ml
)

@call mercury --target-env-type windows --use-grade-subdirs --no-detect-libgrades -s java -m %*
