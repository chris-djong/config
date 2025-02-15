{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "off";
      splash = false;
      preload = [ "$HOME/Pictures/wallpapers/2.jpg" ];
      wallpaper = [
        "eDP-1,$HOME/Pictures/wallpapers/2.jpg"
        "DP-4,$HOME/Pictures/wallpapers/2.jpg"
        "DP-3,$HOME/Pictures/wallpapers/2.jpg"
      ];
    };
  };
}
