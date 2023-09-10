@echo off

pushd "%localappdata%\RLBotGUIX"

set rl_py="Python37\python.exe"
set rl_pip="Python37\Scripts\pip.exe"

rem If Python 3.7.9 hasn't been installed yet, install it

if not exist %rl_py% (
  echo RLBot's Python 3.7.9 hasn't been installed! Please click either "Install" or "Repair", depending on what you see in the popup.

  python-3.7.9-amd64.exe "TargetDir=%localappdata%\RLBotGUIX\Python37" Shortcuts=0 Include_launcher=0 InstallLauncherAllUsers=0 AssociateFiles=0 SimpleInstall=1 PrependPath=0

  echo Thank you for installing RLBot's Python 3.7.9.
)

rem Since we have our own Python 3.7 install, we don't actually need to make a virtual environment

echo Checking for conenction to pypi.org...

rem We ping PyPi's package index to see if we have an internet connection, but don't print to the console

ping pypi.org -n 1 > nul

if %errorlevel% == 0 (
  echo Connected - Installing / upgrading RLBot components...

  %rl_py% -m pip install -U pip --no-warn-script-location
  %rl_pip% install setuptools wheel --no-warn-script-location
  %rl_pip% install gevent^<22 --no-warn-script-location
  %rl_pip% install eel --no-warn-script-location
  %rl_pip% install -U rlbot_gui rlbot --no-warn-script-location
) else (
  echo.
  echo It looks like either you or PyPi is offline, skipping package upgrades.
  echo If this is your first time running RLBotGUI, an internet connection is required to properly install!
  echo.
)

echo Launching RLBotGUIX!

%rl_py% -c "from rlbot_gui import gui; gui.start()"

if %errorlevel% GTR 0 (
  pause
)
