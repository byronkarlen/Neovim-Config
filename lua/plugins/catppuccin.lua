return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    if vim.g.current_theme == "catppuccin" then
      local flavour = "latte"

      require("catppuccin").setup({
        flavour = flavour,
        integrations = {
          telescope = true,
          treesitter = true,
          lualine = true,
          gitsigns = true,
          mason = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end
  end,
}
