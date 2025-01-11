{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Packages in each category are sorted alphabetically

    # Desktop apps
    obsidian
    teams-for-linux

    # CLI utils
    fzf
    htop
    wget
    ripgrep # better grep for telescope
  ];
}
