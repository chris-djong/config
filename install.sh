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
  echo "Usage: $0 <debian|fedora> [proxy_url]"
  exit 1
fi

os="$1"
proxy_url="$2"

# OS specific installations
case "$os" in
debian)
  echo "🔵 Running Debian install.."
  sudo apt install -y tmux bat zoxide curl unzip xclip
  ;;
fedora)
  echo "🟣 Running Fedora install.."
  sudo dnf install -y fzf gnome-tweaks tmux bat zoxide xclip
  ;;
*)
  echo "❌ Error: Invalid OS '$os'"
  echo "Usage: $0 <debian|fedora> [proxy_url]"
  exit 1
  ;;
esac

if [ ! -d ~/.fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  "$HOME/.fzf/install" --bin
  ln -sf "$HOME/.fzf/bin/fzf" "$HOME/.local/bin/"

fi

if [ ! -d ~/.tmux/plugins/tpm ]; then
  echo "Installing tmux plugin manager"
  read -p "‼️ Don't forget to install your tmux plugins using <PREFIX> + I"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# 🔄 Common setup for both OSes
echo "📦 Creating bash setup..."

mkdir -p ~/.local/bin

# Function to handle symlinks
link_file() {
  local target="$1"
  local link_name="$2"

  if [ -L "$link_name" ] || [ -f "$link_name" ]; then
    echo "⚠️  Skipping: '$link_name' already exists."
  else
    ln -s "$(realpath "$target")" "$link_name"
    echo "🟢 Linked: '$link_name' -> $(realpath "$target")"
  fi
}

link_file ./bash/bashrc "$HOME/.bashrc"
link_file ./bash/aliases "$HOME/.bash_aliases"
link_file ./bash/prompt "$HOME/.bash_prompt"

# 🧭 Handle optional proxy URL
if [[ -n "$proxy_url" ]]; then
  echo "🌐 Setting proxy to: $proxy_url"
  proxy_file="$HOME/.bash_proxy"

  cat >"$proxy_file" <<EOF
PROXY="$proxy_url" 
export http_proxy="\$PROXY" 
export https_proxy="\$PROXY" 
export HTTP_PROXY="\$PROXY" 
export HTTPS_PROXY="\$PROXY" 
export no_proxy="localhost" 
export NO_PROXY="localhost" 
EOF
  echo "🟢 Proxy config written to $proxy_file"
fi

link_file ./dotfiles/tmux.conf "$HOME/.tmux.conf"

echo "✅ Installation complete."
