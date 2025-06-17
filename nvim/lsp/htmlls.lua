return {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = { "html", 'htmlangular' },
  root_markers = { "package.json", ".git", vim.uv.cwd() },
  single_file_support = true,
  init_options = {
    provideFormatter = true, -- for the formatter
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { 'html', 'css', 'javascript' },
  },
}
