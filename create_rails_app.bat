@echo off
title Rails 8 App Generator (Launcher)
cls

echo ========================================================
echo   RAILS 8 APP GENERATOR (WSL)
echo ========================================================
echo.

set /p AppName=Enter your new Application Name: 

if "%AppName%"=="" goto Error

echo.
echo Launching new Terminal Window...
echo The setup will continue there.
echo.

:: ============================================================================
:: LAUNCHER LOGIC
:: ============================================================================
:: 1. start "" wt: Starts Windows Terminal in a new window.
:: 2. wsl bash -i -l -c "...": Runs the bash command inside that new window.
:: 3. The complex command string handles IP detection, Postgres check, and Rails new.

start "" wt wsl bash -i -l -c "source ~/.bashrc; export WINDOWS_HOST_IP=$(ip route show | grep -i default | awk '{print $3}'); echo 'Windows Host IP: '$WINDOWS_HOST_IP; service postgresql status > /dev/null || sudo service postgresql start; cd ~/dev/rails_projects; rails new %AppName% -d postgresql --css=tailwind -m ~/dev/rails_projects/rails_project_templates/template.rb; cd %AppName%; code .; echo 'Setup Complete!'; exec bash"

:: Close this launcher window immediately
exit

:Error
echo.
echo You must enter an application name!
pause
exit