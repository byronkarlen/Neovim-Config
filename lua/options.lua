-- Line formatting
-- vim.opt.number = true
-- vim.opt.relativenumber = true
vim.opt.wrap = false

-- Tabs
vim.opt.tabstop = 2 -- controls how many column a tab character takes up in display
vim.opt.softtabstop = 2 -- controls how many columns Vim moves the cursor when you press tab while editing
vim.opt.shiftwidth = 2 -- controls the behavior of using << and >>
vim.opt.expandtab = true -- use spaces instead of tab characters
vim.opt.smartindent = false -- vim will automatically indent/de-indent with code (e.g. { })

-- Swap files (for in-memory changes) and backup files (for breaking writes)
vim.opt.swapfile = false
vim.opt.backup = false

-- Persistent undo
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true
vim.opt.undolevels = 1000 -- limit undo history to 1000 changes

-- Time nvim waits after pausing to trigger certain events -> makes it feel super responsive
vim.opt.updatetime = 50

-- Get rid of highlighted words after a search
vim.opt.hlsearch = false

-- Smartcase affects nvim searches when vim.opt.ignorecase is turned on
-- Ignorecase is not turned on but the telescope-frecency extension will still read this value
vim.opt.smartcase = true

vim.opt.splitright = true

-- Keep cursor centered
vim.opt.scrolloff = 12

