let theme = import ./theme.nix;
in {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    settings = {
      add_newline = false;
      format = "$direnv$python$hostname $git_branch $directory$character ";
      hostname = {
        format =
          "[$ssh_symbol](${theme.red} dimmed bold)[$hostname](${theme.yellow} dimmed bold)";
        ssh_only = false;
        disabled = false;
      };
      direnv = {
        format = "$loaded";
        disabled = false;
        loaded_msg = "📂 ";
        unloaded_msg = "";
      };
      python = {
        format = "$virtualenv";
        symbol = "🐍 ";
      };
      git_branch = {
        format = "[$branch](${theme.blue})";

      };
      directory = {
        read_only = " 🔒";
        truncate_to_repo = false;
      };
      character = {
        format = "$symbol";
        success_symbol = "[:](bold ${theme.green})";
        error_symbol = "[:](bold ${theme.red})";
      };
    };
  };
}
