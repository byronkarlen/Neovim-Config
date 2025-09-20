local function get_system_appearance()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  local result = handle:read("*a")
  handle:close()
  return result:match("Dark") and "dark" or "light"
end

vim.g.current_theme = get_system_appearance() == "dark" and "nord" or "catppuccin"

