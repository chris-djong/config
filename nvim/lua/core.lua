-- Set the leader key to space
vim.g.mapleader = " "

-- Show a treelike structure when we are browsing files (not go into the directory but directly show its contents)
vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2       -- prettier default
opt.shiftwidth = 2
opt.expandtab = true  -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting a new line

opt.wrap = false

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true  -- if you a mixed case is included in the search, automatically assume case sensitive

opt.cursorline = true

-- turn on colors for the terminal
opt.termguicolors = true
opt.background = "dark" -- use dark mode if available
opt.signcolumn = "yes"

-- split windows
opt.splitright = true
opt.splitbelow = true


-- window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })     -- split window vertically
vim.keymap.set("n", "<leader>sc", "<C-w>s", { desc = "Split window horizontally" })   -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })      -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
vim.keymap.set("n", "<leader>sm", "<C-w><C-w>", { desc = "Move to the next screen" }) -- omve to the next screen
vim.keymap.set("n", "<leader>sh", "<C-w>h", { desc = "Move to the left screen" })
vim.keymap.set("n", "<leader>sj", "<C-w>j", { desc = "Move to the bottom screen" })
vim.keymap.set("n", "<leader>sk", "<C-w>k", { desc = "Move to the top screen" })
vim.keymap.set("n", "<leader>sl", "<C-w>l", { desc = "Move to the right screen" })

-- tab management
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab
vim.keymap.set("n", "<leader>tl", "<cmd>tabn<CR>", { desc = "Go to next tab" })                     --  go to next tab
vim.keymap.set("n", "<leader>th", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                 --  go to previous tab
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- disable arrow keys in normal mode
vim.keymap.set("n", "<Up>", "<Nop>", { desc = "Close current tab" })                 -- close current tab
vim.keymap.set("n", "<Down>", "<Nop>", { desc = "Go to next tab" })                  --  go to next tab
vim.keymap.set("n", "<Left>", "<Nop>", { desc = "Go to previous tab" })              --  go to previous tab
vim.keymap.set("n", "<Right>", "<Nop>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank To Clipboard" })
