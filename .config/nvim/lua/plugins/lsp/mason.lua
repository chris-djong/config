return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- see https://github.com/williamboman/mason-lspconfig.nvim
    mason_lspconfig.setup({
      -- list of language servers for mason to install
      ensure_installed = {
        "eslint",
        "eslint_d",
        "ts_ls",
        "angularls",
        "tsp_server",
        "html",
        "cssls",
        "tailwindcss",
        "lua_ls",
        "ruff",
        "basedpyright",
      },
    })
  end,
}
