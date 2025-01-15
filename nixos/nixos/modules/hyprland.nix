{ inputs, config, pkgs, services, user, ... }: {
  programs.hyprland = { enable = true; };

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys =
      [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  # Create a hyprlock pam file so that we can unlock from here
  security.pam.services.hyprlock = { };

  # Hyprlock is used to authenticate the user. 
  # Yes I know this is not secure, but my disk is encrypted either way 
  services.greetd = {
    enable = true;
    settings = rec {
      # Initial session is executed automatically
      initial_session = {
        command = "Hyprland";
        user = user;
      };
      default_session = initial_session;
    };
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
    hypridle # automatically lock screen
  ];

}
