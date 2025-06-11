local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"

for _, file in ipairs(vim.fn.readdir(plugin_dir)) do
  if file ~= "init.lua" and file:sub(-4) == ".lua" then
    local plugin = file:sub(1, -5) -- remove `.lua`
    require("plugins." .. plugin)
  end
end
