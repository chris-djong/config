{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  # Only import required modules 
  imports = [
    ../../home-manager/modules/bat.nix
    ../../home-manager/modules/eza.nix
    ../../home-manager/modules/git.nix
    ../../home-manager/modules/home.nix
    ../../home-manager/modules/tmux.nix
    ../../home-manager/modules/zoxide.nix
    ../../home-manager/modules/shells/bash.nix
    ../../home-manager/modules/shells/zsh.nix
    ../../home-manager/modules/nvim/nvim.nix
    ../../home-manager/modules/fzf.nix
    ../../home-manager/modules/ssh.nix
  ];

  home.packages = with pkgs; [
    # CLI utils
    fd
    htop
    wget
    ripgrep # better grep for telescope
    jq # to parse json in bash
    xsel # for clipboard functionality
    boxes
    tldr

    # Azure cli things   
    (azure-cli.withExtensions [ azure-cli.extensions.containerapp ])
    azure-storage-azcopy
  ];
}
