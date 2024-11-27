source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

PS1='%F{blue}%~ %(?.%F{green}.%F{red})%#%f '

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
alias cd="z"
# Better ls 
alias ls="eza --icons=always"

alias vi="nvim"
alias vim="nvim"
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias grep='grep --color=auto'
