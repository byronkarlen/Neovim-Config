return {
  "goolord/alpha-nvim",
  config = function()
    local alpha = require('alpha')
    local startify = require('alpha.themes.startify')

    startify.section.top_buttons.val = {}

    alpha.setup(startify.config)

    vim.keymap.set("n", "<leader>a", function()
      require("alpha").start()
    end, { desc = "Open Alpha dashboard" })
  end
}
