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

:: ============================================================================
:: EXECUTION LOGIC
:: ============================================================================
:: 1. wsl bash -i -l -c: Runs in the current window as an interactive login shell.
:: 2. IP Detection: Grabs the Windows IP (just in case it's needed).
:: 3. Postgres Check: Only asks for sudo if the service is stopped.
:: 4. Rails New: Runs the template wizard.
:: 5. Code .: Opens VS Code.
:: 6. exec bash: Keeps the terminal open inside the new project folder.

wsl bash -i -l -c "source ~/.bashrc; export WINDOWS_HOST_IP=$(ip route show | grep -i default | awk '{print $3}'); echo 'Windows Host IP: '$WINDOWS_HOST_IP; service postgresql status > /dev/null || sudo service postgresql start; cd ~/dev/rails_projects; rails new %AppName% -d postgresql --css=tailwind -m ~/dev/rails_projects/rails_project_templates/template.rb; cd %AppName%; code .; echo 'Setup Complete!'; exec bash"

goto End

:Error
echo.
echo You must enter an application name!
pause
goto End

:End