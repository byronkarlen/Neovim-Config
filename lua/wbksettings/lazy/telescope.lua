return {
  "nvim-telescope/telescope.nvim",

  tag = "0.1.5",

  dependencies = {
    "nvim-lua/plenary.nvim"
  },

  config = function()
    local actions = require('telescope.actions')
    require('telescope').setup({
      defaults = {
        initial_mode = "normal",
        mappings = {
          n = {
            ["<leader>q"] = actions.close
          }
        }
      }
    })

    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>b', builtin.buffers, {})
    vim.keymap.set('n', '<leader>f', builtin.find_files, {})
    vim.keymap.set('n', '<leader>g', builtin.git_files, {})
    vim.keymap.set('n', '<leader>s', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)

    -- less used
    vim.keymap.set('n', '<leader>of', builtin.oldfiles, {})
    vim.keymap.set('n', '<leader>gr', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
  end
}

