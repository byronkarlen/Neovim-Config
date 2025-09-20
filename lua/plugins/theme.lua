return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
  },
  {
    "shaunsingh/nord.nvim",
    priority = 1000,
    config = function()
      local function get_system_appearance()
        local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
        local result = handle:read("*a")
        handle:close()
        return result:match("Dark") and "dark" or "light"
      end

      local appearance = get_system_appearance()

      if appearance == "dark" then
        vim.g.nord_contrast = true
        vim.g.nord_borders = false
        vim.g.nord_disable_background = false
        vim.g.nord_italic = false
        vim.g.nord_uniform_diff_background = true
        vim.g.nord_bold = false
        vim.cmd.colorscheme "nord"
      else
        require("catppuccin").setup({
          flavour = "latte",
          integrations = {
            telescope = true,
            treesitter = true,
            lualine = true,
            gitsigns = true,
            mason = true,
          },
        })
        vim.cmd.colorscheme "catppuccin"
      end
    end,
  },
}

