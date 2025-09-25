return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-frecency.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
  },

  config = function()
    local actions = require('telescope.actions')
    local fb_actions = require "telescope._extensions.file_browser.actions"
    require('telescope').setup({
      defaults = require('telescope.themes').get_ivy({
        initial_mode = "normal",
      }),

      pickers = {
        buffers = {
          path_display = { "tail" },
          mappings = {
            n = {
              ["d"] = actions.delete_buffer
            }
          }
        },
        find_files = {
          prompt_title = "Find files (fuzzy)"
        },
      },

      extensions = {
        frecency = {
          show_filter_column = false, -- remove the project directory prefix
          prompt_title = "Find files (frecency)",
          auto_validate = false, -- periodically run `:Telescope frecency cleanup` to clean up its DB
        },
        file_browser = {
          hijack_netrw = true,
          hidden = { file_browser = true, folder_browser = true },
          respect_gitignore = false,
          mappings = {
            ["n"] = {
              ["-"] = fb_actions.goto_parent_dir
            }
          }
        },
      },
    })

    local builtin = require('telescope.builtin')
    require("telescope").load_extension "frecency"
    require("telescope").load_extension "file_browser"

    -- Auto-update frecency scores on buffer enter
    local ok, db_client = pcall(require, "telescope._extensions.frecency.db_client")
    if ok then
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function(args)
          local file = args.file or vim.api.nvim_buf_get_name(args.buf)
          if file and file ~= "" and vim.fn.filereadable(file) == 1 then
            db_client:update_file_entry(file)
          end
        end,
      })
    end

    vim.keymap.set('n', '<leader>b', builtin.buffers, {})

    vim.keymap.set('n', '<leader><leader>', builtin.resume, {})

    vim.keymap.set( "n", "<leader>f", function()
        require("telescope").extensions.frecency.frecency({
          workspace = "CWD",
        })
      end,
    { desc = "Frecency" })

    vim.keymap.set('n', '<leader>o', function()
      builtin.oldfiles({
        cwd_only = true
      })
    end, { desc = "Old files" })

    vim.keymap.set('n', '<leader>F', builtin.find_files, { desc = "Find files (fuzzy)" })

    -- Requires ripgrep to be installed in PATH
    -- Ignores files ignored by git, but not .git/ itself
    vim.keymap.set('n', '<leader>r', function()
      builtin.live_grep({
        file_ignore_patterns = { "%.git/" },
        cache_picker = { num_pickers = 1 },
        additional_args = function()
          return { "--hidden" }
        end
      })
    end, { desc = "Live grep (include hidden)" })

    vim.keymap.set('n', '<leader>R', function()
      local dir = vim.fn.input("Search in subdir: ", vim.fn.getcwd() .. "/", "dir")
      if dir ~= "" then
        builtin.live_grep({
          cwd = dir,
          file_ignore_patterns = { "%.git/" },
          additional_args = function()
            return { "--hidden" }
          end
        })
      end
    end, { desc = "Live grep in chosen subdir" })

    vim.keymap.set('n', '<leader>e', function()
      require("telescope").extensions.file_browser.file_browser({
        path = "%:p:h", -- in which directory to open file_browser
        select_buffer = true,
      })
    end, { desc = "File browser" })
  end
}
