vim.g.mapleader = " "

-- for the netrw file system view
vim.keymap.set("n", "<leader>nd", vim.cmd.Ex)
vim.keymap.set("n", "<leader>nr", ':e .<CR>')
vim.api.nvim_create_autocmd("filetype", {
  pattern = "netrw",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<leader>q", ":bd<CR>", {})
  end,
})

-- for copying file path to system clipboard
vim.api.nvim_set_keymap('n', '<leader>cp', ':let @+ = expand("%")<CR>', {})
-- for copying to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
 -- for copying the current line
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- for closing and opening tabs
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>")
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>")

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.api.nvim_set_keymap('n', '<leader>df', ':lua vim.diagnostic.open_float()<CR>', {})

