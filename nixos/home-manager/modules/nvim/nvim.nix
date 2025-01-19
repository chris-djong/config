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
      pkgs.vimPlugins.dressing-nvim
      pkgs.vimPlugins.lazygit-nvim
      pkgs.vimPlugins.which-key-nvim
      pkgs.vimPlugins.ccc-nvim
      pkgs.vimPlugins.trouble-nvim
      pkgs.vimPlugins.todo-comments-nvim
      {
        plugin = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
        config = toLuaFile ./plugins/treesitter.lua;
      }
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
        plugin = pkgs.vimPlugins.nvim-tree-lua;
        config = toLuaFile ./plugins/nvim-tree.lua;
      }
      {
        plugin = pkgs.vimPlugins.lualine-nvim;
        config = toLuaFile ./plugins/lualine.lua;
      }
    ];
    extraLuaConfig = ''
      ${builtins.readFile ./core.lua}
      ${builtins.readFile ./keymaps/general.lua}
      ${builtins.readFile ./keymaps/telescope.lua}
      ${builtins.readFile ./keymaps/nvim-tree.lua}
      ${builtins.readFile ./keymaps/ccc.lua}
      ${builtins.readFile ./keymaps/lazy-git.lua}
      ${builtins.readFile ./keymaps/trouble.lua}
      ${builtins.readFile ./keymaps/nvim-lint.lua}
      ${builtins.readFile ./keymaps/formatting.lua}
    '';
    extraPackages = with pkgs; [
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
      clang-tools

      # Linters 
      eslint_d
      basedpyright
    ];
  };
}
