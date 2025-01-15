{
  home.sessionVariables = rec {
    XDG_BIN_HOME = "$HOME/.local/bin";
    EDITOR = "nvim";
  };
  home.sessionPath = [ "./node_modules/.bin" "$HOME/.local/bin" ];

  home.file."scripts" = {
    source = ../../scripts;
    recursive = true;
  };

  home.file."Pictures" = {
    source = ../../../pictures;
    recursive = true;
  };
}

