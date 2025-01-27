# zsh configuration
export ZSH="$HOME/.oh-my-zsh"
# export ZDOTDIR="$HOME/.cache/zsh"
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
eval "$(direnv hook zsh)"

# ssh agent
eval $(ssh-agent) &>/dev/null

# source local file
# source "$HOME/.zshrc_local"

# enable powerlevel10k -- config in custom automatically sourced
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# alias thefuck
eval $(thefuck --alias)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/mamba.sh" ]; then
    . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<