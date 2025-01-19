{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xkb.options = "caps:swapescape";
  };

  environment.systemPackages = with pkgs; [ xl-sel ];
}
