#!/bin/sh

JAVA_HOME=$(dirname $(locate ASSEMBLY_EXCEPTION))
for dir in $JAVA_HOME:
do
	[ -d $dir ] && export JAVA_HOME=$dir && break
done
