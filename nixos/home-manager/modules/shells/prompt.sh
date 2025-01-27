update_ps1() {
  # Get the current directory
  LOGOS=""
  add_logo() {
    LOGOS="$LOGOS$1"
  }
  # Show a lock symbol if directory is read-only
  if [ ! -w "$(pwd)" ]; then
    add_logo "🔒"
  fi

  # Show the shell level in case we are in a shell
  if [[ $TMUX && ! "$SHLVL" == "2" ]]; then 
    add_logo "🐚"
  elif [[ ! $TMUX && ! "$SHLVL" == "1"  ]]; then
    add_logo "🐚"
  fi

  # If direnv exists
  if type direnv >/dev/null 2>&1; then
    # And is loaded
    DIRENV_LOADED_STATUS=$(direnv status --json | jq '.state.loadedRC.allowed' ) 
    if [[ "$DIRENV_LOADED_STATUS" == "0" ]]; then
      add_logo "📂"
    fi
  fi

  # Check for Python version
  PYTHON_EXISTS=$(python --version 2>/dev/null) 
  PYTHON_PATH=$(which python 2>/dev/null)
  if [[ "$PYTHON_EXISTS" && "$PYTHON_PATH" == *".venv"* ]]; then
    add_logo "🐍"
  fi

  if [[ "$LOGOS" ]]; then
    LOGOS="$LOGOS "
  fi

  HOST_PROMPT=""   
  if [[ $SSH_CONNECTION ]]; then
    HOST_PROMPT="$(whoami)@$(hostname) "
  fi
  GIT=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [[ "$GIT" ]]; then
    GIT_PROMPT="$GIT "
  fi
  DIRECTORY="$(echo "${PWD/#$HOME/~}" | rev | cut -d'/' -f1-3 | rev): "

  if [[ "$BASH_VERSION" ]]; then
    # Define color codes for Bash
    COLOR_HOST="\e[38;5;205m"     # Pink (205)
    COLOR_GIT="\e[38;5;49m"       # Green (49)
    COLOR_DIRECTORY="\e[38;5;14m" # Blue (14)
    COLOR_RESET="\e[0m"           # Reset
  elif [[ "$ZSH_VERSION" ]]; then
    COLOR_HOST="%F{205}"     # Pink (205)
    COLOR_GIT="%F{49}"       # Green (49)
    COLOR_DIRECTORY="%F{14}"  # Blue (14)
    COLOR_RESET="%f"         # Reset
  fi

  PS1="$LOGOS${COLOR_HOST}$HOST_PROMPT${COLOR_RESET}${COLOR_GIT}${GIT_PROMPT}${COLOR_RESET}${COLOR_DIRECTORY}$DIRECTORY${COLOR_RESET}"
}

