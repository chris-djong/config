#!/bin/bash

# First install nvim
sudo dnf install nvim

# Temporary folder to store any downloads
TEMP_DIR=$(mktemp -d)

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
git clone https://github.com/nvim-tree/nvim-tree.lua.git ~/.config/nvim/pack/plugins/start/nvim-tree
git clone https://github.com/nvim-tree/nvim-web-devicons.git ~/.config/nvim/pack/plugins/start/nvim-web-devicons
# CCC
git clone https://github.com/uga-rosa/ccc.nvim.git ~/.config/nvim/pack/plugins/start/ccc
# Which Key
git clone https://github.com/folke/which-key.nvim.git ~/.config/nvim/pack/plugins/start/which-key
# Telescope
git clone https://github.com/nvim-telescope/telescope.nvim.git ~/.config/nvim/pack/plugins/start/telescope
git clone https://github.com/nvim-lua/plenary.nvim.git ~/.config/nvim/pack/plugins/start/plenary
git clone https://github.com/nvim-telescope/telescope-fzf-native.nvim.git ~/.config/nvim/pack/plugins/start/telescope-fzf-native
cd ~/.config/nvim/pack/plugins/start/telescope-fzf-native && make && cd -
sudo dnf install ripgrep
# Tokyonight colorscheme
git clone https://github.com/folke/tokyonight.nvim.git ~/.config/nvim/pack/plugins/start/tokyonight
# Conform
git clone https://github.com/stevearc/conform.nvim.git ~/.config/nvim/pack/plugins/start/conform
# Nvim-Cmp
git clone https://github.com/hrsh7th/nvim-cmp.git ~/.config/nvim/pack/plugins/start/nvim-cmp
# Indent blankline
git clone https://github.com/lukas-reineke/indent-blankline.nvim.git ~/.config/nvim/pack/plugins/start/indent-blankline
# Lualine
git clone https://github.com/nvim-lualine/lualine.nvim.git ~/.config/nvim/pack/plugins/start/lualine
# Trouble
git clone https://github.com/folke/trouble.nvim.git ~/.config/nvim/pack/plugins/start/trouble
# Treesitter
git clone https://github.com/nvim-treesitter/nvim-treesitter.git ~/.config/nvim/pack/plugins/start/nvim-treesitter
# Todo-comments
git clone https://github.com/folke/todo-comments.nvim.git ~/.config/nvim/pack/plugins/start/todo-comments
# Nvim-lint
git clone https://github.com/mfussenegger/nvim-lint.git ~/.config/nvim/pack/plugins/start/nvim-lint

#
# Formatter/linters
# just the global formatters that are not used in specific applications
#

# Shellcheck and shellformat
sudo dnf install shellcheck shfmt

# Luals
wget -O "$TEMP_DIR/lua-ls.tar.gz" https://github.com/LuaLS/lua-language-server/releases/download/3.14.0/lua-language-server-3.14.0-linux-x64.tar.gz
mkdir -p ~/programs/bin
mkdir -p ~/programs/lua-ls
tar -xvzf "$TEMP_DIR/lua-ls.tar.gz" -C ~/programs/lua-ls
ln -s ~/programs/lua-ls/bin/lua-language-server ~/programs/bin/lua-language-server

# Bashls
sudo npm install -g bash-language-server

# CssLs
sudo npm install -g vscode-css-languageservice

#
# Config
#
ln -s "$(realpath ./init.lu)" ~/.config/nvim/init.lua
ln -s "$(realpath ./lua)" ~/.config/nvim/lua
ln -s "$(realpath ./lsp)" ~/.config/nvim/lsp

# Cleanup
rm -rf "$TEMP_DIR"
