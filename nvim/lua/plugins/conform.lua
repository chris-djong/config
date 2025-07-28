local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },
    svelte = { "prettierd" },
    css = { "prettierd" },
    html = { "prettierd" },
    htmlangular = { "prettierd" },
    json = { "prettierd" },
    yaml = { "prettierd" },
    markdown = { "prettierd" },
    graphql = { "prettierd" },
    liquid = { "prettierd" },
    lua = { "stylua" },
    python = { "ruff_format", "ruff_fix", "ruff_organize_imports" },
    sql = { "sqlfluff" },
    cpp = { "clang-format" },
    nix = { "nixfmt" },
    bash = { "shfmt" },
    sh = { "shfmt" },
    zsh = { "shfmt" },
    xml = { "xmllint" },
  },
  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 1000,
  },
})

vim.keymap.set({ "n", "v" }, "<leader>fd", function()
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  })
end, { desc = "Format file or range (in visual mode)" })
