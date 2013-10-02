@call %~dp0userenv

@echo pushing to %temp%
@pushd %temp%
wget --no-check-certificate -O unicodeconsole.zip "%unicodeconsole_url%"

7za -y x unicodeconsole.zip

@echo pushing to %unicodeconsole_proj%-master
@pushd %unicodeconsole_proj%-master
@call build
@call deployTo "%~dp0api"
@call test "%~dp0api"
@echo popping %unicodeconsole_proj%-master
@popd

@echo popping %temp%
@popd