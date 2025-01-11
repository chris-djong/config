{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    # Desktop apps
    chromium
    discord
    obsidian

    # CLI utils
    wget
    git
    btop
    unzip
    lazygit

    # Other
    home-manager
  ];

  fonts.packages = with pkgs; [
  ];
}
