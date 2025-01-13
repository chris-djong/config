

{ lib, username, host, config, ... }:
with lib; {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = { exec-once = "${startupScript}/bin/start"; };

    xwayland.enable = true;
    systemd.enable = true;

    "$mainMod" = "SUPER";

    bind = [
      "$mainMod, return, exec, wezterm"
      "$mainMod, Q, killactive,"
      "$mainMod SHIFT, M, exit,"
      "$mainMod SHIFT, F, togglefloating,"
      "$mainMod, F, fullscreen,"
      "$mainMod, T, pin,"
      "$mainMod, G, togglegroup,"
      "$mainMod, bracketleft, changegroupactive, b"
      "$mainMod, bracketright, changegroupactive, f"
      "$mainMod, S, exec, rofi -show drun -show-icons"
      "$mainMod, P, pin, active"

      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"

      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      "$mainMod, h, movefocus, l"
      "$mainMod, l, movefocus, r"
      "$mainMod, k, movefocus, u"
      "$mainMod, j, movefocus, d"

      "$mainMod SHIFT, h, movewindow, l"
      "$mainMod SHIFT, l, movewindow, r"
      "$mainMod SHIFT, k, movewindow, u"
      "$mainMod SHIFT, j, movewindow, d"
    ] ++ map (n:
      "$mainMod SHIFT, ${toString n}, movetoworkspace, ${
        toString (if n == 0 then 10 else n)
      }") [ 1 2 3 4 5 6 7 8 9 0 ] ++ map (n:
        "$mainMod, ${toString n}, workspace, ${
          toString (if n == 0 then 10 else n)
        }") [ 1 2 3 4 5 6 7 8 9 0 ];

    binde = [
      "$mainMod SHIFT, h, moveactive, -20 0"
      "$mainMod SHIFT, l, moveactive, 20 0"
      "$mainMod SHIFT, k, moveactive, 0 -20"
      "$mainMod SHIFT, j, moveactive, 0 20"

      "$mainMod CTRL, l, resizeactive, 30 0"
      "$mainMod CTRL, h, resizeactive, -30 0"
      "$mainMod CTRL, k, resizeactive, 0 -10"
      "$mainMod CTRL, j, resizeactive, 0 10"
    ];

    bindm = [
      # Move/resize windows with mainMod + LMB/RMB and dragging
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

  };
}

