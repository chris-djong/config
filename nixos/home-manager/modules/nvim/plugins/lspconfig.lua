local keymap = vim.keymap -- for conciseness

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf, silent = true }

		-- set keybinds
		opts.desc = "Show LSP references"
		keymap.set("n", "gr", function()
			require("telescope.builtin").lsp_references({
				include_declaration = false, -- Exclude declarations
				show_line = false, -- Hide line preview
			})
		end, opts)

		opts.desc = "Go to declaration"
		keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

		opts.desc = "Show LSP definitions"
		keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

		opts.desc = "Show LSP implementations"
		keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

		opts.desc = "Show LSP type definitions"
		keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

		opts.desc = "See available code actions"
		keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

		opts.desc = "Smart rename"
		keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

		opts.desc = "Show buffer diagnostics"
		keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

		opts.desc = "Show line diagnostics"
		keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

		opts.desc = "Go to previous diagnostic"
		keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

		opts.desc = "Go to next diagnostic"
		keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

		opts.desc = "Show documentation for what is under cursor"
		keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

		opts.desc = "Restart LSP"
		keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
	end,
})
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

local border = {
	{ "🭽", "FloatBorder" },
	{ "▔", "FloatBorder" },
	{ "🭾", "FloatBorder" },
	{ "▕", "FloatBorder" },
	{ "🭿", "FloatBorder" },
	{ "▁", "FloatBorder" },
	{ "🭼", "FloatBorder" },
	{ "▏", "FloatBorder" },
}

-- LSP settings (to enable border)
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

-- Lua
lspconfig.lua_ls.setup({
	handlers = handlers,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {
					"vim",
				},
			},
		},
	},
})
-- Python
lspconfig.basedpyright.setup({ handlers = handlers, capabilities = capabilities })
lspconfig.ruff.setup({ handlers = handlers, capabilities = capabilities })
-- Typescript/Javascript
lspconfig.angularls.setup({ handlers = handlers, capabilities = capabilities })
local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
end

lspconfig.ts_ls.setup({
	handlers = handlers,
	capabilities = capabilities,
	-- TODO: This does not quiet work yet. There is a misformatting between prettier and the imports
	-- on_attach = function(client, bufnr)
	-- 	-- client.server_capabilities.documentFormattingProvider = false
	-- 	vim.api.nvim_create_autocmd("BufWritePre", {
	-- 		buffer = bufnr,
	-- 		command = "OrganizeImports",
	-- 	})
	-- end,
	commands = {
		OrganizeImports = {
			organize_imports,
			description = "Organize Imports",
		},
	},
})
lspconfig.eslint.setup({ handlers = handlers, capabilities = capabilities })
lspconfig.tailwindcss.setup({ handlers = handlers, capabilities = capabilities })
-- HTML
lspconfig.html.setup({ handlers = handlers, capabilities = capabilities })
lspconfig.cssls.setup({ handlers = handlers, capabilities = capabilities })
-- CPP
lspconfig.clangd.setup({ handlers = handlers, capabilities = capabilities })
-- Shell / Bash / Zsh
lspconfig.bashls.setup({ handlers = handlers, capabilities = capabilities })
