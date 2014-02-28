#!/bin/sh
git branch --merged | grep -v '^* master$' | grep -v '^  master$' | xargs git branch -d