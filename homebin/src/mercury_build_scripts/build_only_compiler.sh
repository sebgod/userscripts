#!/bin/sh
#
pushd $MERCURY_GIT
PARALLEL=-j2
TARGET_DRIVE=c
TARGET_DIR=/mercury/dev-$MERCURY_CC
PREFIX=${TARGET_DRIVE}:${TARGET_DIR}

echo ./configure --with-cc=$MERCURY_CC --prefix=$PREFIX \
    --enable-libgrades=$MERCURY_LIBGRADES \
    --enable-new-mercuryfile-struct

git checkout build &&
git rebase master &&
aclocal -I m4 &&
autoconf &&
./configure --with-cc=$MERCURY_CC --prefix=$PREFIX \
    --enable-libgrades=$MERCURY_LIBGRADES \
    --enable-new-mercuryfile-struct &&
make &&
cp compiler/mercury_compile.exe /$TARGET_DRIVE$TARGET_DIR/bin &&
true

popd # popd $MERCURY_GIT
