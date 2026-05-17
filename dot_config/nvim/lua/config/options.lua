-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.snacks_animate = false
vim.g.autoformat = false

local opt = vim.opt

-- fat cursor ;)
-- opt.guicursor = ""

opt.spell = false

-- Sync with system clipboard
-- opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

-- Don't sync with system clipboard
opt.clipboard = vim.env.SSH_TTY and "" or "unnamed"

opt.cursorline = true -- Enable highlighting of the current line
opt.mouse = "a" -- Enable mouse mode

opt.number = true -- Print line number
opt.relativenumber = true -- Relative line numbers

opt.shiftwidth = 4 -- Size of an indent
opt.tabstop = 4 -- Number of spaces tabs count for
opt.smartindent = true -- Insert indents automatically

opt.sidescrolloff = 8 -- Columns of context
opt.scrolloff = 8 -- Lines of context

opt.swapfile = false

opt.smartcase = true -- Don't ignore case with capitals
opt.wrap = true -- Disable line wrap

