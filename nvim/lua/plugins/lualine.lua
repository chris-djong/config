local lualine = require("lualine")
local theme = require("theme")

local lua_theme = {
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


local function get_lsp()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  if clients and #clients > 0 then
    local clientNames = {}
    for _, client in ipairs(clients) do
      table.insert(clientNames, client.name)
    end
    return '  ' .. table.concat(clientNames, ' ')
  end
  return '  No Lsp'
end

local function get_formatter()
  local conform = require('conform')
  local formatters = conform.list_formatters_for_buffer()
  if formatters and #formatters > 0 then
    local formatterNames = {}
    for _, formatter in ipairs(formatters) do
      table.insert(formatterNames, formatter)
    end
    return '󰷈 ' .. table.concat(formatterNames, ' ')
  end

  -- Check if there's an LSP formatter
  local lsp_format = require('conform.lsp_format')
  local bufnr = vim.api.nvim_get_current_buf()
  local lsp_clients = lsp_format.get_format_clients({ bufnr = bufnr })

  if not vim.tbl_isempty(lsp_clients) then
    return '󰷈 LSP Formatter'
  end
  return '󰷈  No Formatter'
end

-- configure lualine with modified theme
lualine.setup({
  options = {
    theme = lua_theme,
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = {},
    lualine_x = {
      "filetype",
      get_lsp,
      get_formatter
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
