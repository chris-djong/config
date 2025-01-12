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
      {
        plugin = pkgs.vimPlugins.telescope-nvim;
        config = toLua ''
    local telescope = require("configs_")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next,     -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string inside file in cwd [grep]" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>",
      { desc = "Find string on cursor inside cwd [grep cursor]" })
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find in current buffers" })
	'';
      }
      # {
      #   plugin = pkgs.vimPlugins.todo-comments-nvim;
      #   config = builtins.readFile ../../../.config/nvim/lua/plugins/todo-comments.lua;
      # }
      # {
      #   plugin = pkgs.vimPlugins.nvim-tree-lua;
      #   config = builtins.readFile ../../../.config/nvim/lua/plugins/nvim-tree.lua;
      # }
    ];
    extraLuaConfig = ''
      ${builtins.readFile ../../../.config/nvim/lua/core/keymaps.lua}
      ${builtins.readFile ../../../.config/nvim/lua/core/options.lua}
    '';
    extraPackages = with pkgs; [
      xclip
      wl-clipboard
    ];
  };
}
