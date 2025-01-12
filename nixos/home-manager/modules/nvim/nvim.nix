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
      pkgs.vimPlugins.lazygit-nvim
      pkgs.vimPlugins.which-key-nvim
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
        plugin = pkgs.vimPlugins.nvim-lint;
        config = toLuaFile ./plugins/nvim-lint.lua;
      }
      {
        plugin = pkgs.vimPlugins.nvim-lspconfig;
        config = toLuaFile ./plugins/lspconfig.lua;
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
      {
        plugin = pkgs.vimPlugins.lualine-nvim;
        config = toLuaFile ./plugins/lualine.lua;
      }
      {
        plugin = pkgs.vimPlugins.trouble-nvim;
        config = toLuaFile ./plugins/trouble.lua;
      }
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
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
      angular-language-server
      vscode-langservers-extracted
      lua-language-server
      tailwindcss-language-server
      typescript-language-server

      # Formatters
      nodePackages.prettier
      nixfmt-classic
      stylua
      ruff
      sqlfluff

      # Linters 
      eslint_d
      basedpyright
    ];
  };
}
