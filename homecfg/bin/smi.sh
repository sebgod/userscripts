#!/bin/sh
mmc --use-grade-subdirs --make lib$1 && sudo mmc --use-grade-subdirs --make lib$1.install