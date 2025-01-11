{
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true; 
    xkb.options = "caps:swapescape";
  };
  services.displayManager.defaultSession = "gnome";
  services.libinput.enable = true;
}
