@call %~dp0userenv

pushd %~dp0
pushd src
wget -N %mercury_userlangxml%

:: src
popd
:: %~dp0
popd