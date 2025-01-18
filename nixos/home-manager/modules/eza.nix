{
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    git = true;
    colors = "always";
    icons = "always";
    extraOptions = [ "--group-directories-first" "--header" ];
  };
}
