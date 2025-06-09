return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".git", vim.uv.cwd() },
  -- Additional settings passed whenever a buffer is checker
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT", -- Neovim uses LuaJIT
      },
      diagnostics = {
        globals = { "vim" }, -- Tell the language server about the `vim` global
        disable = { "undefined-field" }

      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true), -- Make Neovim runtime available
        checkThirdParty = false,                           -- Optional: prevents LSP prompts about third-party libs
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
