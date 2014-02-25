#!/bin/sh

(mount | grep "on /tmp" >/dev/null) || sudo mount -t tmpfs -o size=1024m,atime,diratime,rw /dev/shm /tmp
