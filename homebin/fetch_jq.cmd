@setlocal enabledelayedexpansion
@call "%~dp0userenv"

@set jq_url=http://stedolan.github.io/jq/download/win%OS_ARCH_BITNESS%/jq.exe

@pushd %~dp0api
wget -N %jq_url%
popd
