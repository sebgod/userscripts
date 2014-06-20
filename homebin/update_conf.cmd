@echo Copy gitconfig to %%userprofile%%
@copy /y "%~dp0..\homecfg\git.config" "%userprofile%\.gitconfig"
