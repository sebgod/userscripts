:: vim: ff=unix ts=4 sw=4 tw=78 et
@setlocal enabledelayedexpansion
@set vimline=vim
@set vimline=%vimline%:
@set comment=%%
@set src="^%comment% !vimline! ft=mercury ff=unix ts=4 sw=4 et"
@set rpl="^%comment% !vimline! ft=mercury ff=unix ts=4 sw=4 tw=78 et"
fart -r "*.m" %src% %rpl%
@set l10=----------
@set l30=%l10%%l10%%l10%
@set l70=%l30%%l30%%l10%
@set l78=%l70%------
@set l79=%l78%-
@set l80=%l70%%l10%
@set l81=%l80%-
fart -p -r "*.m" "^%comment%%l81%%comment%" "%comment%%l78%%comment%"
fart -p -r "*.m" "^%comment%%l80%%comment%" "%comment%%l78%%comment%"
fart -p -r "*.m" "^%comment%%l79%%comment%" "%comment%%l78%%comment%"
