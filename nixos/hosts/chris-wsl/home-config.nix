{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  # Only import required modules 
  imports = [
    ../../home-manager/modules/bat.nix
    ../../home-manager/modules/eza.nix
    ../../home-manager/modules/git.nix
    ../../home-manager/modules/lazygit.nix
    ../../home-manager/modules/home.nix
    ../../home-manager/modules/tmux.nix
    ../../home-manager/modules/zoxide.nix
    ../../home-manager/modules/shells/bash.nix
    ../../home-manager/modules/shells/zsh.nix
    ../../home-manager/modules/nvim/nvim.nix
    ../../home-manager/modules/direnv.nix
    ../../home-manager/modules/fzf.nix
  ];

  home.packages = with pkgs; [
    # CLI utils
    fd
    btop
    wget
    ripgrep # better grep for telescope
    jq # to parse json in bash
    gnumake # make command

    # Azure cli things   
    azure-cli
    azure-cli-extensions.containerapp
    azure-storage-azcopy

  ];
}
