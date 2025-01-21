{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  # Only import required modules 
  imports = [
    ../../home-manager/modules/bat.nix
    ../../home-manager/modules/eza.nix
    ../../home-manager/modules/git.nix
    ../../home-manager/modules/lazygit.nix
    ../../home-manager/modules/starship.nix
    ../../home-manager/modules/home.nix
    ../../home-manager/modules/tmux.nix
    ../../home-manager/modules/zoxide.nix
    ../../home-manager/modules/shells/bash.nix
    ../../home-manager/modules/shells/zsh.nix
    ../../home-manager/modules/nvim/nvim.nix
    ../../home-manager/modules/direnv.nix
  ];

  home.packages = with pkgs; [
    # CLI utils
    fzf
    fd
    btop
    wget
    ripgrep # better grep for telescope
    gnumake # make command

    # Azure cli things   
    azure-cli
    azure-storage-azcopy

  ];
}
