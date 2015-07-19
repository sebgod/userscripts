#!/bin/sh
#
pushd $MERCURY_GIT
PARALLEL=-j2
CC=${MERCURY_CC-gcc}
CC_NO_BLANKS=`basename $CC`
CC_NO_BLANKS=${CC_NO_BLANKS//[[:blank:]]/}
CC_NO_BLANKS=${CC_NO_BLANKS//:/}
PREFIX=c:/mercury/dev-${CC_NO_BLANKS}${MERCURY_SUFFIX}

# the mercury_build_env.cmd script passes the directory
shift

echo ./configure --with-cc=$CC \
    --prefix=$PREFIX \
    --enable-libgrades=$MERCURY_LIBGRADES \
    --enable-new-mercuryfile-struct $*

git checkout build &&
git rebase master &&
aclocal -I m4 &&
autoconf &&
./configure --with-cc="$CC" \
    --prefix=$PREFIX \
    --enable-libgrades=$MERCURY_LIBGRADES \
    --enable-new-mercuryfile-struct $* &&
touch Mmake.params &&
touch Mercury.options &&
make depend &&
make MMAKEFLAGS=$parallel &&
make install MMAKEFLAGS=$parallel &&
true

# popd $MERCURY_GIT
popd
