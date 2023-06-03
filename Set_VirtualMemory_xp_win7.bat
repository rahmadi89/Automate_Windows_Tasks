@echo off
Rem this batch file will set virtual memory to "3*Total Memory size" at c:\pagefile.sys

setlocal enabledelayedexpansion

for /f "skip=1" %%p in ('wmic os get TotalVisibleMemorySize') do ( 
	set /A total_ram=%%p
	set /A vir_mem = total_ram * 3
	set /A vir_mem_MB = vir_mem/1000
	goto :got_memory_size
)

:got_memory_size
	for /f %%a in ('wmic pagefile GET Description ^| findstr /c:"C:\pagefile.sys"') do (
		goto :page_file_exist  
	)

	:no_page_file
		wmic pagefileset create name="C:\pagefile.sys"
		goto :page_file_exist
		
	:page_file_exist
		for /f "tokens=4-7 delims=[.] " %%i in ('ver') do (if %%i==Version (set v=%%j.%%k) else (set v=%%i.%%j))
			if %v% LSS 6  (goto xp) else (goto win7)

		:win7
			wmic computersystem where name="%computername%" set AutomaticManagedPagefile=false
			
		:xp
			rem "Nothing Required"
			
		wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=%vir_mem_MB%,MaximumSize=%vir_mem_MB%
