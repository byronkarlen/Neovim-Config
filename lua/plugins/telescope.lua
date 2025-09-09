return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },

  config = function()
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')

    local function paste_after(prompt_bufnr, reg)
      local text   = vim.fn.getreg(reg or '"')
      local picker = action_state.get_current_picker(prompt_bufnr)
      local line   = action_state.get_current_line()
      picker:reset_prompt(line .. text)
    end

    local function paste_before(prompt_bufnr, reg)
      local text   = vim.fn.getreg(reg or '"')
      local picker = action_state.get_current_picker(prompt_bufnr)
      local line   = action_state.get_current_line()
      picker:reset_prompt(text .. line)
    end

    require('telescope').setup({
      defaults = {
        initial_mode = "normal",
        file_ignore_patterns = { "%.git/" },
        mappings = {
          n = {
            ["<leader>q"] = actions.close,
            ["p"] = paste_after,
            ["P"] = paste_before,
          }
        }
      },
      pickers = {
        find_files = {
          hidden = true,
          no_ignore = false,
        },
        buffers = {
          sort_lastused = true,
          mappings = {
            n = {
              ["d"] = actions.delete_buffer
            }
          }
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
