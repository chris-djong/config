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

# Small helper function to create the symlink
create_symlink() {
  local source_path="$1"
  local link_path="$2"

  # Check if the link path is a symlink, and if so, remove it
  if [[ -L "$link_path" ]]; then
    unlink "$link_path"
  fi

  # Check if the link path is a regular file, and if so, move it to .old
  if [[ -e "$link_path" ]]; then
    echo "Moving existing $link_path to ${link_path}.old"
    mv "$link_path" "${link_path}.old"
  fi

  # Create the symlink
  ln -sf "$source_path" "$link_path"
}

create_symlink "~/config/dotfiles/.tmux.conf"  "~/.tmux.conf" 
create_symlink "~/config/dotfiles/.config/nvim"  "~/.config/nvim" 
create_symlink "~/config/dotfiles/.wezterm.lua" "~/.wezterm.lua" 

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

echo "Installing tmux plugins"
~/.tmux/plugins/tpm/scripts/install_plugins.sh

sudo apt install zsh
if [[ ! -d ~/.zsh/zsh-autosuggestions ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi
if [[ ! -d ~/.zsh/zsh-syntax-highlighting ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
fi

# Install spaceship prompt
if [[ ! -d ~/.zsh/spaceship ]]; then
  git clone --depth=1 https://github.com/spaceship-prompt/spaceship-prompt.git ~/.zsh/spaceship
fi

# Install zoxide
sudo apt install zoxide

# Install eza
if ! command -v eza &> /dev/null; then
  sudo mkdir -p /etc/apt/keyrings
  wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
  echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
  sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
  sudo apt update
  sudo apt install -y eza
fi

create_symlink "~/config/dotfiles/.zshrc" "~/.zshrc" 
create_symlink "~/config/dotfiles/.config/spaceship.zsh" "~/.config/spaceship.zsh" 

# Make zsh the default shell
chsh -s /bin/zsh

echo "Installing CLI Tools"
sudo apt install tldr

echo "Installing fzf"
wget https://github.com/junegunn/fzf/releases/download/v0.56.3/fzf-0.56.3-linux_amd64.tar.gz
tar -xf fzf-0.56.3-linux_amd64.tar.gz
mv fzf ~/bin 
rm fzf-0.56.3-linux_amd64.tar.gz

echo "Installing better find"
sudo apt install fd-find
ln -s $(which fdfind) ~/bin/fd

# Better cat 
sudo apt install bat
# There is a clash with bat link on debian, hence batcat
ln -s /usr/bin/batcat ~/bin/bat
mkdir -p "$(batcat --config-dir)/themes"
cd "$(batcat --config-dir)/themes"
curl -O https://raw.githubusercontent.com/folke/tokyonight.nvim/refs/heads/main/extras/sublime/tokyonight_night.tmTheme
batcat cache --build
