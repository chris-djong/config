{ inputs, config, pkgs, ... }: {
  programs.hyprland = { enable = true; };

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys =
      [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  environment.systemPackages = with pkgs; [
    wofi # application launcher
    waybar
    gnome-icon-theme # to show correct mouse icons etc
    pavucontrol # to control volume
    networkmanagerapplet # to get wifi connectivity
    wlogout # logout menu with different options
    nemo # file manager
    hyprlock # lock screen
  ];

}
