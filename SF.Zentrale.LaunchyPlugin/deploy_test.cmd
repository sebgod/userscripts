pushd %~dp0

setlocal

pushd bin\Debug
set outdir=%cd%
popd

pushd ..\SF.Zentrale.Launchy\plugins

copy /Y "%outdir%\icons\*.*" icons
copy /Y "%outdir%\Sorpetaler.dll .

popd

endlocal

popd

exit 0