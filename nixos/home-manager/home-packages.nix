{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Packages in each category are sorted alphabetically

    # Desktop apps
    obsidian
    teams-for-linux
    seafile-client

    # CLI utils
    fzf
    btop
    wget
    ripgrep # better grep for telescope
  ];
}
