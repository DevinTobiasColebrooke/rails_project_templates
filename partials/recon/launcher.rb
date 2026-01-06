def setup_recon_launcher
  # This generates a specific "Full Stack" launcher for the Recon Agent
  # It mimics the standalone app's behavior: cleanup -> launch AI services -> launch Rails
  
  create_file "start_recon_stack.bat", <<~BAT
    @echo off
    setlocal

    :: ==============================================================================
    :: [ CONFIGURATION ]
    :: ==============================================================================

    :: --- WSL CONFIG ---
    :: UPDATE THESE TO MATCH YOUR SYSTEM
    set WSL_DISTRO=MyDevUbuntu
    set WSL_USER=dtcolebrooke
    
    :: --- HOST IP ---
    :: The IP of the Windows host as seen from WSL.
    :: If localhost forwarding works, 127.0.0.1 is fine. 
    :: Otherwise, use the vEthernet (WSL) IP (e.g. 172.x.x.x).
    set HOST_IP=127.0.0.1

    :: --- DIRECTORIES ---
    :: Path to your Llama Server folder on Windows
    set LLAMA_DIR=C:\\Users\\%USERNAME%\\Documents\\llama-b7307-bin-win-vulkan-x64
    
    :: Path to SearXNG inside WSL
    set SEARX_PATH=/home/%WSL_USER%/dev/searxng/searxng
    
    :: Path to THIS Rails App inside WSL
    :: We assume standard structure, but you may need to edit this.
    set RAILS_PATH=/home/%WSL_USER%/dev/rails_projects/#{app_name}

    :: --- MODELS ---
    set INSTRUCT_MODEL=Meta-Llama-3.1-8B-Instruct-Q8_0.gguf
    set EMBED_MODEL=nomic-embed-text-v1.5.f32.gguf

    :: ==============================================================================
    :: [ CLEANUP ]
    :: ==============================================================================
    echo [1/4] Cleaning up Windows processes...
    taskkill /F /IM llama-server.exe >nul 2>&1

    echo [2/4] Cleaning up WSL processes...
    wsl -d %WSL_DISTRO% -u %WSL_USER% bash -c "pkill -9 ruby; pkill -9 -f webapp.run; pkill -9 -f 'rails server'; pkill -9 -f 'thrust'"

    echo [3/4] Removing Chrome Lock files...
    wsl -d %WSL_DISTRO% -u %WSL_USER% bash -c "rm -rf ~/.config/google-chrome/Singleton*"

    echo [4/4] Removing stuck Rails PIDs...
    wsl -d %WSL_DISTRO% -u %WSL_USER% bash -c "rm -f %RAILS_PATH%/tmp/pids/server.pid"

    echo Cleanup Complete. Launching Recon Stack...
    timeout /t 1 >nul

    :: ==============================================================================
    :: [ COMMAND DEFINITIONS ]
    :: ==============================================================================

    :: 1. Llama Servers (Instruct & Embedding)
    :: Using ports 9090/9091 to avoid conflict with Rails 3000 or common 8080
    set LLAMA_INSTRUCT_CMD=llama-server -m %INSTRUCT_MODEL% --host 0.0.0.0 --port 9090 --jinja --ctx-size 32768
    set LLAMA_EMBED_CMD=llama-server -m %EMBED_MODEL% --host 0.0.0.0 --port 9091 --embedding --ubatch-size 2048

    :: 2. SearXNG (WSL)
    set "CMD_SEARX=rm -f ~/.config/google-chrome/Singleton* && ./manage webapp.run && exec bash || exec bash"

    :: 3. Rails App (WSL)
    :: We explicitly export LLM URLs to ensure the app connects to the right ports.
    :: 'sudo service postgresql start' is included but may require password interaction.
    set "CMD_RAILS=sudo service postgresql start && export LLM_BASE_URL=http://%HOST_IP%:9090 && export LLM_EMBEDDING_URL=http://%HOST_IP%:9091 && code . && bin/dev && exec bash || exec bash"

    :: ==============================================================================
    :: [ LAUNCH WINDOW 1: AI BACKEND ]
    :: ==============================================================================
    :: Structure:
    :: - Tab 1: Llama Instruct (Port 9090)
    :: - Split Vertical: Llama Embeddings (Port 9091)
    :: - Split Horizontal (Left): SearXNG (WSL)
    
    start wt ^
      -w 0 new-tab -p "Command Prompt" -d "%LLAMA_DIR%" cmd /k "%LLAMA_INSTRUCT_CMD%" ; ^
      split-pane -V -p "Command Prompt" -d "%LLAMA_DIR%" cmd /k "%LLAMA_EMBED_CMD%" ; ^
      move-focus left ; ^
      split-pane -H -p "%WSL_DISTRO%" wsl -d %WSL_DISTRO% -u %WSL_USER% --cd "%SEARX_PATH%" bash -c "%CMD_SEARX%"

    :: Pause to ensure ports are bound
    timeout /t 2 >nul

    :: ==============================================================================
    :: [ LAUNCH WINDOW 2: RAILS APP ]
    :: ==============================================================================
    :: Launches the Rails dev server in a new Terminal window
    
    start wt ^
      -w 1 new-tab -p "%WSL_DISTRO%" wsl -d %WSL_DISTRO% -u %WSL_USER% --cd "%RAILS_PATH%" bash -l -i -c "%CMD_RAILS%"

    endlocal
  BAT
end