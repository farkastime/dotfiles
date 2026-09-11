#!/bin/bash

# DNF Bundle - A simple package list manager for Fedora
# Add this to your dotfiles. Run it to sync your system with this list.

# Fail on error
set -e

# --- PACKAGE LIST ---
PACKAGES=(
  # Essential Build Tools
  gcc
  gcc-c++
  make
  cmake
  pkg-config

  # XML Development Tools
  libxml2-devel
  libxslt-devel

  # Python Build Tools
  python3-devel

  # R Spatial Stack (The "Big Five")
  gdal
  gdal-devel
  proj-devel
  geos-devel
  sqlite-devel
  udunits2-devel

  # Graphics & Typography (Required for ggplot2 / ragg)
  harfbuzz-devel
  fribidi-devel
  freetype-devel
  libpng-devel
  libtiff-devel
  libjpeg-turbo-devel

  # Network & HTML (Required for curl, xml2, rvest)
  libcurl-devel
  openssl-devel
  libxml2-devel

  # Quarto / RMarkdown dependencies
  pandoc

  # parallel computing
  parallel

  # java distributions
  java-21-openjdk-devel # for react native builds

  # database
  postgresql

  # containers -- Docker CE, from Docker's own repo (see repo setup below).
  # Podman is in the Brewfile instead: it is daemonless and runs rootless, so a
  # user-space install works. Docker needs a root daemon and a systemd unit,
  # which Homebrew on Linux cannot manage.
  docker-ce
  docker-ce-cli
  containerd.io
  docker-buildx-plugin
  docker-compose-plugin

  # misc
  ccache
)

# --- EXECUTION ---

echo "--- DNF BUNDLE SYNC ---"

# Docker CE is not in Fedora's repos. Add Docker's own before installing.
if ! dnf repolist --enabled 2>/dev/null | grep -q docker-ce; then
  echo "Adding Docker CE repository..."
  sudo dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
fi

echo "Upgrading system packages..."
sudo dnf upgrade -y

echo "Installing/Updating packages from list..."
sudo dnf install -y "${PACKAGES[@]}"

# Socket activation: the daemon starts on the first docker command rather than
# at boot, so restart-policy containers do not resurrect on every reboot.
echo "Enabling Docker socket activation..."
sudo systemctl enable --now docker.socket

# Membership in the docker group is root-equivalent: it grants unsandboxed
# access to the daemon. Podman is the rootless alternative already installed.
if ! id -nG "$USER" | grep -qw docker; then
  echo "Adding $USER to the docker group..."
  sudo usermod -aG docker "$USER"
  echo "Log out and back in for docker group membership to take effect."
fi

echo "System is in sync with bundle!"
