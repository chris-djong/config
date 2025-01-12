{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    xdg.configFile.nvim.source = ./nvim;
    extraPackages = with pkgs; [
    ];
  };
}
