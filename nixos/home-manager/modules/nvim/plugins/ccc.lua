require("ccc").setup({})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	command = "CccHighlighterEnable",
})
