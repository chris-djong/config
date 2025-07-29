-- Global Parameters for functioning
local winenter_autocmd_id = nil
local requests = {};
local windows = {};
local methods = { "GET", "POST", "PUT", "DELETE" }
local current_method_index = 1;
local current_requests_index = 0; -- NOTE: index 0 = scratch, meaning no actual request selected
local requests_ns = vim.api.nvim_create_namespace("requests_ns")
vim.api.nvim_command("highlight RequestsSelected guibg=#3B4252 guifg=#D8DEE9")


-- Design Parameters
local total_height = math.floor(vim.o.lines * 0.8)
local total_width = math.floor(vim.o.columns * 0.8)
local header_height = 1
local method_width = 10
local left_width = math.floor(total_width * 0.3)
local right_width = total_width - left_width
local right_height = total_height - header_height

local settings = {
  total_width = total_width,
  total_height = total_height,
  row = math.floor((vim.o.lines - total_height) / 2),
  col = math.floor((vim.o.columns - total_width) / 2),
  header_height = header_height,
  method_width = method_width,
  left_width = left_width,
  right_width = right_width,
  right_height = right_height,
  half_right_height = math.floor(right_height / 2),
}

local function get_user_inputs()
  return {
    endpoint = vim.api.nvim_buf_get_lines(windows.endpoint.buf, 0, 1, false)[1],
    method = vim.api.nvim_buf_get_lines(windows.method.buf, 0, 1, false)[1],
    data = nil
  }
end



local function run_curl_command()
  local inputs = get_user_inputs()
  local curl_cmd = {
    "curl",
    "-sS", -- hide progress bar, but still show error messages
    "-X", inputs.method,
  }
  if inputs.method == "POST" or inputs.method == "PUT" then
    table.insert(curl_cmd, "-d")
    table.insert(curl_cmd, inputs.data)
  end
  table.insert(curl_cmd, inputs.endpoint)

  local buf = windows.response.buf
  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
  local cmd = table.concat(curl_cmd, " ")
  local response = vim.fn.system(cmd)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(response, "\n"))
  vim.bo[buf].modifiable = false
end



local function set_current_method_by_index(index)
  if index < 1 then
    index = #methods
  elseif index > #methods then
    index = 1
  end
  current_method_index = index
  local buf = windows.method.buf
  local win = windows.method.win
  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { methods[current_method_index] })
  vim.api.nvim_win_set_cursor(win, { 1, 0 })
  vim.bo[buf].modifiable = false
end

local function set_current_method_by_name(name)
  for i, method in ipairs(methods) do
    if method == name then
      set_current_method_by_index(i)
      return true
    end
  end
  -- Optional: handle unknown method name
  vim.notify("Method '" .. name .. "' not found.", vim.log.levels.WARN)
  return false
end

