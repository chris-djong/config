{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  # Import all the modules 
  imports = [
    ../../home-manager/modules/nvim/nvim.nix
    ../../home-manager/modules/wezterm/wezterm.nix
    ../../home-manager/modules/hyprland
    ../../home-manager/modules/bat.nix
    ../../home-manager/modules/eza.nix
    ../../home-manager/modules/librewolf.nix
    ../../home-manager/modules/git.nix
    ../../home-manager/modules/tmux.nix
    ../../home-manager/modules/home.nix
    ../../home-manager/modules/zoxide.nix
    ../../home-manager/modules/shells/bash.nix
    ../../home-manager/modules/shells/zsh.nix
    ../../home-manager/modules/fzf.nix
    ../../home-manager/modules/ssh.nix
  ];

  home.packages = with pkgs; [
    # Desktop apps
    obsidian
    teams-for-linux
    seafile-client
    gimp
    discord

    # Emoji picker
    smile

    # CLI utils
    fd
    htop
    wget
    ripgrep # better grep for telescope
    jq # to parse json in bash
    boxes
    tldr
    unzip
  ];
}
