-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- local km = vim.keymap.set
-- local opts = { noremap = true, silent = true }

-- delete annoying keymaps
vim.keymap.del("n", "s")
vim.keymap.del({ "i", "n" }, "<A-j>")
vim.keymap.del({ "i", "n" }, "<A-k>")

-- fast colorscheme switching
vim.keymap.set("n", "<leader>kc", function()
    require("catppuccin").setup({
        flavour = "latte",
    })
    vim.cmd.colorscheme("catppuccin")
end) -- catppuccin
vim.keymap.set("n", "<leader>km", function()
    require("monokai").setup({})
    vim.cmd.colorscheme("monokai")
end) -- monokai
