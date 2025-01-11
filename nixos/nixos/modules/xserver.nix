{
  services.xserver = {
    enable = true;
    desktopManager = {
      gnome.enable = true;
    };
    xkbOptions = "caps:swapescape";
  };
  services.displayManager.defaultSession = "gnome";
  services.libinput.enable = true;
}
