return {
  "tpope/vim-fugitive",
  config = function()
    vim.keymap.set('n', '<leader>gs', ':vertical Git<CR>', { desc = 'Git status' })
    vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = 'Git commit' })
    vim.keymap.set('n', '<leader>gp', ':Git push<CR>', { desc = 'Git push' })
    vim.keymap.set('n', '<leader>gl', ':Git pull<CR>', { desc = 'Git pull' })
    vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit ', { desc = 'Git diff split' })
    vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { desc = 'Git blame' })
    vim.keymap.set('n', '<leader>gw', ':Gwrite<CR>', { desc = 'Git add current file' })
    vim.keymap.set('n', '<leader>gt', ':G log --oneline<CR>', { desc = 'Git log --oneline' })
    vim.keymap.set('n', '<leader>gk', ':G checkout ', { desc = 'Git checkout' })
  end
}
