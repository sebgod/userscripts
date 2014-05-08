#!/bin/sh
export CLASSPATH=/usr/share/java/\*:$CLASSPATH
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")
export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:bin/javac::")

