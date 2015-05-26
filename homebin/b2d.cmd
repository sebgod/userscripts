:: Supported commands:
::   init                Create a new Boot2Docker VM.
::   up|start|boot       Start VM from any states.
::   ssh [ssh-command]   Login to VM via SSH.
::   save|suspend        Suspend VM and save state to disk.
::   down|stop|halt      Gracefully shutdown the VM.
::   restart             Gracefully reboot the VM.
::   poweroff            Forcefully power off the VM (may corrupt disk image).
::   reset               Forcefully power cycle the VM (may corrupt disk image).
::   delete|destroy      Delete Boot2Docker VM and its disk image.
::   config|cfg          Show selected profile file settings.
::   info                Display detailed information of VM.
::   ip                  Display the IP address of the VM's Host-only network.
::   shellinit           Display the shell commands to set up the Docker client.
::   status              Display current state of VM.
::   download            Download Boot2Docker ISO image.
::   upgrade             Upgrade the Boot2Docker ISO image (restart if running).
::   version             Display version information.

@if "%~1" EQU "" (
    @call "%~f0" start
    exit /b %ERRORLEVEL%
)
@echo %1 | findstr "start up boot" >nul && (
    for /F "usebackq tokens=1,2,* delims== " %%A in (`boot2docker %* 2^>^&1`) do @(
        if "%%~A" EQU "set" set %%B=%%C
    )
    if %ERRORLEVEL% NEQ 0 exit /b %ERRORLEVEL%

    setlocal enabledelayedexpansion enableextensions
    for %%V in (HOST CERT_PATH TLS_VERIFY) do @(
        if not defined DOCKER_%%V exit /b 1
        echo DOCKER_%%V=!DOCKER_%%V!
    )
) || (
    echo %~1 | findstr "ssh shellinit" > nul && call "%~f0" start
    call boot2docker %*
)
