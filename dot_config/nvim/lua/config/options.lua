local opt = vim.opt

opt.ignorecase = true

opt.smartindent = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true

opt.cursorline = true
opt.ruler = false
opt.list = true -- invisible characters

opt.relativenumber = true
opt.number = true

opt.sidescrolloff = 8
opt.scrolloff = 6
opt.winborder = "single"
vim.opt.signcolumn = "yes"

opt.confirm = true

opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.breakindentopt = "shift:2"

opt.swapfile = false
opt.undofile = true
vim.opt.exrc = true -- source .nvim.lua

