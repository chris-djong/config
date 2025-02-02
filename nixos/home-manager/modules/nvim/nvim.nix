{ pkgs, lib, ... }: {

  programs.neovim = let
    theme = import ../theme.nix;
    toLuaFile = file: ''
      lua << EOF
      local theme = {
        blue = "${theme.blue}",
        green = "${theme.green}",
        violet = "${theme.violet}",
        yellow = "${theme.yellow}",
        red = "${theme.red}",
        fg = "${theme.fg}",
        bg = "${theme.bg}",
        inactive_bg = "${theme.inactive_bg}",
      }
      ${builtins.readFile file}
      EOF
    '';
  in {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      telescope-fzf-native-nvim
      nvim-web-devicons
      dressing-nvim
      lazygit-nvim
      which-key-nvim
      git-blame-nvim
      {
        plugin = todo-comments-nvim;
        config = toLuaFile ./plugins/todo-comments.lua;
      }
      {
        plugin = trouble-nvim;
        config = toLuaFile ./plugins/trouble.lua;
      }
      {
        plugin = ccc-nvim;
        config = toLuaFile ./plugins/ccc.lua;
      }
      {
        plugin = nvim-treesitter.withAllGrammars;
        config = toLuaFile ./plugins/treesitter.lua;
      }
      {
        plugin = alpha-nvim;
        config = toLuaFile ./plugins/alpha.lua;
      }
      cmp-nvim-lsp
      {
        plugin = nvim-cmp;
        config = toLuaFile ./plugins/nvim-cmp.lua;
      }
      {
        plugin = tokyonight-nvim;
        config = toLuaFile ./plugins/colorscheme.lua;
      }
      {
        plugin = conform-nvim;
        config = toLuaFile ./plugins/formatting.lua;
      }
      {
        plugin = indent-blankline-nvim;
        config = toLuaFile ./plugins/indent-blankline.lua;
      }
      {
        plugin = nvim-lint;
        config = toLuaFile ./plugins/nvim-lint.lua;
      }
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./plugins/lspconfig.lua;
      }
      {
        plugin = telescope-nvim;
        config = toLuaFile ./plugins/telescope.lua;
      }
      {
        plugin = nvim-tree-lua;
        config = toLuaFile ./plugins/nvim-tree.lua;
      }
      {
        plugin = lualine-nvim;
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
