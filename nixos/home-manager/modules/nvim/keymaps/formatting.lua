
local conform = require("conform")
vim.keymap.set({ "n", "v" }, "<leader>fd", function()
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  })
end, { desc = "Format file or range (in visual mode)" })
