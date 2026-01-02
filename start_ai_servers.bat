@echo off
setlocal

:: ==============================================================================
:: [ CONFIGURATION ]
:: ==============================================================================
set LLAMA_DIR=C:\Users\dtcol\Documents\llama-b7307-bin-win-vulkan-x64
set EMBED_MODEL=nomic-embed-text-v1.5.f32.gguf

:: ==============================================================================
:: [ CLEANUP ]
:: ==============================================================================
echo Stopping any existing Llama servers...
taskkill /F /IM llama-server.exe >nul 2>&1

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

:: --- Model Definitions ---

:MODEL_LLAMA
set MODEL_FILE=Meta-Llama-3.1-8B-Instruct-Q8_0.gguf
set MODEL_NAME=Llama 3.1 8B
goto LAUNCH

:MODEL_QWEN
set MODEL_FILE=Qwen3-14B-Q5_K_M.gguf
set MODEL_NAME=Qwen3 14B
goto LAUNCH

:MODEL_GPT
set MODEL_FILE=gpt-oss-20b-Q5_K_M.gguf
set MODEL_NAME=GPT OSS 20B
goto LAUNCH

:: ==============================================================================
:: [ LAUNCH COMMANDS ]
:: ==============================================================================
:LAUNCH
echo.
echo Selected: %MODEL_NAME%
echo Launching servers...

:: Command for the Instruct Model (Dynamic based on choice)
:: Note: ctx-size 32768 is set. If the 20B model runs out of VRAM, try lowering this to 8192.
set INSTRUCT_CMD=llama-server -m %MODEL_FILE% --host 0.0.0.0 --port 8080 --jinja --verbose --ctx-size 32768

:: Command for the Embedding Model (Static)
set EMBED_CMD=llama-server -m %EMBED_MODEL% --host 0.0.0.0 --port 8081 --embedding --ubatch-size 2048 --verbose

start "AI Servers" wt ^
  new-tab -p "Command Prompt" -d "%LLAMA_DIR%" --title "Instruct: %MODEL_NAME%" cmd /k "%INSTRUCT_CMD%" ; ^
  split-pane -V -p "Command Prompt" -d "%LLAMA_DIR%" --title "Embed: Nomic" cmd /k "%EMBED_CMD%" ; ^
  move-focus left

endlocal