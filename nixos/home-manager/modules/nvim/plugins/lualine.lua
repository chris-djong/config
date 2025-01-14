local lualine = require("lualine")

local colors = {
	blue = "#89b4fa",
	green = "#a6e3a1",
	violet = "#b4befe",
	yellow = "#f9e2af",
	red = "#f38ba8",
	fg = "#c3ccdc",
	bg = "#2A2B3D",
	inactive_bg = "#2c3043",
}

local theme = {
	normal = {
		a = { bg = colors.green, fg = colors.bg, gui = "bold" },
		b = { bg = colors.bg, fg = colors.fg },
		c = { bg = colors.bg, fg = colors.fg },
	},
	insert = {
		a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
		b = { bg = colors.bg, fg = colors.fg },
		c = { bg = colors.bg, fg = colors.fg },
	},
	visual = {
		a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
		b = { bg = colors.bg, fg = colors.fg },
		c = { bg = colors.bg, fg = colors.fg },
	},
	command = {
		a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
		b = { bg = colors.bg, fg = colors.fg },
		c = { bg = colors.bg, fg = colors.fg },
	},
	replace = {
		a = { bg = colors.red, fg = colors.bg, gui = "bold" },
		b = { bg = colors.bg, fg = colors.fg },
		c = { bg = colors.bg, fg = colors.fg },
	},
	inactive = {
		a = { bg = colors.inactive_bg, fg = colors.fg, gui = "bold" },
		b = { bg = colors.inactive_bg, fg = colors.fg },
		c = { bg = colors.inactive_bg, fg = colors.fg },
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
