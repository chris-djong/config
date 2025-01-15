{ pkgs, inputs, ... }: {

  # TODO: Find out whether this is needed
  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  # TODO: Find out what gtk exactly is 
  gtk = {
    enable = true;

    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };

  wayland.windowManager.hyprland.settings = {
    # Take the actual flake package
    package =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    "$mod" = "ALT";

    ###################
    ### MY PROGRAMS ###
    ###################

    # See https://wiki.hyprland.org/Configuring/Keywords/

    # Set programs that you use
    $terminal = wezterm
    $fileManager = nemo
    $menu = wofi --show drun
    $browser = firefox

    ################
    ### MONITORS ###
    ################

    monitor = ["eDP-1,highres,0x0,1"];

    #################
    ### AUTOSTART ###
    #################

    exec-once = [
      "waybar"
      "nm-applet --indicator"
      "blueman-applet" 
      "hypridle" 
      "hyprlock" 
    ];

    #############################
    ### ENVIRONMENT VARIABLES ###
    #############################

    env = [
      "XCURSOR_SIZE,12"
      "HYPRCURSOR_SIZE,12" 
    ];

    #####################
    ### LOOK AND FEEL ###
    #####################

    general = {
      gaps_in = 5;
      gaps_out = 10;

      border_size = 2;

      "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg"; 
      "col.inactive_border" = "rgba(595959aa)"; 

      # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
      allow_tearing = false
      layout = dwindle
    };

    decoration = {
      rounding = 4;
      active_opacity = 1.0;
      inactive_opacity = 0.9;

      shadow = {
        enabled = true;
        range = 4;
        render_power = 3;
        color = "rgba(1a1a1aee)" 
      };

      blur = {
        enabled = true;
        size = 3;
        passes = 1;
        vibrancy = 0.1696
      };
    };

    animations = {
        enabled = "yes, please :)";

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        bezier = "easeOutQuint,0.23,1,0.32,1";
        bezier = "easeInOutCubic,0.65,0.05,0.36,1";
        bezier = "linear,0,0,1,1";
        bezier = "almostLinear,0.5,0.5,0.75,1.0";
        bezier = "quick,0.15,0,0.1,1";

        animation = "global, 1, 10, default";
        animation = "border, 1, 5.39, easeOutQuint";
        animation = "windows, 1, 4.79, easeOutQuint";
        animation = "windowsIn, 1, 4.1, easeOutQuint, popin 87%";
        animation = "windowsOut, 1, 1.49, linear, popin 87%";
        animation = "fadeIn, 1, 1.73, almostLinear";
        animation = "fadeOut, 1, 1.46, almostLinear";
        animation = "fade, 1, 3.03, quick";
        animation = "layers, 1, 3.81, easeOutQuint";
        animation = "layersIn, 1, 4, easeOutQuint, fade";
        animation = "layersOut, 1, 1.5, linear, fade";
        animation = "fadeLayersIn, 1, 1.79, almostLinear";
        animation = "fadeLayersOut, 1, 1.39, almostLinear";
        animation = "workspaces, 1, 2, easeOutQuint, slide";
        animation = "workspacesIn, 1, 2, easeOutQuint, slide";
        animation = "workspacesOut, 1, 2, easeOutQuint, slide";
    };

    dwindle = {
        pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # You probably want this
    };

    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    master { 
      new_status = "master";
    };

    # https://wiki.hyprland.org/Configuring/Variables/#misc
    misc {
        force_default_wallpaper = -1; # Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = false; # If true disables the random hyprland logo / anime girl background. :(
    };

    # https://wiki.hyprland.org/Configuring/Variables/#input
    input {
        # TODO: Make internaional keyboard so that "e works 
        kb_layout = "us";
        kb_variant = null
        kb_model = null
        kb_options = "caps:swapescape";
        kb_rules = null;

        follow_mouse = 0;
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false;
        };
    };

    gestures = {
      workspace_swipe= true;
    };

    device = {
      name = "epic-mouse-v1";
      sensitivity = -0.5;
    };

    bind = [ 
        "$mod, F, exec, firefox" ", Print, exec, grimblast copy area"

        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        "$mod, T, exec, $terminal"
        "$mod, B, exec, $browser"
        "$mod, Q, killactive,"
        "$mod, F, exec, $fileManager "
        "$mod, S, fullscreen "
        "$mod, V, togglefloating,"
        "$mod, Space, exec, $menu"

        # Move focus with mainMod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]) 9));

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mod, mouse:272, movewindow" 
        "$mod, mouse:273, resizewindow"
      ];

      # Laptop multimedia keys for volume and LCD brightness
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      # Requires playerctl
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      ##############################
      ### WINDOWS AND WORKSPACES ###
      ##############################

      # Ignore maximize requests from apps. You'll probably like this.
      windowrulev2 = "suppressevent maximize, class:.*";

      # Fix some dragging issues with XWayland
      windowrulev2 = "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0";
  };
}
