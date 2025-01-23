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
    GIT="$GIT_BRANCH"
  fi

  # Get the hostname
  HOST="$(hostname)"
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

  # Character section (change based on success or failure)
  if [ $? -eq 0 ]; then
    CHAR=": "
  else
    CHAR=": "
  fi

  PWD=$(echo "$PWD" | rev | cut -d'/' -f1-3 | rev)

  # Combine everything into the PS1 prompt
  PS1="$DIR_ENV$PYTHON $HOST $GIT_BRANCH $PWD$CHAR"
}

# Check if we are in bash or zsh and set the prompt accordingly
if [[ "$0" == "bash" ]]; then
  # For Bash: Use PROMPT_COMMAND to update PS1 before every prompt
  export PROMPT_COMMAND="update_ps1"
elif [[ "$0" == "zsh" ]]; then
  # For Zsh: Use precmd hook to update PS1 before every prompt
  autoload -U add-zsh-hook
  add-zsh-hook precmd update_ps1
fi
