{ inputs, config, pkgs, ... }: {
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys =
      [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  environment.systemPackages = with pkgs; [
    hyprpaper
    kitty
    rofi-wayland
    waybar
    gnome-icon-theme
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  programs.hyprland = {
    enable = true;

    # TODO: Comment this line in case you want to use a flake input instead
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;

    #   settings = {
    #     "$mod" = "ALT";
    #
    #     bind = [
    #       "$mod, return, exec, wezterm"
    #       "$mod, Q, killactive,"
    #       "$mod SHIFT, M, exit,"
    #       "$mod SHIFT, F, togglefloating,"
    #       "$mod, F, fullscreen,"
    #       "$mod, T, pin,"
    #       "$mod, G, togglegroup,"
    #       "$mod, bracketleft, changegroupactive, b"
    #       "$mod, bracketright, changegroupactive, f"
    #       "$mod, S, exec, rofi -show drun -show-icons"
    #       "$mod, P, pin, active"
    #
    #       ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
    #       ",XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
    #
    #       "$mod, left, movefocus, l"
    #       "$mod, right, movefocus, r"
    #       "$mod, up, movefocus, u"
    #       "$mod, down, movefocus, d"
    #
    #       "$mod, h, movefocus, l"
    #       "$mod, l, movefocus, r"
    #       "$mod, k, movefocus, u"
    #       "$mod, j, movefocus, d"
    #
    #       "$mod SHIFT, h, movewindow, l"
    #       "$mod SHIFT, l, movewindow, r"
    #       "$mod SHIFT, k, movewindow, u"
    #       "$mod SHIFT, j, movewindow, d"
    #     ] ++ map (n:
    #       "$mod SHIFT, ${toString n}, movetoworkspace, ${
    #         toString (if n == 0 then 10 else n)
    #       }") [ 1 2 3 4 5 6 7 8 9 0 ] ++ map (n:
    #         "$mod, ${toString n}, workspace, ${
    #           toString (if n == 0 then 10 else n)
    #         }") [ 1 2 3 4 5 6 7 8 9 0 ];
    #
    #     binde = [
    #       "$mod SHIFT, h, moveactive, -20 0"
    #       "$mod SHIFT, l, moveactive, 20 0"
    #       "$mod SHIFT, k, moveactive, 0 -20"
    #       "$mod SHIFT, j, moveactive, 0 20"
    #
    #       "$mod CTRL, l, resizeactive, 30 0"
    #       "$mod CTRL, h, resizeactive, -30 0"
    #       "$mod CTRL, k, resizeactive, 0 -10"
    #       "$mod CTRL, j, resizeactive, 0 10"
    #     ];
    #
    #     bindm = [
    #       # Move/resize windows with mod + LMB/RMB and dragging
    #       "$mod, mouse:272, movewindow"
    #       "$mod, mouse:273, resizewindow"
    #     ];
    #   };
    # };
  };
}
