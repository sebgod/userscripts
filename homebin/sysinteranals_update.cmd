@echo off

pushd %~dp0

wget --exclude-directories=Files,Tools,WindowsInternals -N -m http://live.sysinternals.com

popd