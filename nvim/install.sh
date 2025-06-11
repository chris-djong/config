#!/bin/bash

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

# Temporary folder to store any downloads
TEMP_DIR=$(mktemp -d)

if command -v nvim >/dev/null 2>&1; then

  if [ "$os" == "fedora" ]; then
    sudo dnf install -y nvim
  else
    echo "⚠️ Warning: Latest nvim version can not be installed automatically in debian."
    echo "Please download the binaries manually from https://github.com/neovim/neovim/releases"
  fi
fi

#
# Font
#

FONT_URL=https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Iosevka.zip
wget -O "$TEMP_DIR/font.zip" "$FONT_URL"
unzip "$TEMP_DIR/font.zip" -d "$TEMP_DIR"
mkdir ~/.local/share/fonts
mv "$TEMP_DIR"/*.{ttf,otf} ~/.local/share/fonts
fc-cache -f -v

#
# Plugins
#

# Nvim-Tree
if [ -f ~/.config/nvim/pack/plugins/start/nvim-tree ]; then
  git clone https://github.com/nvim-tree/nvim-tree.lua.git ~/.config/nvim/pack/plugins/start/nvim-tree
fi
if [ -f ~/.config/nvim/pack/plugins/start/nvim-web-devicons ]; then
  git clone https://github.com/nvim-tree/nvim-web-devicons.git ~/.config/nvim/pack/plugins/start/nvim-web-devicons
fi
# CCC
if [ -f ~/.config/nvim/pack/plugins/start/ccc ]; then
  git clone https://github.com/uga-rosa/ccc.nvim.git ~/.config/nvim/pack/plugins/start/ccc
fi
# Which Key
if [ -f ~/.config/nvim/pack/plugins/start/which-key ]; then
  git clone https://github.com/folke/which-key.nvim.git ~/.config/nvim/pack/plugins/start/which-key
fi
# Telescope
if [ -f ~/.config/nvim/pack/plugins/start/telescope ]; then
  git clone https://github.com/nvim-telescope/telescope.nvim.git ~/.config/nvim/pack/plugins/start/telescope
fi
if [ -f ~/.config/nvim/pack/plugins/start/plenary ]; then
  git clone https://github.com/nvim-lua/plenary.nvim.git ~/.config/nvim/pack/plugins/start/plenary
fi
if [ -f ~/.config/nvim/pack/plugins/start/telescope-fzf-native ]; then
  git clone https://github.com/nvim-telescope/telescope-fzf-native.nvim.git ~/.config/nvim/pack/plugins/start/telescope-fzf-native
  cd ~/.config/nvim/pack/plugins/start/telescope-fzf-native && make && cd -
fi
if [ "$os" == "fedora" ]; then
  sudo dnf install -y ripgrep
else
  sudo apt install -y ripgrep
fi
# Tokyonight colorscheme
if [ -f ~/.config/nvim/pack/plugins/start/tokyonight ]; then
  git clone https://github.com/folke/tokyonight.nvim.git ~/.config/nvim/pack/plugins/start/tokyonight
fi
# Conform
if [ -f ~/.config/nvim/pack/plugins/start/conform ]; then
  git clone https://github.com/stevearc/conform.nvim.git ~/.config/nvim/pack/plugins/start/conform
fi
# Nvim-Cmp
if [ -f ~/.config/nvim/pack/plugins/start/nvim-cmp ]; then
  git clone https://github.com/hrsh7th/nvim-cmp.git ~/.config/nvim/pack/plugins/start/nvim-cmp
fi
# Indent blankline
if [ -f ~/.config/nvim/pack/plugins/start/indent-blankline ]; then
  git clone https://github.com/lukas-reineke/indent-blankline.nvim.git ~/.config/nvim/pack/plugins/start/indent-blankline
fi
# Lualine
if [ -f ~/.config/nvim/pack/plugins/start/lualine ]; then
  git clone https://github.com/nvim-lualine/lualine.nvim.git ~/.config/nvim/pack/plugins/start/lualine
fi
# Trouble
if [ -f ~/.config/nvim/pack/plugins/start/trouble ]; then
  git clone https://github.com/folke/trouble.nvim.git ~/.config/nvim/pack/plugins/start/trouble
fi
# Treesitter
if [ -f ~/.config/nvim/pack/plugins/start/nvim-treesitter ]; then
  git clone https://github.com/nvim-treesitter/nvim-treesitter.git ~/.config/nvim/pack/plugins/start/nvim-treesitter
fi
# Todo-comments
if [ -f ~/.config/nvim/pack/plugins/start/todo-comments ]; then
  git clone https://github.com/folke/todo-comments.nvim.git ~/.config/nvim/pack/plugins/start/todo-comments
fi
# Nvim-lint
if [ -f ~/.config/nvim/pack/plugins/start/nvim-lint ]; then
  git clone https://github.com/mfussenegger/nvim-lint.git ~/.config/nvim/pack/plugins/start/nvim-lint
fi

#
# Formatter/linters
# just the global formatters that are not used in specific applications
#

# Shellcheck and shellformat
if [ "$os" == "fedora" ]; then
  sudo dnf install -y shellcheck shfmt
else
  sudo apt install -y shellcheck shfmt
fi

# Luals
wget -O "$TEMP_DIR/lua-ls.tar.gz" https://github.com/LuaLS/lua-language-server/releases/download/3.14.0/lua-language-server-3.14.0-linux-x64.tar.gz
mkdir -p ~/programs/lua-ls
tar -xvzf "$TEMP_DIR/lua-ls.tar.gz" -C ~/programs/lua-ls
ln -s ~/programs/lua-ls/bin/lua-language-server ~/.local/bin

sudo npm install -g bash-language-server
sudo npm install -g vscode-css-languageservice
sudo npm install -g vscode-langserver-languageservice
sudo npm install -g eslint_d
sudo npm install -g typescript-language-server
sudo npm install -g vscode-langservers-extracted

#
# Config
#
ln -s "$(realpath ./init.lua)" ~/.config/nvim/init.lua
ln -s "$(realpath ./lua)" ~/.config/nvim/lua
ln -s "$(realpath ./lsp)" ~/.config/nvim/lsp

# Cleanup
rm -rf "$TEMP_DIR"
