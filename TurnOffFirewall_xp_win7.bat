@echo off
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do (if %%i==Version (set v=%%j.%%k) else (set v=%%i.%%j))
if %v% LSS 6  (goto xp) else (goto win7)

:xp
	netsh firewall set opmode profile = ALL mode = DISABLE
	netsh firewall set opmode mode = DISABLE

	if %errorlevel% NEQ 0 sc config sharedaccess start= auto
	ping 127.0.0.1 > nul
	sc query sharedaccess | find "RUNNING"
	if %errorlevel% NEQ 0 sc start sharedaccess
	if %errorlevel% == 0 (netsh firewall set opmode profile = ALL mode = DISABLE & netsh firewall set opmode mode = DISABLE)
	echo %errorlevel%
	
	exit /b

:win7
	NetSh Advfirewall set allprofiles state off
	
	if %errorlevel% NEQ 0 sc config mpssvc start= auto
	ping 127.0.0.1 > nul
	sc query mpssvc | find "RUNNING"
	if %errorlevel% NEQ 0 sc start mpssvc
	if %errorlevel% == 0 (NetSh Advfirewall set allprofiles state off)
	echo %errorlevel%
	
	exit /b