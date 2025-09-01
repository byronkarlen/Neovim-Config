return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  config = function()
    local custom_theme = require('lualine.themes.auto')

    local function make_transparent(mode)
      for _, section in pairs(custom_theme[mode]) do
        section.bg = "none" -- inherit terminal background
        section.fg = "none" -- inherit terminal background
      end
    end

    for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command", "inactive" }) do
      make_transparent(mode)
    end

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = custom_theme,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'filename'},
        lualine_c = {'branch', 'diagnostics'},
        -- lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_x = {''},
        lualine_y = {'progress'},
        lualine_z = {'lsp_status'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
  end
}
