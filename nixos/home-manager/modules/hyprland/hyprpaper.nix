{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "off";
      splash = false;
      preload = [ "$HOME/Pictures/wallpapers/2.jpg" ];

      wallpapers = [ ",$HOME/Pictures/wallpapers/2.jpg" ];
    };
  };
}
