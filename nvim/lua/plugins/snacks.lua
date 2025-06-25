local snacks = require("snacks");
snacks.setup({
  indent = { enabled = true },
  notifier = { enabled = true },                              -- notification toasts. I have not seem them yet, but might be nice
  picker = { enabled = true, ignored = true, hidden = true }, -- replaces telescope (pick files)
  input = { enabled = true },                                 -- replaces dressing (better input fields)
  terminal = { enabted = true },                              -- open a terminal in neovim
  explorer = { enabled = true, },                             -- replaces nvim tree (file explorer)
  styles = {
    input = {
      relative = "cursor", -- show the input on the cursor and not in the center
      row = 1,             -- show the input direclty under the element
    }
  }
})

-- Explorer
vim.keymap.set("n", "<leader>ee", snacks.explorer.open, { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>ef", snacks.explorer.reveal, { desc = "Reveal file explorer" })

-- Picker
vim.keymap.set("n", "<leader>ff", snacks.picker.smart, { desc = "Fuzzy search" })
vim.keymap.set("n", "<leader>fr", snacks.picker.recent, { desc = "Recent search" })
vim.keymap.set("n", "<leader>fs", snacks.picker.grep, { desc = "Grep in file search" })
vim.keymap.set("n", "<leader>fc", snacks.picker.grep, { desc = "Grep word in cursor file search" })
vim.keymap.set("n", "<leader>fg", snacks.picker.git_branches, { desc = "Search git branches" })
vim.keymap.set("n", "<leader>fb", snacks.picker.buffers, { desc = "Search buffers" })
vim.keymap.set("n", "<leader>fn", snacks.picker.notifications, { desc = "Search notifications" })
vim.keymap.set("n", "<leader>fh", snacks.picker.command_history, { desc = "Search command history" })

vim.keymap.set("n", "gD", snacks.picker.lsp_declarations, { desc = "Show LSP declarations" })
vim.keymap.set("n", "gd", snacks.picker.lsp_definitions, { desc = "Show LSP definitions" })
vim.keymap.set("n", "gr", snacks.picker.lsp_references, { desc = "Show LSP references" })
vim.keymap.set("n", "gi", snacks.picker.lsp_implementations, { desc = "Show LSP implementations" })

-- Terminal
vim.keymap.set("n", "<leader>tt", function() snacks.terminal() end, { desc = "Open terminal" })
