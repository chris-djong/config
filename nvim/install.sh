#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status

if [ "$EUID" -eq 0 ]; then
  echo "❌ Please do NOT run this script as root or with sudo."
  echo "Run it as a regular user."
  exit 1
fi

# Check for argument
if [[ $# -lt 1 ]]; then
  echo "❌ Error: No OS specified."
  echo "Usage: $0 <debian|fedora>"
  exit 1
fi

os="$1"
if [[ "$os" != "fedora" && "$os" != "debian" ]]; then
  echo "❌ Error: Invalid OS."
  echo "Usage: $0 <debian|fedora>"
  exit 1
fi

header_log() {
  echo ""
  echo "##################"
  echo "$1"
  echo "##################"
  echo ""
}

# Temporary folder to store any downloads
TEMP_DIR=$(mktemp -d)

if ! command -v nvim >/dev/null 2>&1; then
  echo ""
  echo "Neovim not found, trying installation"
  if [ "$os" == "fedora" ]; then
    sudo dnf install -y nvim
  else
    echo "⚠️ Warning: Downloading nvim version 0.11.2 manually please check for updates"
    read -p "Would you like to proceed? [y/N] " confirm
    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
      echo "Aborting installation"
      exit 1
    fi
    wget -O "$TEMP_DIR/nvim.tar.gz" https://github.com/neovim/neovim/releases/download/v0.11.2/nvim-linux-x86_64.tar.gz
    mkdir -p "$HOME/programs"
    tar xzvf "$TEMP_DIR/nvim.tar.gz" -C "$HOME/programs"
    mv "$HOME/programs/nvim-linux-x86_64" "$HOME/programs/nvim"
    rm "$TEMP_DIR/nvim.tar.gz"
    ln -sf "$HOME/programs/nvim/bin/nvim" "$HOME/.local/bin"
  fi
else
  echo ""
  echo "nvim command found. Skipping installation"
fi

#
# Font
#
#
read -p "Install fonts? [y/N] " confirm

if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
  # Check if the font is already installed
  FONT_NAME="IosevkaNerdFont-Medium.ttf"
  FONT_PATH="$HOME/.local/share/fonts/$FONT_NAME"
  if [ ! -e "$FONT_PATH" ]; then
    header_log "Downloading font"
    FONT_URL=https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Iosevka.zip
    wget -O "$TEMP_DIR/font.zip" "$FONT_URL"
    unzip "$TEMP_DIR/font.zip" -d "$TEMP_DIR"
    mkdir -p ~/.local/share/fonts
    mv "$TEMP_DIR"/*.{ttf,otf} ~/.local/share/fonts
    fc-cache -f -v
  else
    echo ""
    echo "$FONT_NAME is already installed. Skipping download"
  fi
fi

#
# Plugins
#

download_plugin() {
  PLUGIN_NAME=$(basename "$1" .git)
  PLUGIN_PATH="$HOME/.config/nvim/pack/plugins/start/$PLUGIN_NAME"
  BRANCH_NAME="$2"
  if [ ! -e "$PLUGIN_PATH" ]; then
    echo ""
    echo "Downloading $1"
    if [ -n "$BRANCH_NAME" ]; then
      echo "Downloading branch $BRANCH_NAME"
      git clone --branch "$BRANCH_NAME" --single-branch "$1" "$PLUGIN_PATH"
    else
      git clone "$1" "$PLUGIN_PATH"
    fi
  fi
}

header_log "Downloading plugins"
# Snacks
download_plugin 'https://github.com/folke/snacks.nvim.git'
download_plugin 'https://github.com/nvim-tree/nvim-web-devicons.git'
download_plugin 'https://github.com/nvim-lua/plenary.nvim.git'
if [ "$os" == "fedora" ]; then
  sudo dnf install -y ripgrep fd
else
  sudo apt install -y ripgrep fd-find
fi

# CCC
download_plugin 'https://github.com/uga-rosa/ccc.nvim.git'

# Which Key
download_plugin 'https://github.com/folke/which-key.nvim.git'

# Tokyonight colorscheme
download_plugin 'https://github.com/folke/tokyonight.nvim.git'

# Conform
download_plugin 'https://github.com/stevearc/conform.nvim.git'

# Nvim blame
download_plugin "https://github.com/f-person/git-blame.nvim.git"

# Blink cmp
download_plugin 'https://github.com/Saghen/blink.cmp.git' 'v1.6.0'

# Lualine
download_plugin 'https://github.com/nvim-lualine/lualine.nvim.git'

# Trouble
download_plugin 'https://github.com/folke/trouble.nvim.git'

# Treesitter
download_plugin 'https://github.com/nvim-treesitter/nvim-treesitter.git'

# Todo-comments
download_plugin 'https://github.com/folke/todo-comments.nvim.git'

# Nvim-lint
download_plugin 'https://github.com/mfussenegger/nvim-lint.git'

#
# Formatter/linters
# just the global formatters that are not used in specific applications
#

header_log "Installing lsps/formatters"
# Shellcheck and shellformat
if [ "$os" == "fedora" ]; then
  sudo dnf install -y shellcheck shfmt
else
  sudo apt install -y shellcheck shfmt
fi

sudo npm install -g @fsouza/prettierd @taildwindcss/language-server bash-language-server vscode-css-languageservice vscode-languageserver eslint_d typescript-language-server vscode-langservers-extracted

read -p 'Some language servers need to be installed on a per project basis. See code for details'
echo 'npm install prettier-plugin-tailwindcss '

# Luals
if [ ! -e ~/.local/bin/lua-language-server ]; then
  echo ""
  echo "Installing lua-language-server"
  wget -O "$TEMP_DIR/lua-ls.tar.gz" https://github.com/LuaLS/lua-language-server/releases/download/3.14.0/lua-language-server-3.14.0-linux-x64.tar.gz
  mkdir -p ~/programs/lua-ls
  tar -xvzf "$TEMP_DIR/lua-ls.tar.gz" -C ~/programs/lua-ls
  ln -s ~/programs/lua-ls/bin/lua-language-server ~/.local/bin
fi

#
# Config
#

ln -sf "$(realpath ./init.lua)" ~/.config/nvim/init.lua
ln -sf "$(realpath ./lua)" ~/.config/nvim/lua
ln -sf "$(realpath ./lsp)" ~/.config/nvim/lsp

# Cleanup
rm -rf "$TEMP_DIR"
