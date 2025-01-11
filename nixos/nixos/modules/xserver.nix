{
  services.xserver = {
    enable = true;
    desktopManager = {
      gnome.enable = true;
    };
    xkbOptions = "ctrl:swapcaps";
  };
  services.displayManager.defaultSession = "gnome";
  services.libinput.enable = true;
}
