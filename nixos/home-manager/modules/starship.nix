{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    format="$hostname - $python$git_branch $directory$character ";
    settings = {
      add_newline = false;
      hostname = {
        format = "[$ssh_symbol$hostname]($style)";
        style = "bold purple";
      };
      python = {
        format = "($virtualenv)";
      };
      git_branch = { 
        format="$branch"; 
        
      };
      character = {
        success_symbol = "[ & ](bold green)";
        error_symbol = "[ & ](bold red)";
      };
      username = {
        show_always = true;
        format = "[$user]($style)@";
      };
      directory = {
        read_only = " 🔒";
	truncate_to_repo = false;
      };
      character = { 
        format = "$symbol ";
      }
    };
  };
}
