require("ccc").setup({})

-- TODO: Check whether this is the reason performance is slowed down
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
-- 	command = "CccHighlighterEnable",
-- })
