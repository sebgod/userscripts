#!/usr/bin/env sh
#

SOURCE=${MERCURY_GIT-~/github/sebgod/mercury}
CC=${MERCURY_CC-gcc}
CC_NO_BLANKS=${CC//[[:blank:]]/}
TARGET_WITH_CC=$HOME/mercury/dev-${CC_NO_BLANKS}
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
        LAST_COMMAND="ln -f -s $HOME/bin/mercury_compile $TARGET/bin"
        case $CC in
            mingw32)
                CONFIGURE_EXTRA="--host=i686-w64-mingw32"
                ;;
            mingw64)
                CONFIGURE_EXTRA="--host=x86_64-w64-mingw32"
                ;;
            *)
                echo "WARN: $CC is not supported!"
                ;;
        esac
        ;;
    *)
        TARGET=$TARGET_WITH_CC
        CONFIGURE_EXTRA="--with-cc=$CC"
        ;;
esac
PARALLEL=-j4
LIBGRADES=${MERCURY_LIBGRADES-asm_fast.gc,java,csharp,erlang}

echo -ne "\033]0;build mmc cc:${CC} grades:${LIBGRADES}\007"

TMP_BUILD_DIR=/tmp/mercury-${CC_NO_BLANKS}
mkdir -p $TMP_BUILD_DIR

pushd "$SOURCE"

git checkout build &&
git rebase master &&

rsync -r . $TMP_BUILD_DIR

pushd $TMP_BUILD_DIR

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
make depend &&
make PARALLEL=$PARALLEL &&
make install PARALLEL=$PARALLEL &&
$LAST_COMMAND

popd # $SOURCE
popd # $TMP_BUILD_DIR
rm -fR $TMP_BUILD_DIR
