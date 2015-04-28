#!/bin/sh
#
pushd $MERCURY_DEV
PARALLEL=-j2
TARGET_DRIVE=c
TARGET_DIR=/mercury/dev-gcc
PREFIX=${TARGET_DRIVE}:${TARGET_DIR}
LIBGRADES=asm_fast.gc
#LIBGRADES+=,java,erlang,csharp

git checkout build &&
git rebase master &&
aclocal -I m4 &&
autoconf &&
./configure --prefix=$PREFIX --enable-libgrades=$LIBGRADES \
    --enable-new-mercuryfile-struct &&
mmake &&
cp compiler/mercury_compile.exe /$TARGET_DRIVE$TARGET_DIR/bin &&
true

popd # popd $MERCURY_DEV
