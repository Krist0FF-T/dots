
vim.g.mapleader = " "

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", {desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", {desc = "Up", expr = true, silent = true })

vim.keymap.set({ "n", "i" }, "<C-s>", vim.cmd.write)
vim.keymap.set({ "n"  }, "<esc>", vim.cmd.noh)

vim.keymap.set("n", "<leader>e", function() require("snacks").picker.explorer({ auto_close = true }) end)
vim.keymap.set("n", "<leader>f", function() require("snacks").picker.smart() end)
vim.keymap.set("n", "<leader>g", function() require("snacks").picker.grep() end)

vim.keymap.set("n", "<leader>u", require('undotree').toggle)

-- vim.keymap.set({ "n", "v" }, "<leader>a", vim.cmd.CodeCompanionChat)

-- tmux
vim.keymap.set({ "n", "i", "v" }, "<C-h>", vim.cmd.TmuxNavigateLeft)
vim.keymap.set({ "n", "i", "v" }, "<C-j>", vim.cmd.TmuxNavigateDown)
vim.keymap.set({ "n", "i", "v" }, "<C-k>", vim.cmd.TmuxNavigateUp)
vim.keymap.set({ "n", "i", "v" }, "<C-l>", vim.cmd.TmuxNavigateRight)

-- buffers
vim.keymap.set("n", "H", vim.cmd.bprev)
vim.keymap.set("n", "L", vim.cmd.bnext)
vim.keymap.set("n", "<C-q>", vim.cmd.bwipe)

-- git
vim.keymap.set({ "n", "v" }, "<leader>hs", function() require("gitsigns").stage_hunk() end)
vim.keymap.set({ "n", "v" }, "<leader>hr", function() require("gitsigns").reset_hunk() end)
vim.keymap.set({ "n", "v" }, "<leader>hp", function() require("gitsigns").preview_hunk() end)
-- TODO: hunk diff w "<leader>ph"

-- match helix
vim.keymap.set("n", "gs", "_")
vim.keymap.set("n", "ge", "G")
vim.keymap.set("n", "gh", "0")
vim.keymap.set("n", "gl", "$")
