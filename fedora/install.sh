#!/bin/bash

# Need for our symlink paths
mkdir -p ~/.local/bin

# Swap ESC and CAPS -> use the GUI for this
sudo dnf install gnome-tweak

# Tmux
sudo dnf install tmux

# Some useful command utilities
sudo dnf install bat
sudo dnf install zoxide

TEMP_DIR=$(mktemp -d)
wget -O "$TEMP_DIR/eza.tar.gz" https://github.com/eza-community/eza/releases/download/v0.21.4/eza_aarch64-unknown-linux-gnu.tar.gz
mkdir -p ~/programs/eza
tar -xvzf "$TEMP_DIR/eza.tar.gz" ~/programs/eza
# TODO: This does not work yet
rm -rf "$TEMP_DIR"
