return {
  "nvim-telescope/telescope-frecency.nvim",
  version = "*",
  config = function()
    require("telescope").setup({
      extensions = {
        frecency = {
          prompt_title = "Find files",
          show_filter_column = false,
        },
      },
    })
    require("telescope").load_extension "frecency"

    vim.keymap.set( "n", "<leader>f", function()
        require("telescope").extensions.frecency.frecency({
          workspace = "CWD",   -- restrict to current working directory
        })
      end,
    { noremap = true, silent = true, desc = "Frecency (cwd only)" })
  end,
}
