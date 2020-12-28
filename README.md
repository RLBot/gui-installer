# RLBotGUIX-installer

## How to build

1. [Download bat2exe](https://bat2exe.net/)
2. Use bat2exe to convert the 3 files in [`RLBotGUIX main exe`](https://github.com/VirxEC/RLBotGUIX-installer/tree/master/RLBotGUIX%20main%20exe) to `RLBotGUIX main exe\bin\RLBotGUIX.exe`
3. Make sure you have Visual Studio 2019, as well as the Microsoft Visual Studio Installer Projects extension.
4. Open project in Visual Studio 2019
5. In the Solution Explorer, left-click 'RLBotGUIX Installer'
6. If you're updating the installer, you need to now generate a new installer version
7. In the Solution Explorer, right-click 'RLBotGUIX Installer' and select 'Build'
8. Once it builds, the msi file will be in `RLBotGUIX Installer\Debug` - it's name will be `RLBotGUIX Installer.msi`

## About MSI

MSI is short for MicroSoft Installer. All versions of Windows after Windows 2000 support it, and that was long before 64-bit OS were a thing. Therefore, none of our users should have a problem with this new installer. The installer is also very straight forward and intuitive, as all the user really has to do is click 'Next' a couple times.

Source: [wikipedia.org/wiki/Windows_Installer](https://en.wikipedia.org/wiki/Windows_Installer)

## Enchancements

This installer has a few enchancements over the old method:

+ This installer installs the Python 3.7 into the `Python37` folder in a way that should be supported by all windows versions.
+ This method of installing the RLBotGUIX is much more intuitive, as more users expect a dedicated installer.
+ Since this installer installs Python 3.7, the main exe is back to being only ~128KB instead of ~22MB.
+ This installer registers RLBotGUIX with Window's list of programs.
+ This installer puts the main exe file into the folder `%programfiles%\RLBot\RLBotGUIX` (which can be changed), as well as adding a shortcut to it onto the user's desktop.
+ This installer gets around the very scary Windows message that pops up when the user first launches the program. It should also slip by any and all antiviruses, unless some parents decide to completely lock down their child's computer. That, however, isn't our problem xD

## Problems solved

This installer solves 2 problems, both of which I have encountered due to the current exe installer/launcher combo.

1. Not having PowerShell, or having a really old version of it.

Example error messages:

+ `'powershell' is not recognized as an internal or external command, operable program or batch file.`
+ `The term 'Expand-Archive' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.`

With this installer, our custom Python 3.7 install isn't stored inside a zip file. It's just moved from the installer into it's proper place.

2. Antivirus programs, and the scary Windows warning

That's right, no more scary Windows warnings for users!!! At the same time, the installer requires admin privilages in order to put RLBot into the Program Files folder - once the user give it permission, antivirus programs shouldn't touch RLBot due to it residing in the Program Files and LocalAppData folders.
