{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  # Import all the modules 
  imports = [
    ../../home-manager/modules/nvim/nvim.nix
    ../../home-manager/modules/wezterm/wezterm.nix
    ../../home-manager/modules/bat.nix
    ../../home-manager/modules/firefox.nix
    ../../home-manager/modules/git.nix
    ../../home-manager/modules/lazygit.nix
    ../../home-manager/modules/starship.nix
    ../../home-manager/modules/tmux.nix
    ../../home-manager/modules/home.nix
    ../../home-manager/modules/zoxide.nix
    ../../home-manager/modules/zsh.nix
    ../../home-manager/modules/bash.nix
    ../../home-manager/modules/hyprland.nix
  ];

  home.packages = with pkgs; [
    # Packages in each category are sorted alphabetically

    # Desktop apps
    obsidian
    teams-for-linux
    seafile-client

    # CLI utils
    fzf
    fd
    btop
    wget
    ripgrep # better grep for telescope
  ];
}