local function create_method_window()
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    title = "Method",
    relative = "editor",
    width = settings.method_width - 1,
    height = settings.header_height,
    row = settings.row,
    col = settings.col,
    style = "minimal",
    border = "rounded",
  })

  -- Initial content
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { methods[1] })
  vim.api.nvim_win_set_cursor(win, { 1, 0 })

  -- Make buffer read-only (so user can't type manually)
  vim.bo[buf].modifiable = false
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"

  local function previous_method()
    set_current_method_by_index(current_method_index - 1)
  end
  local function next_method()
    set_current_method_by_index(current_method_index + 1)
  end

  vim.keymap.set({ "n", 'v' }, "<Tab>", next_method, { buffer = buf, noremap = true, silent = true })
  vim.keymap.set({ "n", 'v' }, "<CR>", next_method, { buffer = buf, noremap = true, silent = true })
  vim.keymap.set({ "n", 'v' }, "j", next_method, { buffer = buf, noremap = true, silent = true })
  vim.keymap.set({ "n", 'v' }, "k", previous_method, { buffer = buf, noremap = true, silent = true })
  return { buf = buf, win = win }
end

local function set_current_endpoint(endpoint)
  vim.api.nvim_buf_set_lines(windows.endpoint.buf, 0, -1, true, { endpoint })
end

local function set_current_request_by_index(index)
  if index < 0 then
    index = #requests
  elseif index > #requests then
    index = 0
  end
  current_requests_index = index
  local window = windows.requests
  vim.api.nvim_win_set_cursor(window.win, { current_requests_index + 1, 0 })
  vim.api.nvim_buf_clear_namespace(window.buf, requests_ns, 0, -1)
  vim.highlight.range(window.buf, requests_ns, "RequestsSelected", { current_requests_index, 0 },
    { current_requests_index, 100 },
    { priority = 1000 })

  if index ~= 0 then
    local request = requests[index]
    set_current_method_by_name(request.method)
    set_current_endpoint(request.endpoint)
  else
    set_current_method_by_index(1)
    set_current_endpoint('')
  end
end

local function load_previous_request()
  set_current_request_by_index(current_requests_index - 1)
end
local function load_next_request()
  set_current_request_by_index(current_requests_index + 1)
end

local function update_requests_buffer()
  local buf = windows.requests.buf
  -- The first line is always the scratch buffer
  local win_width = vim.api.nvim_win_get_width(windows.requests.win)
  local content = '<Scratch>'
  local lines = { content .. string.rep(' ', math.max(0, win_width - #content)) }
  for _, req in ipairs(requests) do
    content = string.format('[%s] %s', req.method, req.name)
    local padded = content .. string.rep(' ', math.max(0, win_width - #content))
    table.insert(lines, padded)
  end
  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  set_current_request_by_index(current_requests_index)
end

local function get_requests_file_path()
  local project_folder = '/postvim'
  local filename = "/postvim_requests.lua"
  local project_file = vim.fn.getcwd() .. filename
  if vim.fn.filereadable(project_file) == 1 then
    return project_file
  end
  return vim.fn.stdpath("data") .. project_folder .. filename
end


local function load_requests()
  local ok, result = pcall(dofile, get_requests_file_path())
  if ok and type(result) == "table" then
    return result
  else
    return {} -- fallback to empty list
  end
end

local function save_requests()
  local content = "return " .. vim.inspect(requests)
  local filepath = get_requests_file_path()
  -- Create the directory in case it does not exist yet
  local dir = filepath:match("(.*/)")
  if dir then
    vim.fn.mkdir(dir, "p")
  end
  local f, err = io.open(filepath, "w")
  if not f then
    print('Could not open file ', filepath, ' for writing: ', err)
    return
  end
  f:write(content)
  f:close()
end


local function create_endpoint_window()
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    title = "Endpoint",
    relative = "editor",
    width = settings.total_width - settings.method_width - 1,
    height = settings.header_height,
    row = settings.row,
    col = settings.col + settings.method_width + 1,
    style = "minimal",
    border = "rounded",
  })

  vim.api.nvim_buf_set_lines(buf, 0, -1, true, { "" })
  vim.api.nvim_win_set_cursor(win, { 1, 0 })

  -- Prevent entering new lines
  local keys_to_disable = {
    { mode = "i", key = "<CR>" },
    { mode = "n", key = "o" },
    { mode = "n", key = "O" },
    { mode = "n", key = "p" },
    { mode = "n", key = "P" },
  }

  for _, mapping in ipairs(keys_to_disable) do
    vim.api.nvim_buf_set_keymap(buf, mapping.mode, mapping.key, "<NOP>", { noremap = true, silent = true })
  end

  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  return { buf = buf, win = win }
end

local function create_requests_window()
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, false, {
    title = "My Requests",
    relative = "editor",
    width = settings.left_width,
    height = settings.right_height,
    row = settings.row + settings.header_height + 2,
    col = settings.col,
    style = "minimal",
    border = "rounded",
  })
  -- Make buffer read-only (so user can't type manually)
  vim.bo[buf].modifiable = false
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  return { buf = buf, win = win }
end

local function create_data_window()
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, false, {
    title = "Data",
    relative = "editor",
    width = settings.right_width - 2,
    height = settings.half_right_height - 1,
    row = settings.row + settings.header_height + 2,
    col = settings.col + settings.left_width + 2,
    style = "minimal",
    border = "rounded",
  })
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  return { buf = buf, win = win }
end

local function create_response_window()
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, false, {
    title = "Response",
    relative = "editor",
    width = settings.right_width - 2,
    height = settings.right_height - settings.half_right_height - 1,
    row = settings.row + settings.header_height + settings.half_right_height + 3,
    col = settings.col + settings.left_width + 2,
    style = "minimal",
    border = "rounded",
  })
  -- Make buffer read-only (so user can't type manually)
  vim.bo[buf].modifiable = false
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  return { buf = buf, win = win }
end

local function create_windows()
  return {
    method = create_method_window(),
    endpoint = create_endpoint_window(),
    requests = create_requests_window(),
    data = create_data_window(),
    response = create_response_window(),
  }
end

local function close_all_buffers()
  -- Stop listenting to changes in winenter anymore
  if winenter_autocmd_id then
    pcall(vim.api.nvim_del_autocmd, winenter_autocmd_id)
    winenter_autocmd_id = nil
  end
  local function close(win)
    if vim.api.nvim_win_is_valid(win.win) then
      vim.api.nvim_win_close(win.win, true)
    end
    if vim.api.nvim_buf_is_valid(win.buf) then
      vim.api.nvim_buf_delete(win.buf, { force = true })
    end
  end

  for _, win in pairs(windows) do
    close(win)
  end
end

local function save_current_request()
  local current_request = requests[current_requests_index]
  vim.ui.input({
    prompt = "Enter request name: ",
    default = current_requests_index ~= 0 and current_request.name or "",
  }, function(name)
    if name == nil or name == "" then
      print("Name can not be empty")
      return
    end
    local inputs = get_user_inputs()
    local new_request = {
      name = name,
      method = inputs.method,
      endpoint = inputs.endpoint,
      data = inputs.data or '',
    }
    -- Check if request with the same name already exists
    local found = false
    for i, req in ipairs(requests) do
      if req.name == name then
        requests[i] = new_request
        current_requests_index = i
        found = true
        break
      end
    end

    -- If not found, add new request
    if not found then
      table.insert(requests, new_request)
      current_requests_index = #requests + 1 -- 0 is the scratch request
    end

    save_requests()
    update_requests_buffer()
    set_current_request_by_index(current_requests_index)
  end)
end

local function delete_current_request()
  if (current_requests_index ~= 0) then
    table.remove(requests, current_requests_index)
    save_requests()
    update_requests_buffer()
  end
end

function OpenPostvim()
  windows = create_windows()
  requests = load_requests()
  update_requests_buffer()

  for _, win in pairs(windows) do
    vim.keymap.set("n", "<leader>pe", run_curl_command,
      { desc = "Execute request", buffer = win.buf, noremap = true, silent = true })
    vim.keymap.set("n", "<leader>ps", save_current_request,
      { desc = "Save current request", buffer = win.buf, noremap = true, silent = true })
    vim.keymap.set({ "n", "v" }, "q", close_all_buffers,
      { desc = "Quit postvim", buffer = win.buf, nowait = true, silent = true })
    vim.keymap.set({ "n", "i", "v" }, "<C-k>", load_previous_request,
      { desc = "Next request", buffer = win.buf, nowait = true, silent = true })
    vim.keymap.set({ "n", "i", "v" }, "<C-j>", load_next_request,
      { desc = "Next request", buffer = win.buf, nowait = true, silent = true })
    vim.keymap.set({ "n", "i", "v" }, "<C-d>", delete_current_request,
      { desc = "Next request", buffer = win.buf, nowait = true, silent = true })
    vim.keymap.set({ "n", "i", "v" }, "<Up>", load_previous_request,
      { desc = "Next request", buffer = win.buf, nowait = true, silent = true })
    vim.keymap.set({ "n", "i", "v" }, "<Down>", load_next_request,
      { desc = "Next request", buffer = win.buf, nowait = true, silent = true })
    vim.keymap.set({ "n", "v" }, "<leader>pg", function() set_current_method_by_name('GET') end,
      { desc = "Set GET method", buffer = win.buf, nowait = true, silent = true })
    vim.keymap.set({ "n", "v" }, "<leader>pp", function() set_current_method_by_name('POST') end,
      { desc = "Set POST method", buffer = win.buf, nowait = true, silent = true })
    vim.keymap.set({ "n", "v" }, "<leader>pP", function() set_current_method_by_name('PUT') end,
      { desc = "Set PUT method", buffer = win.buf, nowait = true, silent = true })
    vim.keymap.set({ "n", "v" }, "<leader>pd", function() set_current_method_by_name('DELETE') end,
      { desc = "Set DELETE method", buffer = win.buf, nowait = true, silent = true })
  end

  -- In case the user enters a window that is not on our buffer. Then we close all the windows
  winenter_autocmd_id = vim.api.nvim_create_autocmd("WinEnter", {
    callback = function()
      local win = vim.api.nvim_get_current_win()
      local buf = vim.api.nvim_win_get_buf(win)
      -- If the user entered a window *outside* your custom ones:
      if not vim.tbl_contains(vim.tbl_map(function(w) return w.buf end, windows), buf) then
        close_all_buffers()
      end
    end
  })
end

vim.keymap.set('n', '<leader>p', OpenPostvim)
