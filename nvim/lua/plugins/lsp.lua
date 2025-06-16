local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.foldingRange = {
  dynamicRegistration = true,
  lineFoldingOnly = true,
}

capabilities.textDocument.semanticTokens.multilineTokenSupport = true
capabilities.textDocument.completion.completionItem.snippetSupport = true


vim.lsp.config("*", {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    local ok, diag = pcall(require, "rj.extras.workspace-diagnostic")
    if ok then
      diag.populate_workspace_diagnostics(client, bufnr)
    end
  end,
})


vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
    end
  end,
})

vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation for what is under cursor" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "See available code actions" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" })


-- NOTE: The configs were downloaded from nvim-lspconfig plugin page
-- https://github.com/neovim/nvim-lspconfig/tree/master/lsp
vim.lsp.enable({
  'angularls',    -- Updated on 9 June
  'basedpyright', -- Updated on 9 June
  'bashls',       -- Updated on 9 June
  'clangd',       -- Updated on 9 June
  "lua_ls",       -- Updated on 9 June
  'cssls',        -- Updated on 9 June
  'eslint',       -- Updated on 9 June
  'htmlls',       -- Updated on 9 June
  'ruff',         -- Updated on 9 June
  'tailwindcss',  -- Updated on 9 June
  'ts_ls',        -- Updated on 9 June
})
