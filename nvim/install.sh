#!/bin/bash

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

if [ ! command -v nvim ] >/dev/null 2>&1; then
  echo ""
  echo " Installing nvim"
  if [ "$os" == "fedora" ]; then
    sudo dnf install -y nvim
  else
    echo "⚠️ Warning: Latest nvim version can not be installed automatically in debian."
    echo "Please download the binaries manually from https://github.com/neovim/neovim/releases"
  fi
else
  echo ""
  echo "nvim command found. Skipping installation"
fi

# Some required tools
if [ "$os" == "debian" ]; then
  sudo apt install -y xsel
fi

#
# Font
#

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

# Blink cmp
download_plugin 'https://github.com/Saghen/blink.cmp.git' 'v1.4.0'

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

sudo npm install -g prettier prettier-plugin-tailwindcss @tailwindcss/language-server bash-language-server vscode-css-languageservice vscode-languageserver eslint_d typescript-language-server vscode-langservers-extracted

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

ln -s "$(realpath ./init.lua)" ~/.config/nvim/init.lua
ln -s "$(realpath ./lua)" ~/.config/nvim/lua
ln -s "$(realpath ./lsp)" ~/.config/nvim/lsp

# Cleanup
rm -rf "$TEMP_DIR"
