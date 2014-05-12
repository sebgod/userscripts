#!/bin/sh

cat <<EOF
%----------------------------------------------------------------------------%
% File: $1
% vim: ft=mercury ff=unix ts=4 sw=4 et
% Copyright (C) 2014 $GIT_AUTHOR_NAME
% Main author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
% Created on: $(date)
%
%----------------------------------------------------------------------------%

:- module $(echo $1 | sed 's/\./__/g;s/__m$//').

:- interface.

:- import_module io.

:- pred main(io::di, io::uo) is det.

%----------------------------------------------------------------------------%
%----------------------------------------------------------------------------%

:- implementation.

%----------------------------------------------------------------------------%

main(!IO) :-

%----------------------------------------------------------------------------%
:- end_module $(echo $1 | sed 's/\./__/g;s/__m$//').
% -*- Mode: Mercury; column: 80; indent-tabs-mode: nil; tabs-width: 4 -*-
%----------------------------------------------------------------------------%
EOF
