{ pkgs, ... }: {
  programs.bat = {
    enable = true;
    themes = {
      tokyonight_night = {
        src = pkgs.fetchFromGitHub {
          owner = "folke";
          repo = "folke";
	  ref = "main";
          sha256 = "186rhbljw80psf1l8hyj02ycz1wzxv4rxmbrqr8yvi30165drpay";
        };
        file = "extras/sublime/tokyonight_night.tmTheme";
      };
    };
  };
}
