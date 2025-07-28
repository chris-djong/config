local function get_user_inputs(buf)
  local lines = vim.api.nvim_buf_get_lines(buf, 1, 4, false)
  local inputs = {}
  for _, line in ipairs(lines) do
    local key, value = line:match("^(%w+):%s*(.*)$")
    if key and value then
      inputs[key] = value
    end
  end
  return inputs
end


local function build_curl_command(inputs)
  local curl_cmd = {
    "curl",
    "-X", inputs.Method,
  }

  if inputs.Method == "POST" or inputs.Method == "PUT" then
    table.insert(curl_cmd, "-d")
    table.insert(curl_cmd, inputs.Data)
  end
  table.insert(curl_cmd, inputs.Endpoint)
  return curl_cmd
end

local function run_curl_command(curl_cmd, buf)
  local response = vim.fn.system(curl_cmd)
  vim.api.nvim_buf_set_lines(buf, 5, -1, false, vim.split(response, "\n"))
end

function OpenMenu()
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  -- Create an empty scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Open the floating window
  local win = vim.api.nvim_open_win(buf, true, {
    title = "PostVim",
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  -- Optional: Fill with a sample line or leave blank
  vim.api.nvim_buf_set_lines(buf, 1, 1, true, { "Endpoint: https://www.google.de" })
  vim.api.nvim_buf_set_lines(buf, 2, 2, true, { "Method: GET" })
  vim.api.nvim_buf_set_lines(buf, 3, 3, true, { "Data: {}" })

  vim.keymap.set("n", "<leader>sr", function()
    local inputs = get_user_inputs(buf)
    local cmd = build_curl_command(inputs)
    print(vim.inspect(cmd))
    run_curl_command(cmd, buf)
  end, { buffer = buf })

  -- Map 'q' to close the window and delete buffer
  vim.keymap.set("n", "q", function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
    if vim.api.nvim_buf_is_valid(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end, { buffer = buf, nowait = true, silent = true })
end

vim.keymap.set('n', '<leader>p', OpenMenu)
