@echo off

pushd "%localappdata%\RLBotGUIX"

set rl_py="Python311\python.exe"
set rl_pip="Python311\Scripts\pip.exe"

rem If Python 3.11.6 hasn't been installed yet, install it

if not exist %rl_py% (
  echo Installing/repairing RLBot's Python 3.11.6... please wait...

  unzip.exe -qq -o python-3.11.6-custom-amd64.zip

  echo Thank you for installing RLBot's Python 3.11.6
)

rem Since we have our own Python 3.11 install, we don't actually need to make a virtual environment

echo Checking for conenction to pypi.org...

rem We ping google to see if we have an internet connection, but don't print to the console

%WINDIR%\system32\ping -n 1 google.com > nul

if %errorlevel% == 0 (
  if not exist %rl_pip% (
    echo Python pip not found - installing!
    %rl_py% get-pip.py
  )

  echo Connected - Installing / upgrading RLBot components...

  %rl_py% -m pip install -U pip --no-warn-script-location
  %rl_pip% install -U setuptools wheel --no-warn-script-location
  %rl_pip% install -U gevent --no-warn-script-location
  %rl_pip% install -U eel --no-warn-script-location
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
