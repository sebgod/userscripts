@call userenv
@setlocal
@set keyfile="%userprofile%\Documents\GitHub\mercury\mercury.snk"
@call %mercury_compiler% --use-grade-subdirs --no-detect-libgrades --sign-assembly %keyfile% -s csharp -m  %*
@endlocal