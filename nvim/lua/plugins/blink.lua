require("blink.cmp").setup({
  keymap = {
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-k>'] = { 'select_prev' },
    ['<C-j>'] = { 'select_next' },

    ['<Tab>'] = { 'select_and_accept' },

    ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },


  },
  sources = {
    -- `lsp`, `buffer`, `snippets`, `path` and `omni` are built-in
    default = { 'lsp', 'buffer', 'path' },
  },
  completion = {
    trigger = {
      show_on_insert = true,
      prefetch_on_insert = true,
      show_on_accept_on_trigger_character = true,
      show_on_trigger_character = true,
    },
    list = {
      preselect = true,
      auto_insert = false
    },
    documentation = {
      auto_show = true,
      treesitter_highlighting = true, -- disable this in case performance is an issue
    },
    ghost_text = {
      enabled = true
    }
  },
  signature = {
    enabled = true,                   -- show function information when typing the arguments
    window = {
      treesitter_highlighting = true, -- disable if you have performance issues
      show_documentation = true

    }
  },
})
