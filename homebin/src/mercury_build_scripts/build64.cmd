@setlocal enabledelayedexpansion
@set PATH=C:\MinGW\gcc-5-win64\bin;%PATH%
@set MERCURY_LIBGRADES=asm_fast.gc
@set MERCURY_SUFFIX=-m64
@call mercury_build_env "%~dp0build.sh" --host=x86_64-w64-mingw32
