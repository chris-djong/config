{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  # Import all the modules 
  imports = [
    ../../home-manager/modules/nvim/nvim.nix
    ../../home-manager/modules/wezterm/wezterm.nix
    ../../home-manager/modules/hyprland
    ../../home-manager/modules/bat.nix
    ../../home-manager/modules/eza.nix
    ../../home-manager/modules/firefox.nix
    ../../home-manager/modules/git.nix
    ../../home-manager/modules/lazygit.nix
    ../../home-manager/modules/starship.nix
    ../../home-manager/modules/tmux.nix
    ../../home-manager/modules/home.nix
    ../../home-manager/modules/zoxide.nix
    ../../home-manager/modules/shells/bash.nix
    ../../home-manager/modules/shells/zsh.nix
    ../../home-manager/modules/direnv.nix
    ../../home-manager/modules/fzf.nix
  ];

  home.packages = with pkgs; [
    # Packages in each category are sorted alphabetically

    # Desktop apps
    obsidian
    teams-for-linux
    seafile-client

    # CLI utils
    fd
    btop
    wget
    ripgrep # better grep for telescope
  ];
}
