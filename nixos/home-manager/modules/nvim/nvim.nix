{ pkgs, lib, ... }: {

  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in 
  {
    enable = true;
    plugins = [
      pkgs.vimPlugins.telescope-fzf-native-nvim
      pkgs.vimPlugins.dressing-nvim
      {
        plugin = pkgs.vimPlugins.telescope-nvim;
        config = toLuaFile ./plugins/telescope.lua;
      }
      {
        plugin = pkgs.vimPlugins.conform-nvim;
        config = toLuaFile ./plugins/formatting.lua;
      }
      {
        plugin = pkgs.vimPlugins.todo-comments-nvim;
        config = toLuaFile ./plugins/todo-comments.lua;
      }
      {
        plugin = pkgs.vimPlugins.nvim-tree-lua;
        config = toLuaFile ./plugins/nvim-tree.lua;
      }
      {
        plugin = pkgs.vimPlugins.alpha-nvim;
        config = toLuaFile ./plugins/alpha.lua;
      }
      {
        plugin = pkgs.vimPlugins.tokyonight-nvim;
        config = toLuaFile ./plugins/colorscheme.lua;
      }
    ];
    extraLuaConfig = ''
      ${builtins.readFile ../../../../.config/nvim/lua/core/options.lua}
      ${builtins.readFile ../../../../.config/nvim/lua/core/keymaps.lua}
      ${builtins.readFile ./keymaps/telescope.lua}
      ${builtins.readFile ./keymaps/nvim-tree.lua}
    '';
    extraPackages = with pkgs; [
      xclip
      wl-clipboard
    ];
  };
}
