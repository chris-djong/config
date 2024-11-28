source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/spaceship/spaceship.zsh

export PATH="$HOME/bin:$PATH" 
# Setup terminal history

HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# Better cd 
eval "$(zoxide init bash)"
# alias cd="z" # TODO: Somehow this gives an error funcnest after some time

# Better ls 
alias ls="eza --icons=always"

alias vi="nvim"
alias vim="nvim"
alias ls='eza --color=auto --icons=always'
alias ll='eza -lah --color=auto --icons=always'
alias grep='grep --color=auto'
alias set_env='source ./.venv/bin/activate'
