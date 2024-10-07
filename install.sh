# Install the latest neovim from appimage
wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod +x ./nvim.appimage 

# To be able to run the appimage fuse is required
sudo mv nvim.appimage /usr/bin/nvim

# Install ripgrep for telescope live grep search
sudo apt install -y ripgrep 
# Make comamnd is required for nvim
sudo apt-get install -y build-essential
# Install python3-venv for ruff formatting
sudo apt install -y python3-venv 

# Download the font and install it 
sudo apt-get install -y wget
sudo apt-get install fontconfig
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Iosevka.zip
cd ~/.local/share/fonts
unzip Iosevka.zip
rm Iosevka.zip
fc-cache -fv
