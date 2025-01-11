{ pkgs, ... }: {
  programs.bat = {
    enable = true;
    themes = {
      tokyonight_night = {
        src = pkgs.fetchFromGitHub {
	  owner = "folke";
	  repo = "tokyonight.nvim";
	  rev = "refs/heads/main";
	  sha256 = "0aw4qzh4mj592g08nfb9zbviybq7gj3fgkvzw67q0qaficj2lpyl";
        };
	file = "extras/sublime/tokyonight_night.tmTheme";
      };
    };
  };
}
