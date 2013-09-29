call %~dp0userenv

wget -P%TEMP% -N "%sagethumbs_url%"

call %TEMP%\%sagethumbs_setup%

