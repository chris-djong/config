local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		svelte = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		graphql = { "prettier" },
		liquid = { "prettier" },
		lua = { "stylua" },
		python = { "ruff_format", "ruff_fix", "ruff_organize_imports" },
		sql = { "sqlfluff" },
		cpp = { "clang-format" },
		nix = { "nixfmt" },
		bash = { "shfmt" },
		sh = { "shfmt" },
		zsh = { "shfmt" },
	},
	format_on_save = {
		lsp_fallback = true,
		timeout_ms = 1000,
	},
})
