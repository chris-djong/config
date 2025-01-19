{ ... }:
let theme = import ../theme.nix;
in {
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
        margin-top: 5px;
        background-color: ${theme.bg};
      }
      .modules-center {
        margin-top: 5px;
        background-color: ${theme.bg};
      }
      .modules-left {
        margin-top: 5px;
        background-color: ${theme.bg};
      }
      #clock {
        padding: 0px 10px;
      }
      #idle_inhibitor {
        padding: 0px 10px;
      }
      #idle_inhibitor.activated {
        color: ${theme.green};
      }
      #battery {
        margin-right: 15px;
      }
      #battery.charging {
        color: ${theme.green};
      }
      #battery.warning-discharging {
        color: ${theme.yellow};
      }
      #battery.critical-discharging {
        color: ${theme.red};
      }
      #power {
        margin: 0px 5px;
      }
      #pulseaudio {
        margin: 0px 5px;
      }'';

  };

}
