@setlocal enabledelayedexpansion
@if not defined MERCURY_COPYMODE set MERCURY_COPYMODE=/S /E
@call mercury_build_env "%~dp0build_only_compiler.sh"
