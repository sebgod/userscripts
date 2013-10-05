@call %~dp0userenv

@set unicode_temp=%TEMP%\unidata_%unicode_version%

for %%z in (UCD Unihan) do (
    wget -P %unicode_temp% -N %unicode_url%%%z.zip 
    7za x -Odata\%%z -y %unicode_temp%\%%z.zip
)

set unihan_data=%~dp0data\Unihan
mkdir %unihan_data%
for %%R in (tr38) do (
    wget -P %unicode_temp%\%%R -N %unicode_reports%%%R/ 
    call %~dp0tidyutf8 -o %unihan_data%\%%R.xml %unicode_temp%\%%R\index.html
)
