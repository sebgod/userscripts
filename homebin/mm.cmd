@call "%~dp0userenv"
@call mercury --use-grade-subdirs --no-detect-libgrades -s asm_fast.gc -m %*
