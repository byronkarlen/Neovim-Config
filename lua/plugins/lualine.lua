return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  config = function()
    -- Detect system appearance (macOS)
    local function get_system_appearance()
      local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
      local result = handle:read("*a")
      handle:close()
      return result:match("Dark") and "dark" or "light"
    end

    -- Choose theme based on system appearance
    local appearance = get_system_appearance()
    local theme_name = appearance == "dark" and "nord" or "iceberg_light"

    local custom_theme = require('lualine.themes.' .. theme_name)

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
