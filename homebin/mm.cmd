@call %~dp0userenv
@call mercury_compile --use-grade-subdirs --no-detect-libgrades -s asm_fast.gc -m %*
