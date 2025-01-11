{ config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases =
     {
        vi = "nvim";
        vim = "nvim";
	set_env = ". .venv/bin/activate";
     };

    sessionVariables = {
        BAT_THEME = "tokyonight_night";
    };

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";
  };
}
