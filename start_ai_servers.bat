@echo off
setlocal

:: ==============================================================================
:: [ CLEANUP SECTION ]
:: ==============================================================================
echo [1/3] Cleaning up Windows processes...
taskkill /F /IM llama-server.exe >nul 2>&1

echo [2/3] Cleaning up WSL processes...
wsl -d MyDevUbuntu -u dtcolebrooke bash -c "pkill -9 ruby; pkill -9 -f webapp.run; pkill -9 -f 'rails server'; pkill -9 -f 'thrust'"

echo [3/3] Removing Chrome Lock files...
wsl -d MyDevUbuntu -u dtcolebrooke bash -c "rm -rf ~/.config/google-chrome/Singleton*"

echo Cleanup Complete.
timeout /t 1 >nul

:: ==============================================================================
:: [ CONFIGURATION ]
:: ==============================================================================

:: --- WINDOWS / LLAMA CONFIG ---
set LLAMA_DIR=C:\Users\dtcol\Documents\llama-b7307-bin-win-vulkan-x64
set EMBED_MODEL=nomic-embed-text-v1.5.f32.gguf

:: --- WSL / SEARXNG CONFIG ---
set WSL_DISTRO=MyDevUbuntu
set WSL_USER=dtcolebrooke
set SEARX_PATH=/home/%WSL_USER%/dev/searxng/searxng

:: Command string for inside WSL
set "CMD_SEARX=rm -f ~/.config/google-chrome/Singleton* && ./manage webapp.run && exec bash || exec bash"

:: ==============================================================================
:: [ MODEL SELECTION MENU ]
:: ==============================================================================
:MENU
cls
echo ======================================================
echo   SELECT INSTRUCT MODEL
echo ======================================================
echo.
echo   [1] Meta Llama 3.1 8B Instruct (Q8_0)
echo   [2] Qwen3 14B (Q5_K_M)
echo   [3] GPT OSS 20B (Q5_K_M)
echo.
set /p user_choice="Enter choice (1-3): "

if "%user_choice%"=="1" goto MODEL_LLAMA
if "%user_choice%"=="2" goto MODEL_QWEN
if "%user_choice%"=="3" goto MODEL_GPT
echo Invalid choice. Please try again.
timeout /t 2 >nul
goto MENU

:MODEL_LLAMA
set MODEL_FILE=Meta-Llama-3.1-8B-Instruct-Q8_0.gguf
set MODEL_NAME=Llama 3.1 8B
goto ASK_SEARX

:MODEL_QWEN
set MODEL_FILE=Qwen3-14B-Q5_K_M.gguf
set MODEL_NAME=Qwen3 14B
goto ASK_SEARX

:MODEL_GPT
set MODEL_FILE=gpt-oss-20b-Q5_K_M.gguf
set MODEL_NAME=GPT OSS 20B
goto ASK_SEARX

:: ==============================================================================
:: [ SEARXNG SELECTION ]
:: ==============================================================================
:ASK_SEARX
echo.
set /p start_searx="Start SearXNG server as well? (Y/N): "

:: ==============================================================================
:: [ PREPARE COMMANDS ]
:: ==============================================================================

echo.
echo Selected: %MODEL_NAME%
echo Preparing launch sequences...

:: Port 8080 (Instruct)
set INSTRUCT_CMD=llama-server -m %MODEL_FILE% --host 0.0.0.0 --port 9090 --jinja --verbose --ctx-size 32768

:: Port 8081 (Embed)
set EMBED_CMD=llama-server -m %EMBED_MODEL% --host 0.0.0.0 --port 9091 --embedding --ubatch-size 2048 --verbose

if /I "%start_searx%"=="Y" goto LAUNCH_ALL
goto LAUNCH_AI

:: ==============================================================================
:: [ EXECUTE: OPTION 1 - ALL SERVERS ]
:: ==============================================================================
:LAUNCH_ALL
echo Launching AI Models + SearXNG...
:: Replicates Launch_recon layout: Instruct Tab -> Split Embed (Vertical) -> Focus Left -> Split SearX (Horizontal)
start "AI Servers" wt ^
  new-tab -p "Command Prompt" -d "%LLAMA_DIR%" --title "Instruct: %MODEL_NAME%" cmd /k "%INSTRUCT_CMD%" ; ^
  split-pane -V -p "Command Prompt" -d "%LLAMA_DIR%" --title "Embed: Nomic" cmd /k "%EMBED_CMD%" ; ^
  move-focus left ; ^
  split-pane -H -p "%WSL_DISTRO%" wsl -d %WSL_DISTRO% -u %WSL_USER% --cd "%SEARX_PATH%" bash -c "%CMD_SEARX%"
goto END

:: ==============================================================================
:: [ EXECUTE: OPTION 2 - AI ONLY ]
:: ==============================================================================
:LAUNCH_AI
echo Launching AI Models Only...
start "AI Servers" wt ^
  new-tab -p "Command Prompt" -d "%LLAMA_DIR%" --title "Instruct: %MODEL_NAME%" cmd /k "%INSTRUCT_CMD%" ; ^
  split-pane -V -p "Command Prompt" -d "%LLAMA_DIR%" --title "Embed: Nomic" cmd /k "%EMBED_CMD%"
goto END

:END
endlocal