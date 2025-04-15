{ inputs, config, pkgs, services, user, ... }: {
  programs.hyprland = {
    enable = true;
    withUWSM =
      true; # Session Manager. Needed to keep Wifi credentials after reboot for example
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

  # Pipewire and wireplumber are needed for screensharing
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Clipboard and clipboard manager
    wl-clipboard

    wofi # application launcher
    waybar
    gnome-icon-theme # to show correct mouse icons etc
    pavucontrol # to control volume
    networkmanagerapplet # to get wifi connectivity
    wlogout # logout menu with different options
    nemo # file manager
    hyprlock # lock screen
    hypridle # automatically lock screen
    hyprpaper # change wallpaper
    hyprshot # screenshots
    brightnessctl # Required utilities for hyprland
    hyprpolkitagent # Some agent that is requried to request privileges
  ];

}
