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

python -m pip install -U pip
pip install -U wheel
pip install -U eel
pip install -U rlbot_gui rlbot

echo Launching RLBotGUIX!

python -c "from rlbot_gui import gui; gui.start()"

if %ERRORLEVEL% GTR 0 (
  pause
)

