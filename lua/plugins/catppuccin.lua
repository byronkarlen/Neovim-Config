return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      local function get_system_appearance()
        local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
        local result = handle:read("*a")
        handle:close()
        return result:match("Dark") and "dark" or "light"
      end

      local appearance = get_system_appearance()
      local flavour = appearance == "dark" and "macchiato" or "latte"

      require("catppuccin").setup({
        flavour = flavour,
        integrations = {
          telescope = true,
          treesitter = true,
          lualine = true,
          gitsigns = true,
          mason = true,
          native_lsp = { enabled = true },
        },
      })

      vim.cmd.colorscheme "catppuccin"
    end,
  },
}

