@call %~dp0userenv
@pushd %~dp0api
wget -N %jq_url%
popd
