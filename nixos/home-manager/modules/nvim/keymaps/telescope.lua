local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string inside file in cwd [grep]" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>",
{ desc = "Find string on cursor inside cwd [grep cursor]" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find in current buffers" })
