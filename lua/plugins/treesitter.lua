return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function ()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "javascript",
        "html",
        "json",
        "typescript",
        "bash",
        "yaml",
        "python",
        "tsx",
        "hcl",
        "sql"
      },

      modules = {},
      ignore_install = {},
      auto_install = true,
      sync_install = false,
      highlight = { enable = true },
      playground = { enable = true },
      indent = { enable = true },
    })
  end
}
