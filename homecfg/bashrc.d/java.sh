#!/bin/sh
if [ -z "$CLASSPATH" ] ; then
    export CLASSPATH=/usr/share/java/\*
fi

JRE_HOME=`readlink -f /usr/bin/java   | sed "s:/bin/java::"`
JAVA_HOME=`readlink -f /usr/bin/javac  | sed "s:/bin/javac::"`

if [ -r "$JAVA_HOME" ] ; then
    export JDK_HOME=$JAVA_HOME
else
    JAVA_HOME=$JRE_HOME
fi

export JAVA_HOME
export JRE_HOME
