{ user, homeStateVersion, isGenericLinux, ... }: {

  # Needs to be set whenever we are on non nixos
  targets.genericLinux.enable = isGenericLinux;

  # Allow home-manager to manage itself
  programs.home-manager.enable = true;

  home.sessionVariables = rec {
    XDG_BIN_HOME = "$HOME/.local/bin";
    EDITOR = "nvim";
  };
  home.sessionPath = [ "./node_modules/.bin" "$HOME/.local/bin" ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;
  };

  home.file."scripts" = {
    source = ../../scripts;
    recursive = true;
  };

  home.file."Pictures" = {
    source = ../../../pictures;
    recursive = true;
  };
}

