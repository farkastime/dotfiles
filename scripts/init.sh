#!/usr/bin/env bash

# flatpaks
flatpak install flathub \
  com.protonvpn.www \ # proton vpn
org.chromium.Chromium \ # chromium browser
com.slack.Slack # slack

# rpms
dnf install -y \
  kitty \ 
gcc-c++

# create dotfiles bare repo
if [[ ! -d "$HOME/.cfg" ]]; then
  echo "Initializing dotfiles bare git repo."
  git init --bare $HOME/.cfg
  git --git-dir=$HOME/.cfg/ config --local status.showUntrackedFiles no
  git --git-dir=$HOME/.cfg/ config remote add origin git@github.com:farkastime/dotfiles.git
  git --git-dir=$HOME/.cfg/ pull

  #alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
fi

# install Homebrew for Linux
if [[ ! -x "$(command -v brew)" ]]; then
  echo "Installing Homebrew for Linux."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew analytics off
fi

# mamba
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh
conda config --set auto_activate_base false

# jekyll
gem install jekyll bundler
