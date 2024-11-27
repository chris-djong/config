#!/bin/bash

# Check if nvim is installed, and install it if it's not found
if ! command -v nvim &> /dev/null; then
  # Install the latest neovim from appimage
  wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod +x ./nvim.appimage 

  # To be able to run the appimage fuse is required
  sudo mv nvim.appimage /usr/bin/nvim
fi

# Install fusermount to run appimages
sudo apt-get install -y fuse3 libfuse2

# Curl is required as well 
sudo apt-get install -y curl

# Install ripgrep for telescope live grep search
sudo apt install -y ripgrep 
# Make comamnd is required for nvim
sudo apt-get install -y build-essential
# Install python3-venv for ruff formatting
sudo apt install -y python3-venv 

# Install tmux
sudo apt-get install tmux

if ! fc-list | grep -qi "IosevkaNerdFont"; then
  # Download the font and install it 
  sudo apt-get install -y wget unzip fontconfig	
  wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Iosevka.zip
  cd ~/.local/share/fonts
  unzip Iosevka.zip
  rm Iosevka.zip
  fc-cache -fv
fi

# Add Caps lock change to dconf 
sudo apt install -y dconf-cli  
dconf write "/org/gnome/desktop/input-sources/xkb-options" "[ 'caps:swapescape']"

# Create the symbolic link
if [[ -L ~/.tmux.conf ]]; then
  unlink ~/.tmux.conf
fi
if [[ -f ~/.tmux.conf ]]; then
  echo "Moving existing tmux.conf to tmux.conf.old"
  mv ~/.tmux.conf ~/.tmux.conf.old
fi
ln -sf ~/config/.tmux.conf ~/.tmux.conf 

mkdir -p ~/.config
if [[ -L ~/.config/nvim ]]; then
  unlink ~/.config/nvim
fi
if [[ -d  ~/.config/nvim ]]; then
  echo "Moving existing ~/.config/nvim to ~/.config/nvim.old"
  mv ~/.config/nvim ~/.config/nvim.old
fi
ln -sf ~/config/.config/nvim ~/.config/nvim
if [[ -L ~/.wezterm.lua ]]; then
  unlink ~/.wezterm.lua
fi
if [[ -f  ~/.wezterm.lua ]]; then
  echo "Moving existing wezterm.lua to wezterm.lua.old"
  mv ~/.wezterm.lua ~/.wezterm.lua.old
fi
ln -sf ~/config/.wezterm.lua ~

# Create the bin directory in case it does not exist yet 
mkdir -p ~/bin

# Some global git config 
git config --global core.editor "nvim"
git config --global alias.st status
git config --global alias.co commit

# Setup some automatic bashrc things 
grep -Fxv -f ~/.bashrc ~/config/.bashrc >> ~/.bashrc

# Setup tmux plugins
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Tmux theme
mkdir -p ~/.config/tmux/plugins/catppuccin
if [[ ! -d ~/.config/tmux/plugins/catppuccin/tmux ]]; then
  git clone -b v2.1.1 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
fi

echo "Installing tmux plugins"
~/.tmux/plugins/tpm/scripts/install_plugins.sh
