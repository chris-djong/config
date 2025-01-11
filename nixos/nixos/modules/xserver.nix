{
  services.xserver = {
    enable = true;
    desktopManager = {
      gnome.enable = true;
    };
    libinput.enable = true;
  };
  services.displayManager.defaultSession = "gnome";
}
