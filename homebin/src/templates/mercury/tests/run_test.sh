#!/bin/sh
MAIN_TEST=$1
TEST=$2

if [ -r "${TEST}.bat" ] ; then
    EXE="${COMSPEC} /c ${TEST}.bat"
elif [ -x "${TEST}" ] ; then
    EXE="./${TEST}"
elif [ -r "${TEST}.exe" ] ; then
    EXE="${TEST}.exe"
elif [ -r "${MAIN_TEST}.bat" ] ; then
    EXE="${COMSPEC} /c ${MAIN_TEST}.bat"
elif [ -r "${MAIN_TEST}" ] ; then
    EXE="./${MAIN_TEST}"
elif [ -r "${MAIN_TEST}.exe" ] ; then
    EXE="${MAIN_TEST}.exe"
else
    echo "Cannot find executable '${TEST}'" >&2
    exit 1
fi

exec $EXE
