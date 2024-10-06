return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- see https://github.com/williamboman/mason-lspconfig.nvim
		mason_lspconfig.setup({
			-- list of language servers for mason to install
			ensure_installed = {
				"eslint",
				"ts_ls",
				"angularls",
				"tsp_server",
				"html",
				"cssls",
				"tailwindcss",
				"lua_ls",
				"pyright",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"ruff", -- python formatter
				"pylint", -- python linter
				"eslint_d", --
			},
		})
	end,
}
