let theme = import ./theme.nix;
in {
  programs.lazygit = {
    enable = true;
    settings = {
      gui.showIcons = true;
      gui.theme = {
        lightTheme = false;
        activeBorderColor = [ "${theme.green}" "bold" ];
        inactiveBorderColor = [ "${theme.inactive_bg}" ];
        selectedLineBgColor = [ "${theme.bg}" ];
      };
    };
  };
}
