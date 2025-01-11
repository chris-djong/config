{
  environment.sessionVariables = rec {
    EDITOR = "nvim";
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "./node_modules/.bin"
      "${XDG_BIN_HOME}"
    ];
  };
}
