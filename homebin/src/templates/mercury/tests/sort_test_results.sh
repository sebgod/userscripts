#!/bin/sh
SORT=$1
FILE=$2

if [ -z "$FILE" ] ; then
    echo "Please specify a file to be sorted" >&2
    exit 1
fi

touch $FILE &&\
    echo "@@ $FILE" &&\
    $SORT -u $FILE -o $FILE &&\
    cat $FILE &&\
    echo "@@"
