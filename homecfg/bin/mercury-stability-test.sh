#/bin/sh
exec grep --include "*.m" -r "Stability:" . | cut -s -d ' ' -f 3,4,5 | sort -u
