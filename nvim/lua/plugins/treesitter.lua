local treesitter = require("nvim-treesitter.configs")

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldenable = false

treesitter.setup({ -- enable syntax highlighting
  highlight = {
    enable = true,
  },
  -- enable indentation
  indent = { enable = true },
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = {
    "angular",
    "bash",
    "c",
    "css",
    "cpp",
    "csv",
    "dockerfile",
    "git_config",
    "git_rebase",
    "gitignore",
    "html",
    "http",
    "javascript",
    "json",
    "json5",
    "lua",
    "markdown",
    "markdown_inline",
    "nginx",
    "nix",
    "python",
    "regex",
    "sql",
    "ssh_config",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
  },
  -- incremental_selection means that by clicking CTRL+Space, we keep visually selecting
  -- more inside the current function/ file. Just try it out by going over a variable
  -- and hitting CTRL Space
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
})
