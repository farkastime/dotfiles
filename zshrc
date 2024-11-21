# zsh configuration
export ZSH="$HOME/.oh-my-zsh"
export ZDOTDIR="$HOME/.cache/zsh"
if [[ ! -d $ZDOTDIR ]]; then
  mkdir -p $ZDOTDIR
fi

# change history file locations
export HISTDIR="$HOME/.history"
export HISTFILE="$HISTDIR/.zsh_history"
export LESSHISTFILE="$HISTDIR/.less_history"
if [[ ! -d $HISTDIR ]]; then
  mkdir -p $HISTDIR
fi

# ZSH_THEME="robbyrussell"
# ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git
        aws
        vi-mode)

source $ZSH/oh-my-zsh.sh

# Docker config
export DOCKER_DEFAULT_PLATFORM=linux/amd64

# custom keybindings
bindkey -M viins 'jk' vi-cmd-mode # map jk to ESC in zsh vi mode

# for vim themes
export TERM=xterm-256color

# direnv
#eval "$(direnv hook zsh)"

# ssh agent
eval $(ssh-agent) &>/dev/null

# source local file
source "$HOME/.zshrc_local"

# enable powerlevel10k -- config in custom automatically sourced
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme