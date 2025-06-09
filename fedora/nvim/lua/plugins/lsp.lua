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

-- Create keybindings, commands, inlay hints and autocommands on LSP attach {{{
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    local opts = { silent = true }
    -- Function to add the description to the options
    local function opt(desc, others)
      return vim.tbl_extend("force", opts, { desc = desc }, others or {})
    end
    -- set keybinds
    vim.keymap.set("n", "gr", function()
      require("telescope.builtin").lsp_references({
        include_declaration = false, -- Exclude declarations
        show_line = false,           -- Hide line preview
      })
    end, opt("Show LSP references"))

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opt("Go to declaration"))
    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opt("Show LSP definitions"))
    vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opt("Show LSP implementations"))
    vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opt("Show LSP definitions"))
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opt("See available code actions"))
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opt("Smart rename"))
    vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opt("Show buffer diagnostics"))
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opt("Show line diagnostics"))
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opt("Show documentation for what is under cursor"))
    vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opt("Restart LSP"))
  end,
})


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
