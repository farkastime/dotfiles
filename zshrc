# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# pyenv shell configuration
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"

# zsh configuration
export ZSH="$HOME/.oh-my-zsh"

# change history file locations
export HISTFILE="$HOME/.history/.zsh_history"
export LESSHISTFILE="$HOME/.history/.less_history"

#ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git
        aws
        vi-mode)

source $ZSH/oh-my-zsh.sh

# Docker config
export DOCKER_DEFAULT_PLATFORM=linux/amd64

# custom keybindings
bindkey -M viins 'jk' vi-cmd-mode # map jk to ESC in zsh vi mode

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# for vim themes
export TERM=xterm-256color

# direnv
#eval "$(direnv hook zsh)"

# ssh agent
eval $(ssh-agent) &>/dev/null

# source local file
source "$HOME/.zshrc_local"