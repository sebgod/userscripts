@setlocal enabledelayedexpansion
@call %~dp0userenv

@set sagethumbs_version=2.0.0.17
@set sagethumbs_setup=sagethumbs_%sagethumbs_version%_setup.exe
@set sagethumbs_url=http://sagethumbs.googlecode.com/files/%sagethumbs_setup%


wget -P%TEMP% -N "%sagethumbs_url%"

call %TEMP%\%sagethumbs_setup%

