@echo off
net session >nul 2>&1
if %errorLevel% == 0 (
    goto getletters
) else (
    echo Error: please run this script as an Administrator, in a Windows installation USB/DVD
    pause
    exit /b
)
:getletters
    set /p "MAINDRIVE= Type main drive letter= "
    set /p "SCRATCHDRIVE= Type drive letter with "Scratch" folder (if not present it will be created)= "
    if exist "%SCRATCHDRIVE%:\Scratch" (
    goto createiso 
    ) else (
      set /p YN= %SCRATCHDRIVE% has no folder named "Scratch", would you like to create it? Y/N)
      if %YN% == Y (
          mkdir %SCRATCHDRIVE%:\Scratch
          goto createiso
      ) else (
		  if %YN% == y (
			mkdir %SCRATCHDRIVE%:\Scratch
			goto createiso
		  ) else (
			echo The script cannot be executed without a Scratch dir!
			pause
			exit /b
			)
      )
    )

:createiso
    echo dism /capture-image /imagefile:%SCRATCHDRIVE%:\install.wim /capturedir:%MAINDRIVE%:\ /ScratchDir:%SCRATCHDRIVE%:\Scratch /name:"AnyName" /compress:maximum /checkintegrity /verify /bootable