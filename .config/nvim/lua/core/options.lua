-- Show a treelike structure when we are browsing files (not go into the directory but directly show its contents)
vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2 -- prettier default
opt.shiftwidth = 2 
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting a new line 

opt.wrap = false;

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you a mixed case is included in the search, automatically assume case sensitive

opt.cursorline = true

-- turn on colors for the terminal
opt.termguicolors = true
opt.background = "dark" -- use dark mode if available 
opt.signcolumn = "yes"

-- split windows
opt.splitright = true
opt.splitbelow = true 


