{
  services.xserver = {
    enable = true;
    desktopManager = {
      gnome.enable = true;
    };
  };
  services.displayManager.defaultSession = "gnome";
  services.libinput.enable = true;
}
