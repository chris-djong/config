local lint = require("lint")

lint.linters_by_ft = {
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  svelte = { "eslint_d" },
  python = { "ruff" },
  bash = { "shellcheck" },
  sh = { "shellcheck" },
  zsh = { "shellcheck" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

-- Show the linting text even when not hovering
vim.diagnostic.config({
  virtual_text = true,
  update_in_insert = false -- we can not update in insert mode because otherwise the autocmd for the virtual_text detection is not triggered
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})

vim.keymap.set("n", "<leader>l", function()
  lint.try_lint()
end, { desc = "Trigger linting for current file" })


-- We redraw the diagnostics whenever the mode has changes
vim.api.nvim_create_autocmd('ModeChanged', {
  group = vim.api.nvim_create_augroup('diagnostic_redraw', {}),
  callback = function()
    pcall(vim.diagnostic.show)
  end
})
