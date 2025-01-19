require("ccc").setup({})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	command = "CccHighlighterEnable",
})
