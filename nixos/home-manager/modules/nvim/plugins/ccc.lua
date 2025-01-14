require("ccc").setup({})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	callback = function()
		requrie("ccc.highligher").toggle()
	end,
})
