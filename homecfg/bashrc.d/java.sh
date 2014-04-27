#!/bin/sh

JAVA_HOME=$(dirname $(locate ASSEMBLY_EXCEPTION))
[ -d $JAVA_HOME ] && export JAVA_HOME
