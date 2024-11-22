# Install the latest neovim from appimage
wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod +x ./nvim.appimage 

# To be able to run the appimage fuse is required
sudo mv nvim.appimage /usr/bin/nvim

# Install fusermount to run appimages
sudo apt-get install -y fuse3, libfuse2

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

# Download the font and install it 
sudo apt-get install -y wget unzip fontconfig	
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Iosevka.zip
cd ~/.local/share/fonts
unzip Iosevka.zip
rm Iosevka.zip
fc-cache -fv

# Add Caps lock change to dconf 
sudo apt install -y dconf-cli  
dconf write "/org/gnome/desktop/input-sources/xkb-options" "[ 'caps:swapescape']"

# Create the symbolic link
ln -s ~/config/.tmux.conf ~/.tmux.conf 
mkdir -p ~/.config
ln -s ~/config/.config/nvim ~/.config/nvim
