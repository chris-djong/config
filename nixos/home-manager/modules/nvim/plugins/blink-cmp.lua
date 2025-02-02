require("blink.cmp").setup({
	appearance = {
		use_nvim_cmp_as_default = false,
		nerd_font_variant = "mono",
	},
	completion = {
		accept = { auto_brackets = { enabled = true } },
		documentation = {
			auto_show = true,
		},
		list = {
			selection = {
				preselect = function(ctx)
					return ctx.mode == "cmdline" and "auto_insert" or "preselect"
				end,
			},
		},
		menu = {
			border = "rounded",
			draw = {
				-- columns = {
				-- 	{ "label", "label_description", gap = 1 },
				-- 	{ "kind_icon", "kind" },
				-- },
				treesitter = { "lsp" },
			},
		},
	},
	-- My super-TAB configuration
	keymap = {
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = {
			function(cmp)
				return cmp.select_next()
			end,
			"snippet_forward",
			"fallback",
		},
		["<S-Tab>"] = {
			function(cmp)
				return cmp.select_prev()
			end,
			"snippet_backward",
			"fallback",
		},
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<C-up>"] = { "select_prev", "fallback" },
		["<C-down>"] = { "select_next", "fallback" },
		["<PageUp>"] = { "scroll_documentation_up", "fallback" },
		["<PageDown>"] = { "scroll_documentation_down", "fallback" },
		["<C-d>"] = { "show_documentation", "fallback" },
	},

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		cmdline = function()
			local type = vim.fn.getcmdtype()
			-- Search forward and backward
			if type == "/" or type == "?" then
				return { "buffer" }
			end
			-- Commands
			if type == ":" then
				return { "cmdline" }
			end
			return {}
		end,
		providers = {
			lsp = {
				min_keyword_length = 0,
				score_offset = 0,
			},
			path = {
				min_keyword_length = 0,
			},
			snippets = {
				min_keyword_length = 2,
			},
			buffer = {
				min_keyword_length = 4,
				max_items = 5,
			},
		},
	},
})
