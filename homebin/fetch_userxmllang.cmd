@setlocal enabledelayedexpansion
@call %~dp0userenv

@set npp_userdefinedlang_src=http://notepad-plus.sourceforge.net/common/userDefinedLang/
@set mercury_userlangxml=%npp_userdefinedlang_src%userDefineLang_Mercury.xml

pushd %~dp0
pushd src
wget -N %mercury_userlangxml%

:: src
popd
:: %~dp0
popd
