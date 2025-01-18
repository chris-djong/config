local treesitter = require("nvim-treesitter.configs")

vim.cmd("set foldlevel=20")
vim.cmd("set foldmethod=expr")
vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")

treesitter.setup({ -- enable syntax highlighting
	highlight = {
		enable = true,
	},
	-- enable indentation
	indent = { enable = true },
	-- ensure these language parsers are installed
	ensure_installed = {
		"json",
		"javascript",
		"typescript",
		"yaml",
		"html",
		"css",
		"markdown",
		"markdown_inline",
		"bash",
		"lua",
		"vim",
		"dockerfile",
		"gitignore",
		"query",
		"python",
		"vimdoc",
	},
	-- incremental_selection means that by clicking CTRL+Space, we keep visually selecting
	-- more inside the current function/ file. Just try it out by going over a variable
	-- and hitting CTRL Space
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = false,
			node_decremental = "<bs>",
		},
	},
})
