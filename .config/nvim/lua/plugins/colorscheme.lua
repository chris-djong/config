return {
  "folke/tokyonight.nvim",
  priority = 1000, -- load this before any other plugin
  config = function()  -- this function will run whenever the plugin loads
    require("tokyonight").setup({style="night"})
    vim.cmd("colorscheme tokyonight")
  end
}
