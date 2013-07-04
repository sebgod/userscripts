call %~dp0userenv

pushd %~dp0api
wget --exclude-directories=Files,Tools,WindowsInternals -N -m %sysinternals_url%
popd