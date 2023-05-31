@echo off
setlocal enabledelayedexpansion
for /f "tokens=1 delims=:" %%a in ('ipconfig ^| findstr /c:"Ethernet adapter"') do (
    set adapter=%%a
    set adapter=!adapter:~17!

    netsh interface ip set address name="!adapter!" source=dhcp
)
