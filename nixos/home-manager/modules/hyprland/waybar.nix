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
      clock = {
        format = "{:%a, %d. %b  %H:%M}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "year";
          mode-mon-col = 3;
          on-scroll = 1;
          format = {
            months = "<span color='${theme.green}'><b>{}</b></span>";
            weekdays = "<span color='${theme.yellow}'><b>{}</b></span>";
            days = "<span color='${theme.violet}'>{}</span>";
            today = "<span color='${theme.red}'><b><u>{}</u></b></span>";
            weeks = "<span color='${theme.fg}'><b>{}</b></span>";
          };
        };
        actions = {
          on-click-right = "mode";
          on-scroll-up = "shift_up";
          on-scroll-down = "shift_down";
        };
      };
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
