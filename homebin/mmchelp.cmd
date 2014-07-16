@setlocal enabledelayedexpansion enableextensions
@call mercury --help | @call pgrepc --after=2 --before=5 -- %*
