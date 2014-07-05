@setlocal enabledelayedexpansion
@call "%~dp0userenv"

@set mercury_config_dir=mercury
@for %%P in (mercury.bat) do @(
    @set mercury_config_dir=%%~dp$PATH:P
    @set mercury_compiler=!mercury_config_dir!mercury_compile
    @set mercury_config_dir=!mercury_config_dir:\bin\=\lib\mercury!
)

@call mercury --use-grade-subdirs --no-detect-libgrades -s java -m %*
