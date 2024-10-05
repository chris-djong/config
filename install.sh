# Install ripgrep for telescope live grep search
sudo apt install ripgrep 
# Install python3-venv for ruff formatting
sudo apt install python3-venv 

# Download the font and install it 
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Iosevka.zip
cd ~/.local/share/fonts
unzip Iosevka.zip
rm Iosevka.zip
fc-cache -fv
