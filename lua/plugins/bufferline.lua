return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',

  config = function()
    require("bufferline").setup {
      options = {
        show_buffer_close_icons = false,
        diagnostics = false,
      },
      highlights = (function()
        local current_theme = vim.g.current_theme or vim.g.colors_name or ""

        if current_theme == "nord" then
          local nord_highlights = require("nord").bufferline.highlights({
            italic = true,
            bold = true,
          })
          nord_highlights.fill = nord_highlights.background
          return nord_highlights
        else
          return {
            background = { bg = "NONE" },
            buffer_visible = { bg = "NONE" },
            buffer_selected = { bg = "NONE" },
            fill = { bg = "NONE" },
            tab = { bg = "NONE" },
            tab_selected = { bg = "NONE" },
            separator = { bg = "NONE" },
            separator_selected = { bg = "NONE" },
            separator_visible = { bg = "NONE" },
          }
        end
      end)()
    }
  end
}
