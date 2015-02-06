@echo Copy gitconfig to %%userprofile%%
@call cp -f -l "%~dp0..\homecfg\git.config" "%userprofile%\.gitconfig"
