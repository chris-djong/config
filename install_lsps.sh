# Just some info on how to install the LSP. Feel free to use the venv as well if you think that is better
# LSPs
pip install --user basedpyright
pip install --user ruff
npm install -g vscode-langservers-extracted
npm install -g @tailwindcss/language-server
npm install -g @angular/language-server
npm install -g eslint_d
npm install -g typescript typescript-language-server
apt install clangd

# Formatters 
pip install --user https://github.com/nvbn/thefuck/archive/master.zip
pip install --user sqlfluff
apt install clang-format

# LazyGit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
