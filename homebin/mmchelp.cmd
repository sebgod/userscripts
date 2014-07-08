@call "%~dp0userenv"
@call mercury --help | %GREP_PERL% -P --color=always --after=2 --before=5 -- %*
