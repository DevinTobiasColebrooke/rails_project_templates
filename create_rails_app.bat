@echo off
setlocal

:: ==============================================================================
:: [ CONFIGURATION ]
:: ==============================================================================

:: --- WSL CONFIG ---
set WSL_DISTRO=MyDevUbuntu
set WSL_USER=dtcolebrooke

:: --- PATHS ---
:: KEY FIX: We use explicit paths (/home/%WSL_USER%) instead of '~'
:: This ensures 'cd' works correctly even when wrapped in quotes.
set PROJECTS_DIR=/home/%WSL_USER%/dev/rails_projects
set TEMPLATE_PATH=%PROJECTS_DIR%/rails_project_templates/template.rb
set WSL_SCRIPT_PATH=/home/%WSL_USER%/rails_init_temp.sh

:: --- TEMP WINDOWS FILE ---
set "WIN_TEMP_SCRIPT=%TEMP%\rails_init_gen.sh"

:: ==============================================================================
:: [ INPUT ]
:: ==============================================================================
title Rails 8 App Generator (WSL)
cls

echo ========================================================
echo   RAILS 8 APP GENERATOR (WSL)
echo ========================================================
echo.

set /p AppName=Enter your new Application Name: 

if "%AppName%"=="" goto Error

:: ==============================================================================
:: [ GENERATE SCRIPT ]
:: ==============================================================================
echo.
echo [1/3] Generating install script...

:: Ensure fresh temp file
if exist "%WIN_TEMP_SCRIPT%" del "%WIN_TEMP_SCRIPT%"

:: Write script line-by-line.
echo source ~/.bashrc > "%WIN_TEMP_SCRIPT%"
echo echo "--- INITIALIZING RAILS 8 SETUP ---" >> "%WIN_TEMP_SCRIPT%"

:: IP Detection
echo export WINDOWS_HOST_IP=$(ip route show ^| grep -i default ^| awk '{print $3}') >> "%WIN_TEMP_SCRIPT%"
echo echo "Windows Host IP: $WINDOWS_HOST_IP" >> "%WIN_TEMP_SCRIPT%"

:: Check/Start Postgres
echo service postgresql status ^> /dev/null ^|^| sudo service postgresql start >> "%WIN_TEMP_SCRIPT%"

:: Navigate to Project Folder
echo cd "%PROJECTS_DIR%" >> "%WIN_TEMP_SCRIPT%"

:: Run Rails New
echo echo "Creating Rails App: %AppName%..." >> "%WIN_TEMP_SCRIPT%"
echo rails new %AppName% -d postgresql --css=tailwind -m "%TEMPLATE_PATH%" >> "%WIN_TEMP_SCRIPT%"

:: Enter App and Open Code
echo cd "%AppName%" >> "%WIN_TEMP_SCRIPT%"
echo code . >> "%WIN_TEMP_SCRIPT%"

:: Cleanup and Keep Open
echo echo "Setup Complete!" >> "%WIN_TEMP_SCRIPT%"
:: We use explicit path for removal too
echo rm "%WSL_SCRIPT_PATH%" >> "%WIN_TEMP_SCRIPT%"
echo exec bash >> "%WIN_TEMP_SCRIPT%"

:: ==============================================================================
:: [ TRANSFER & EXECUTE ]
:: ==============================================================================

echo [2/3] Transferring script to WSL (converting CRLF to LF)...

:: Pipe through 'tr -d \r' to ensure Linux line endings
type "%WIN_TEMP_SCRIPT%" | wsl -d %WSL_DISTRO% -u %WSL_USER% bash -c "tr -d '\r' > %WSL_SCRIPT_PATH% && chmod +x %WSL_SCRIPT_PATH%"

echo [3/3] Launching Windows Terminal...

start "" wt -w 0 new-tab -p "%WSL_DISTRO%" -- wsl -d %WSL_DISTRO% -u %WSL_USER% bash -i -l -c "%WSL_SCRIPT_PATH%"

:: Cleanup local temp file
del "%WIN_TEMP_SCRIPT%"

goto End

:Error
echo.
echo You must enter an application name!
pause
goto End

:End
endlocal