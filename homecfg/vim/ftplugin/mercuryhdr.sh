#!/bin/sh
# vim: ft=sh ff=unix ts=4 sw=4 tw=78 et
DIR=$( cd "$( dirname "$1" )" && pwd )
MODULE=$(echo $(basename "$1" ) | sed 's/\.m$//')
PARENT=$(basename $(echo $DIR | sed 's/src$//' | sed 's/-/_/g' ))
case "$MODULE" in
    *\.*)
        unset PARENT
        ;;
    *)
        if [ "$PARENT" = "$MODULE" ] ; then
            unset PARENT
        else
            PARENT="${PARENT}."
        fi
        ;;
esac
FILE="${MODULE}.m"
cat <<EOF
%----------------------------------------------------------------------------%
% vim: ft=mercury ff=unix ts=4 sw=4 et
%----------------------------------------------------------------------------%
% File: $FILE
% Copyright © $(date +%Y) $GIT_AUTHOR_NAME
% Main author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
% Created on: $(date)
% Stability: low
%----------------------------------------------------------------------------%
% TODO: module documentation
%----------------------------------------------------------------------------%

:- module $PARENT$MODULE.

:- interface.

% TODO: include/import/use modules

%----------------------------------------------------------------------------%

% TODO: insert predicates & functions

%----------------------------------------------------------------------------%
%----------------------------------------------------------------------------%

:- implementation.

% TODO: include/import/use modules

%----------------------------------------------------------------------------%

% TODO: implement predicates & functions

%----------------------------------------------------------------------------%
:- end_module $PARENT$MODULE.
%----------------------------------------------------------------------------%
EOF
