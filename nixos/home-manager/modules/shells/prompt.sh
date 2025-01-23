update_ps1() {
  # Get the current directory
  DIR=""
  # Show a lock symbol if directory is read-only
  if [ ! -w "$(pwd)" ]; then
    DIR="🔒"
  fi

  # Check for Python version
  PYTHON_EXISTS=$(python --version 2>/dev/null) 
  PYTHON_PATH=$(which python 2>/dev/null)
  PYTHON=""
  if [[ "$PYTHON_EXISTS" && "$PYTHON_PATH" == *".venv"* ]]; then
    PYTHON="🐍"
  fi

  # Get the current git branch
  GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  GIT=""
  if [ "$GIT_BRANCH" ]; then
    GIT="$GIT_BRANCH "
  fi

  # Get the hostname
  HOST="$(hostname) "
  # Check for direnv environment (Optional)
  DIR_ENV=""
  # If direnv exists
  if type direnv >/dev/null 2>&1; then
    # And is loaded
    DIRENV_LOADED_STATUS=$(direnv status --json | jq '.state.loadedRC.allowed' ) 
    if [[ "$DIRENV_LOADED_STATUS" == "0" ]]; then
      DIR_ENV="📂"
    fi
  fi

  DIRECTORY="$(echo "$PWD" | rev | cut -d'/' -f1-3 | rev)"
  CHAR=": "

  if [[ "$BASH_VERSION" ]]; then
    PS1="$DIR_ENV$PYTHON$HOST$GIT$DIRECTORY$CHAR"
  elif [[ "$ZSH_VERSION" ]]; then
    PS1="$DIR_ENV$PYTHON%F{205}$HOST%f%F{49}$GIT%f%F{14}$DIRECTORY%f%B$CHAR%b"
  else
    PS1="$DIR_ENV$PYTHON$HOST$GIT$DIRECTORY$CHAR"
  fi

}

