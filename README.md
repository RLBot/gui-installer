# RLBotGUIX-installer

## How to build

1. [Download bat2exe](https://bat2exe.net/)
2. Use bat2exe to convert the 3 files in [`RLBotGUIX main exe`](https://github.com/VirxEC/RLBotGUIX-installer/tree/master/RLBotGUIX%20main%20exe) to `RLBotGUIX main exe\bin\RLBotGUIX.exe`
3. Download [`Python 3.7.9's x86-64 executable installer`](https://www.python.org/ftp/python/3.7.9/python-3.7.9-amd64.exe) and save it to `RLBotGUIX Installer\python-3.7.9-amd64.exe`. You can also get it from the list of all of the [Python downloads for Windows](`https://www.python.org/downloads/windows/`).
4. Make sure you have Visual Studio 2019, as well as the Microsoft Visual Studio Installer Projects extension.
5. Open project in Visual Studio 2019
6. In the Solution Explorer, left-click `RLBotGUIX Installer`
7. If you're updating the installer, you need to now generate a new installer version (Click on `RLBotGUIX Installer` in the `Solution Explorer`, then in `Properties` click on `UpgradeCode` and click `New Code` then `Ok`)
8. In the Solution Explorer, right-click `RLBotGUIX Installer` and select `Build`
9. Once it builds, the msi file will be in `RLBotGUIX Installer\Debug` - it's name will be `RLBotGUIX Installer.msi`

## About MSI

MSI is short for MicroSoft Installer. All versions of Windows after Windows 2000 support it, and that was long before 64-bit OS were a thing. Therefore, none of our users should have a problem with this new installer. The installer is also very straight forward and intuitive, as all the user really has to do is click 'Next' a couple times.

Source: [wikipedia.org/wiki/Windows_Installer](https://en.wikipedia.org/wiki/Windows_Installer)

## Enhancements

This installer has a few enhancements over the old method:

+ Installs the Python 3.7 into the `Python37` folder in a way that should be supported by all windows versions.
+ Installing the RLBotGUIX is much more intuitive, as more users expect a dedicated installer.
+ Since this installer installs Python 3.7, the main exe is back to being only ~128KB instead of ~22MB.
+ Registers RLBotGUIX with Window's list of programs.
+ Puts the main exe file into the folder `%programfiles%\RLBot\RLBotGUIX` (which can be changed), as well as adding a shortcut to it onto the user's desktop.
+ It's now easier to upgrade users to newer Python versions.
+ It's now even easier to fix corrupted Python installs. Simply run the file `%localappdata%\RLBotGUIX\python37-uninstall` and you're done!

## Problems solved

This installer solves 2 problems, both of which I have encountered due to the current exe installer/launcher combo.

1. Not having PowerShell, or having a really old version of it.

   Example error messages:

   + `'powershell' is not recognized as an internal or external command, operable program or batch file.`
   + `The term 'Expand-Archive' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.`

   With this installer, our custom Python 3.7 install isn't stored inside a zip file. It's just moved from the installer into it's proper place.

2. Antivirus programs, and the scary Windows warning

   There is still a warning, but it's much less scary. Antivirus programs shouldn't touch RLBot due to it residing in the Program Files and LocalAppData folders.

3. Custom Virtual Environments are too big/take too long to create

    Since we bundle an entire version of Python 3.7, there's no need for us to use a virtual environment on top of that - the full Python 3.7 is already basically an expensive custom virtual environment. This means that we can install packages directly to the custom Python's site packages, and this will let us optimize custom bot virtual environments.

    Since we're using site packages, we can now enable custom environments sharing packages with the site packages, meaning that bots won't have to reinstall rlbot - they can just use the gui's rlbot, with whatever custom packages. This reduced in-dev VirxEB's virtual environment from 85MB to just 12MB, a reduction of 86%. This change requires bot environments to be created with the `--system-site-packages` flag, and should be backwards-compatible.

    This is mostly just a user QOL improvement, but still an improvement nonetheless.
