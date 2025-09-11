return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      "nvim-telescope/telescope-frecency.nvim",
      version = "*",
    }
  },

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

        -- custom path_display: filename prominent, rest dim
        path_display = function(_, path)
          local tail   = vim.fn.fnamemodify(path, ":t")        -- filename
          local cwd    = vim.fn.getcwd()
          local rel    = vim.fn.fnamemodify(path, ":." .. cwd) -- always CWD-relative
          local parent = vim.fn.fnamemodify(rel, ":h")         -- parent dir (relative)

          if parent == "." then
            parent = ""
          end

          return string.format("%s   %s", tail, parent)
        end,

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
          mappings = {
            n = {
              ["d"] = actions.delete_buffer
            }
          }
        }
      },
      extensions = {
        frecency = {
          prompt_title = "Find files",
          show_filter_column = false,
        },
      },
    })

    require("telescope").load_extension "frecency"

    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>b', builtin.buffers, {})
    vim.keymap.set( "n", "<leader>f", function()
        require("telescope").extensions.frecency.frecency({
          workspace = "CWD",   -- restrict to current working directory
        })
      end,
    { noremap = true, silent = true, desc = "Frecency (cwd only)" })
    -- Requires ripgrep to be installed in PATH
    vim.keymap.set('n', '<leader>r', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>R', function()
      local dir = vim.fn.input("Search in subdir: ", vim.fn.getcwd() .. "/", "dir")
      if dir ~= "" then
        builtin.live_grep({ cwd = dir })
      end
    end, { desc = "Live grep in chosen subdir" })
    vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
  end
}
