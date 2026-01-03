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
echo * Verifying Database Status...
echo.

:: Changes:
:: 1. Added 'service postgresql status > /dev/null || sudo service postgresql start'
::    - This checks if Postgres is running silently.
::    - It only asks for sudo password if the service is stopped.
:: 2. Kept the IP detection and Code launch logic.

wsl bash -i -l -c "source ~/.bashrc; export WINDOWS_HOST_IP=$(ip route show | grep -i default | awk '{print $3}'); echo 'Windows Host IP: '$WINDOWS_HOST_IP; service postgresql status > /dev/null || sudo service postgresql start; cd ~/dev/rails_projects; rails new %AppName% -d postgresql --css=tailwind -m ~/dev/rails_projects/rails_project_templates/template.rb; cd %AppName%; code .; echo 'Setup Complete!'; exec bash"

goto End

:Error
echo.
echo You must enter an application name!
pause
goto End

:End