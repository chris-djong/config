return {
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css', 'scss', 'less' },
  init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
  root_markers = { "package.json", ".git", vim.uv.cwd() },
  single_file_support = true,
  -- Additional settings passed whenever a buffer is checker
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
}
