vim.g.mapleader = ' '

-- copying to system clipboard
vim.keymap.set({'n', 'v'}, '<leader>y', [["+y]]) -- [[]] are for strings without escaping in Lua
vim.keymap.set('n', '<leader>Y', [["+Y]])


-- for the netrw file system view
vim.keymap.set('n', '<leader>e', vim.cmd.Ex, { desc = 'open explorer' })
vim.keymap.set('n', '<leader>q', vim.cmd.bd, { desc = 'buffer delete' })

-- print file path
vim.keymap.set("n", "<leader>tt", function()
  print(vim.fn.expand("%:p:."))
end, { desc = "Print relative file path" })

-- copy relative file path to system clipboard
vim.keymap.set("n", "<leader>tr", function()
  local path = vim.fn.expand("%:p:.")
  print(path)
  vim.fn.setreg("+", path)
end, { desc = "Copy relative file path" })

-- copy absolute file path to system clipboard
vim.keymap.set("n", "<leader>ta", function()
  local path = vim.fn.expand("%:p")
  print(path)
  vim.fn.setreg("+", path)
end, { desc = "Copy absolute file path" })

-- delete to black hole
vim.keymap.set({"n", "v"}, "<leader>d", '"_d')
vim.keymap.set("n", "<leader>D", '"_D')

-- change to black hole by default
vim.keymap.set({"n", "v"}, "c", '"_c')
vim.keymap.set("n", "C", '"_C')

-- single char delete to black hole by default
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "X", '"_X')

-- toggling between active buffers
vim.keymap.set("n", "<leader>n", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<leader>p", ":bprevious<CR>", { silent = true })

-- toggling focus between nvim splits
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move right" })
