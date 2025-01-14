{
  environment.sessionVariables = rec {
    XDG_BIN_HOME = "$HOME/.local/bin";
    EDITOR = "nvim";
  };
  home.sessionPath = [ "./node_modules/.bin" "$HOME/.local/bin" ];
}

