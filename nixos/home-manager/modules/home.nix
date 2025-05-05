{ user, homeStateVersion, isGenericLinux, pkgs, ... }: {

  # Needs to be set whenever we are on non nixos
  targets.genericLinux.enable = isGenericLinux;

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;
  };

  # Allow home-manager to manage itself
  programs.home-manager.enable = true;

  home.sessionVariables = rec {
    XDG_BIN_HOME = "$HOME/.local/bin";
    EDITOR = "nvim";
  };
  home.sessionPath = [
    "./node_modules/.bin"
    "$HOME/bin" # needed by docker rootless on non nixos systems
    "$HOME/.local/bin"
  ];

  home.file."scripts" = {
    source = ../../scripts;
    recursive = true;
  };

  home.file."Pictures" = {
    source = ../../../pictures;
    recursive = true;
  };
}

