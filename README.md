# RLBotGUIX-installer

## How to build

1. Throw the exe in as `RLBotGUIX main exe\rlbotguilauncher.exe`
2. Make sure you have Visual Studio 2019+, as well as the Microsoft Visual Studio Installer Projects extension.
3. Open project in Visual Studio 2019+
4. In the Solution Explorer, left-click `RLBotGUIX Installer`
5. If you're updating the installer, you need to now generate a new installer version
   - Click on `RLBotGUIX Installer` in the `Solution Explorer`, then in `Properties` click on `Version` and increment the number. Then click `Yes` to the following prompt to update the `ProductCode`
6. In the Solution Explorer, right-click `RLBotGUIX Installer` and select `Build`
7. Once it builds, the msi file will be in `RLBotGUIX Installer\Release` - it's name will be `RLBotGUIX Installer.msi`
