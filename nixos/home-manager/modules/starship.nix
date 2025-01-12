{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    settings = {
      add_newline = false;
      format="$hostname-$python$git_branch$directory$character ";
      hostname = {
        format = "[$ssh_symbol](blue dimmed bold)[$hostname](green dimmed bold)";
	ssh_only = false;
	disabled = false;
      };
      python = {
        format = "($virtualenv)";
      };
      git_branch = { 
        format="[$branch](blue)"; 
        
      };
      directory = {
        read_only = " 🔒";
	truncate_to_repo = false;
      };
      character = { 
        format = "$symbol";
        success_symbol = "[:](bold green)";
        error_symbol = "[:](bold red)";
      };
    };
  };
}
