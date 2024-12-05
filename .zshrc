source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/spaceship/spaceship.zsh

export PATH="$HOME/bin:$HOME/.npm-global/bin:$HOME/.local/bin:$PATH" 

# ADD ccache for FASTER builds!
if [ -d /usr/lib/ccache ]; then
    export CCACHE_SLOPPINESS="file_macro,time_macros"
    export PATH=/usr/lib/ccache:$PATH
fi


HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# Fuck
eval "$(thefuck --alias)"

# Better cd 
eval "$(zoxide init zsh)"
alias cd="z"

# FZF
eval "$(fzf --zsh)"
# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/.config/fzf-git.sh

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Better cat
export BAT_THEME=tokyonight_night
alias cat="bat"

# Better ls 
alias ls="eza --icons=always"

alias vi="nvim"
alias vim="nvim"
alias ls='eza --color=auto --icons=always'
alias ll='eza -lah --color=auto --icons=always'
alias grep='grep --color=auto'
alias set_env='source ./.venv/bin/activate'
