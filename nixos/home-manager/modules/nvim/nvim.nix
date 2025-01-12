{ pkgs, lib, ... }: {

  programs.neovim = let
    toLua = str: ''
      lua << EOF
      ${str}
      EOF
    '';
    toLuaFile = file: ''
      lua << EOF
      ${builtins.readFile file}
      EOF
    '';
  in {
    enable = true;
    plugins = [
      pkgs.vimPlugins.telescope-fzf-native-nvim
      pkgs.vimPlugins.dressing-nvim
      {
        plugin = pkgs.vimPlugins.alpha-nvim;
        config = toLuaFile ./plugins/alpha.lua;
      }
      {
        plugin = pkgs.vimPlugins.blink-cmp;
        config = toLuaFile ./plugins/blink-cmp.lua;
      }
      {
        plugin = pkgs.vimPlugins.tokyonight-nvim;
        config = toLuaFile ./plugins/colorscheme.lua;
      }
      {
        plugin = pkgs.vimPlugins.conform-nvim;
        config = toLuaFile ./plugins/formatting.lua;
      }
      {
        plugin = pkgs.vimPlugins.indent-blankline-nvim;
        config = toLuaFile ./plugins/indent-blankline.lua;
      }
      {
        plugin = pkgs.vimPlugins.indent-blankline-nvim;
        config = toLuaFile ./plugins/lazy-git.lua;
      }
      {
        plugin = pkgs.vimPlugins.telescope-nvim;
        config = toLuaFile ./plugins/telescope.lua;
      }
      {
        plugin = pkgs.vimPlugins.todo-comments-nvim;
        config = toLuaFile ./plugins/todo-comments.lua;
      }
      {
        plugin = pkgs.vimPlugins.nvim-tree-lua;
        config = toLuaFile ./plugins/nvim-tree.lua;
      }
    ];
    extraLuaConfig = ''
      ${builtins.readFile ../../../../.config/nvim/lua/core/options.lua}
      ${builtins.readFile ../../../../.config/nvim/lua/core/keymaps.lua}
      ${builtins.readFile ./keymaps/telescope.lua}
      ${builtins.readFile ./keymaps/nvim-tree.lua}
      ${builtins.readFile ./keymaps/lazy-git.lua}
    '';
    extraPackages = with pkgs; [
      xclip
      wl-clipboard
      # LSPs 

      # Formatters
      nodePackages.prettier
      nixfmt-classic
      stylua

    ];
  };
}
