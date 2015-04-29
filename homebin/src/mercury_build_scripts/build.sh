#!/bin/sh
#
pushd $MERCURY_GIT
PARALLEL=-j2
PREFIX=c:/mercury/dev-$MERCURY_CC

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
touch Mmake.params &&
touch Mercury.options &&
mmake depend &&
mmake MMAKEFLAGS=$parallel &&
#tools/bootcheck $parallel &&
#cd stage2 &&
mmake install MMAKEFLAGS=$parallel &&
#mmake realclean &&
true

popd # popd $MERCURY_GIT
