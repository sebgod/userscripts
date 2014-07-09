#!/bin/sh
export CLASSPATH=/usr/share/java/\*:$CLASSPATH
JAVA_HOME=`readlink -f /usr/bin/java  | sed "s:bin/java::"`
[ -r "$JAVA_HOME" ] || JAVA_HOME=`readlink -f /usr/bin/javac | sed "s:bin/javac::"`
export JAVA_HOME
