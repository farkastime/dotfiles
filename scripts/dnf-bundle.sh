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
)

# --- EXECUTION ---

echo "--- DNF BUNDLE SYNC ---"
echo "Checking for system updates..."
sudo dnf check-update || true

echo "Installing/Updating packages from list..."
sudo dnf install -y "${PACKAGES[@]}"

echo "System is in sync with bundle!"
