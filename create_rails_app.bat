@echo off
title Rails 8 App Generator (WSL)
cls

echo ========================================================
echo   RAILS 8 APP GENERATOR (WSL)
echo ========================================================
echo.

set /p AppName=Enter your new Application Name: 

if "%AppName%"=="" goto Error

echo.
echo Launching WSL...
echo * You will be asked for your sudo password to start Postgres.
echo.

:: Changes:
:: 1. Added '-i' flag to force interactive mode (loads full .bashrc so 'rails' works)
:: 2. Updated IP detection to be more robust
:: 3. Explicitly sources .bashrc just in case
wsl bash -i -l -c "source ~/.bashrc; export WINDOWS_HOST_IP=$(ip route show | grep -i default | awk '{print $3}'); echo 'Windows Host IP: '$WINDOWS_HOST_IP; sudo service postgresql start; cd ~/dev/rails_projects; rails new %AppName% -d postgresql --css=tailwind -m ~/dev/rails_projects/rails_project_templates/template.rb; cd %AppName%; echo 'Setup Complete!'; exec bash"

goto End

:Error
echo.
echo You must enter an application name!
pause
goto End

:End