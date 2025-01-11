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
	# Use fd instead of fzf for faster searches
	FZF_DEFAULT_COMMAND = "fd --hidden --strip-cwd-prefix --exclude .git";
	FZF_CTRL_T_COMMAND = "$FZF_DEFAULT_COMMAND";
	FZF_ALT_C_COMMAND = "fd --type=d --hidden --strip-cwd-prefix --exclude .git"; 
	FZF_CTRL_T_OPTS="--preview 'if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --coolor=always --line-range :500 {}; fi'";
	FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'";
    };

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";
  };
}
