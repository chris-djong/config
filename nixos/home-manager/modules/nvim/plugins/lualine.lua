local lualine = require("lualine")

local theme = {
	normal = {
		a = { bg = theme.green, fg = theme.bg, gui = "bold" },
		b = { bg = theme.bg, fg = theme.fg },
		c = { bg = theme.bg, fg = theme.fg },
	},
	insert = {
		a = { bg = theme.blue, fg = theme.bg, gui = "bold" },
		b = { bg = theme.bg, fg = theme.fg },
		c = { bg = theme.bg, fg = theme.fg },
	},
	visual = {
		a = { bg = theme.violet, fg = theme.bg, gui = "bold" },
		b = { bg = theme.bg, fg = theme.fg },
		c = { bg = theme.bg, fg = theme.fg },
	},
	command = {
		a = { bg = theme.yellow, fg = theme.bg, gui = "bold" },
		b = { bg = theme.bg, fg = theme.fg },
		c = { bg = theme.bg, fg = theme.fg },
	},
	replace = {
		a = { bg = theme.red, fg = theme.bg, gui = "bold" },
		b = { bg = theme.bg, fg = theme.fg },
		c = { bg = theme.bg, fg = theme.fg },
	},
	inactive = {
		a = { bg = theme.inactive_bg, fg = theme.fg, gui = "bold" },
		b = { bg = theme.inactive_bg, fg = theme.fg },
		c = { bg = theme.inactive_bg, fg = theme.fg },
	},
}

-- configure lualine with modified theme
lualine.setup({
	options = {
		theme = theme,
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = {},
		lualine_x = {
			"fileformat",
			"filetype",
		},
		lualine_y = {},
		lualine_z = { "location" },
	},
	winbar = {
		lualine_a = { "mode" },
		lualine_b = { "filename" },
	},
	inactive_winbar = {
		lualine_b = { "filename" },
	},
})
