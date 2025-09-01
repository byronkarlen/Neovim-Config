return {
  "goolord/alpha-nvim",
  config = function ()
    require('alpha').setup(require('alpha.themes.startify').config)
    vim.keymap.set("n", "<leader>a", function()
      require("alpha").start()
    end, { desc = "Open Alpha dashboard" })
  end
}
