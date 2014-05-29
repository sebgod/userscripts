@setlocal enabledelayedexpansion
@call %~dp0userenv

@set usbtreeview_zipfile=usbtreeview.zip
@set usbtreeview_url=http://www.uwe-sieber.de/files/%usbtreeview_zipfile%

pushd %temp%
mkdir usbtreeview
pushd usbtreeview
wget -N %usbtreeview_url%
7za x -y %usbtreeview_zipfile%

if /i %OS_ARCH_BITNESS% equ 32 (
    pushd Win32
) else (
    if /i %OS_ARCH_BITNESS% equ 64 (
        pushd x64
    ) else (
        echo Cannot handle bitness: %OS_ARCH_BITNESS% >&2
        exit /b 1
    )
)

xcopy /y usbtreeview.exe %~dp0api

:: exe subfolder
popd

:: usbtreeview
popd

:: temp
popd
