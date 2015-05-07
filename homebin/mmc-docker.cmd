@setlocal enabledelayedexpansion enableextensions
@call userenv
@for /F "usebackq" %%P in (`pwd`) do @set __PWD=%%P
@for /F "usebackq" %%U in (`id -u %USER%`) do @set __UID=%%U

@call docker run -u %__UID% -it -v %__PWD%:/tmp/mercury --read-only=true sebgod/mercury-stable:latest %*
