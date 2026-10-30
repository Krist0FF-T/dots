
vim.g.mapleader = " "

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", {desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", {desc = "Up", expr = true, silent = true })

vim.keymap.set({ "n", "i" }, "<C-s>", vim.cmd.write)
vim.keymap.set({ "n"  }, "<esc>", vim.cmd.noh)

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my.keymaps-lsp-attach", { clear = true }),
    callback = function(event)
        local function bufmap(mode, keys, func, desc)
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
        end

        bufmap("n", "<leader>cr", vim.lsp.buf.rename, "[c]ode [r]ename")
        bufmap({ "n", "x" }, "<leader>cd", vim.diagnostic.open_float, "[c]ode [d]iagnostics")

        -- overrides
        -- bufmap("n", "grr", require("snacks").picker.lsp_references, "[g]oto [r]eferences")
        -- bufmap("n", "gd", require("snacks").picker.lsp_definitions, "[g]oto [d]efinition")
    end,
})

vim.keymap.set("n", "<leader>e", function() require("snacks").picker.explorer({ auto_close = true }) end)
vim.keymap.set("n", "<leader>f", function() require("snacks").picker.smart() end)
vim.keymap.set("n", "<leader>g", function() require("snacks").picker.grep() end)

vim.keymap.set("n", "<leader>u", require('undotree').toggle)

-- vim.keymap.set({ "n", "v" }, "<leader>a", vim.cmd.CodeCompanionChat)

-- window switching
vim.keymap.set({ "n", "i", "v" }, "<C-h>", "<C-w>h")
vim.keymap.set({ "n", "i", "v" }, "<C-j>", "<C-w>j")
vim.keymap.set({ "n", "i", "v" }, "<C-k>", "<C-w>k")
vim.keymap.set({ "n", "i", "v" }, "<C-l>", "<C-w>l")

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
