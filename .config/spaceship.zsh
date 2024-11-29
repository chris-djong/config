SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true

# The char before a prompt
SPACESHIP_CHAR_SUFFIX=" "

# Directory section
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_DIR_PREFIX=""
SPACESHIP_DIR_SUFFIX=" "

# GIT section
SPACESHIP_GIT_SHOW=true
SPACESHIP_GIT_PREFIX=""
SPACESHIP_GIT_STATUS_SHOW=false
SPACESHIP_GIT_ORDER=(
  git_branch
)

# VENV Section
SPACESHIP_VENV_PREFIX="("
SPACESHIP_VENV_SUFFIX=") "
SPACESHIP_VENV_GENERIC_NAMES=()
SPACESHIP_VENV_COLOR=yellow


SPACESHIP_PROMPT_ORDER=(
  venv
  git            
  dir           
  char
)


