vim.g.mapleader = " "

local keymap = vim.keymap

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sc", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
keymap.set("n", "<leader>sm", "<C-w><C-w>", { desc = "Move to the next screen" }) -- omve to the next screen
keymap.set("n", "<leader>sh", "<C-w>h", { desc = "Move to the left screen" })
keymap.set("n", "<leader>sj", "<C-w>j", { desc = "Move to the bottom screen" })
keymap.set("n", "<leader>sk", "<C-w>k", { desc = "Move to the top screen" })
keymap.set("n", "<leader>sl", "<C-w>l", { desc = "Move to the right screen" })

-- tab management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tl", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>th", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- disable arrow keys in normal mode
keymap.set("n", "<Up>", "<Nop>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<Down>", "<Nop>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<Left>", "<Nop>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<Right>", "<Nop>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

keymap.set("v", "<leader>y", '"+y', { desc = "Yank To Clipboard" })
