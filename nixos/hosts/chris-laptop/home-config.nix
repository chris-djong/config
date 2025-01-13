{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  # Import all the modules 
  imports = [ ../../home-manager/modules ];

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
