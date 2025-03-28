let theme = import ../theme.nix;
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      # BACKGROUND
      background = {
        # monitor =
        path = "$HOME/Pictures/wallpapers/2.jpg";
        color = "#00000000";
        blur_passes = 0;
        contrast = 1;
        brightness = 0.5;
        vibrancy = 0.2;
        vibrancy_darkness = 0.2;
      };

      # GENERAL
      general = {
        no_fade_in = true; # on logout
        no_fade_out = false; # on login
        hide_cursor = true;
        grace = 0;
        disable_loading_bar = true;
      };

      # AUTENTICATION
      auth = {
        "pam:enabled" = true;
        "pam:module" = "hyprlock";
      };

      # INPUT FIELD
      input-field = {
        # monitor =
        size = "250, 60";
        outline_thickness = 2;
        dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.35; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true;
        outer_color = "#ffffffff";
        font_color = "$foreground";
        fade_on_empty = false;
        rounding = -1;
        check_color = "rgb(204, 136, 34)";
        fail_color = "rgb(255,0,0)";
        fail_text = "Passwuerd $ATTEMPTSx falsch";
        fail_timeout = 5000;
        placeholder_text =
          ''<i><span foreground="##000000">Passwuerd w.e.g...</span></i>'';
        hide_input = false;
        position = "0, -200";
        halign = "center";
        valign = "center";
      };

      # DATE
      label = [
        {
          # monitor =
          text = ''cmd[update:1000] echo "$(date +"%A, %B %d")"'';
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 22;
          font_family = "JetBrains Mono";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }

        # TIME
        {
          # monitor = 
          text = ''cmd[update:1000] echo "$(date +"%-I:%M")"'';
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 95;
          font_family = "JetBrains Mono Extrabold";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];

    };

  };
}
