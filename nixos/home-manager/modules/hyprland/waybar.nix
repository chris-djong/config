{ ... }: {
  programs.waybar = {
    enable = true;
    settings = [{
      modules-left = [ ];
      modules-center = [ "clock" "idle_inhibitor" ];
      modules-right = [ "tray" "pulseaudio" "battery" ];
      battery = {
        format = "{icon}";
        states = {
          warning = 40;
          critical = 20;
        };
        format-icons = [ "" "" "" "" "" ];
      };
      clock = { format = "{:%a, %d. %b  %H:%M}"; };
      pulseaudio = {
        format = "{icon} ";
        format-bluetooth = "{icon}";
        format-bluetooth-muted = " {icon}";
        format-muted = "0% {icon}";
        format-source = "";
        format-source-muted = "";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [ "" "" "" ];
        };
        "on-click" = "pavucontrol";
      };
      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
      };
    }];
    style = ''
      * {
        border: none;
        font-family:
          Font Awesome,
          Roboto,
          Arial,
          sans-serif;
        font-size: 13px;
        color: #ffffff;
        border-radius: 20px;
      }

      window#waybar {
        background: rgba(0, 0, 0, 0);
      }
      /*-----module groups----*/
      .modules-right {
        background-color: rgba(0, 43, 51, 0.85);
      }
      .modules-center {
        background-color: rgba(0, 43, 51, 0.85);
      }
      .modules-left {
        background-color: rgba(0, 119, 179, 0.6);
      }
      #clock {
        padding: 0px 10px;
      }
      #idle_inhibitor {
        padding: 0px 10px;
      }
      #battery {
        margin-right: 15px;
      }
      #battery.charging {
        color: green;
      }
      #battery.warning-discharging {
        color: yellow;
      }
      #battery.critical-discharging {
        color: red;
      }
      #power {
        margin: 0px 5px;
      }
      #pulseaudio {
        margin: 0px 5px;
      }'';
  };

}
