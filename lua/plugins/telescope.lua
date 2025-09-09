return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },

  config = function()
    local actions = require('telescope.actions')
    require('telescope').setup({
      defaults = {
        initial_mode = "normal",
        file_ignore_patterns = { "%.git/" },
        mappings = {
          n = {
            ["<leader>q"] = actions.close,
            ["d"] = actions.delete_buffer
          }
        }
      },
      pickers = {
        find_files = {
          hidden = true,
          no_ignore = false,
        }
      }
    })

    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>b', builtin.buffers, {})
    vim.keymap.set('n', '<leader>f', builtin.find_files, {})
    -- Requires ripgrep to be installed in PATH
    vim.keymap.set('n', '<leader>r', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
  end
}
