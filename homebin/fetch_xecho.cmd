call %~dp0userenv

pushd %temp%
wget --no-check-certificate -O xecho.zip "%xecho_url%"

7za -y x xecho.zip
pushd %xecho_proj%-master
call build
xcopy /Y bin\*.exe %~dp0api
call test
popd

popd