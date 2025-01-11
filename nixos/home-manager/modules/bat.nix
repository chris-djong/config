{ pkgs, ... }: {
  programs.bat = {
    enable = true;
    themes = {
      tokyonight_night = {
        src = pkgs.fetchFromGitHub {
          owner = "folke";
          repo = "folke";
	  rev = "refs/heads/main";
        };
        file = "extras/sublime/tokyonight_night.tmTheme";
      };
    };
  };
}
