@call "%~dp0userenv"

pushd "%TEMP%"
wget --no-check-certificate -nH -x -N "%mono_lib_getline_url%"
xcopy /y %mono_lib_getline_file:/=\% "%~dp0src"

popd
