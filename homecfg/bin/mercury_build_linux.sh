#!/usr/bin/env sh
#

SOURCE=${MERCURY_GIT-~/github/sebgod/mercury}
CC=${MERCURY_CC-gcc}
TARGET_WITH_CC=$HOME/mercury/dev-${CC//[[:blank:]]/}
CONFIGURE=configure
CONFIGURE_EXTRA=
LAST_COMMAND=true
case $CC in
    gcc)
        TARGET=$HOME
        ;;
    mingw*)
        TARGET=$TARGET_WITH_CC
        CONFIGURE=tools/configure_mingw_cross
        LAST_COMMAND=ln -s $HOME/bin/mercury_compile $TARGET/bin
        case $CC in
            mingw32)
                CONFIGURE_EXTRA="--host=i686-pc-mingw32"
                ;;
            mingw64)
                CONFIGURE_EXTRA="--host=x86_64-w64-mingw32"
                ;;
            *)
                echo "WARN: $CC is not supported!"
                ;;
        )
        ;;
    *)
        TARGET=$TARGET_WITH_CC
        CONFIGURE_EXTRA="--with-cc=$CC"
        ;;
esac
PARALLEL=-j4
LIBGRADES=${MERCURY_LIBGRADES-asm_fast.gc,java,csharp,erlang}

pushd $SOURCE
git checkout build &&
git rebase master &&
aclocal -I m4 &&
autoconf &&
./$CONFIGURE --prefix=$TARGET \
    $CONFIGURE_EXTRA \
    --enable-libgrades=$LIBGRADES \
    --enable-new-mercuryfile-struct &&
touch Mmake.params &&
touch Mercury.options &&
mmake depend &&
mmake MMAKEFLAGS=$PARALLEL &&
# this does not work on Fedora currently
#tools/bootcheck $PARALLEL &&
#cd stage2 &&
mmake install MMAKEFLAGS=$PARALLEL &&
mmake realclean &&
$LAST_COMMAND

popd
