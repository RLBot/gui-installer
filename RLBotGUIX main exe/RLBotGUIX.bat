@echo off

pushd "%LocalAppData%\RLBotGUIX"

rem Create a virtual environment which will isolate our package installations from any
rem existing python installation that the user may have.

if not exist .\venv\Scripts\activate.bat (
  echo Creating Python virtual environment just for RLBot...
  "%LocalAppData%\RLBotGUIX\Python37\python.exe" -m venv .\venv
  if %ERRORLEVEL% GTR 0 (
    echo Something went wrong with creating Python virtual environment, aborting.
    pause
    exit
  )
)

rem Activate the virtual environment
call .\venv\Scripts\activate.bat
if %ERRORLEVEL% GTR 0 (
  echo Error when activating RLBot's virtual environment, attemping fix...
  rem This is a custom python script that updates the Python location in the venv
  "%LocalAppData%\RLBotGUIX\Python37\python.exe" "%~dp0\update_venv.py"
  call .\venv\Scripts\activate.bat
  if %ERRORLEVEL% GTR 0 (
    echo Couldn't fix RLBot's virtual environment, aborting.
    pause
    exit
  )
)

echo Checking for updates...

rem We ping google.com to see if we have an internet connection
rem We then store the output of the command to nul which prevents the command from printing to the console
ping -n 1 google.com > nul
if %errorlevel% == 0 (
  echo Installing / upgrading RLBot components...
  python -m pip install --upgrade pip
  pip install wheel
  pip install eel
  pip install --upgrade rlbot_gui rlbot
) else (
  echo It looks like you're offline, skipping package upgrades.
  echo Please note that if this is your first time running RLBotGUI, an internet connection is required to properly install.
)

echo Launching RLBotGUIX!

python -c "from rlbot_gui import gui; gui.start()"

if %ERRORLEVEL% GTR 0 (
  pause
)

