@setlocal enabledelayedexpansion enableextensions
@for /F "usebackq" %%P in (`pwd`) do @set __PWD=%%P
@set __TMP=%TEMP:\=/%
@set __TMP=/%__TMP::=%
@call docker run -it --read-only=true -v %__TMP%:/tmp -v %__PWD%:/var/tmp/mercury:rw sebgod/mercury-stable:latest --no-use-symlinks %*
