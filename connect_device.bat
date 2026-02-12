@echo off
set ADB_PATH=%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe

if exist "%ADB_PATH%" (
    "%ADB_PATH%" connect 192.168.1.5:42707
    "%ADB_PATH%" devices
) else (
    echo ADB not found at %ADB_PATH%
    echo Please update the ADB_PATH in this script
)
pause
