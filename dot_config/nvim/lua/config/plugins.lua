
vim.cmd.colorscheme("monokai")

local treesitter = require("nvim-treesitter")
treesitter.install({
    "lua", "python", "toml", "qmljs",
    "astro", "html", "css",
    "bash", "nu"
})

require("snacks").setup({
    picker = { enabled = true },
    explorer = { enabled = true },
})

require("which-key").setup({ preset = "helix" })

require("bufferline").setup({})

require("mini.ai").setup({})
require("nvim-autopairs").setup({})

-- require("copilot").setup({})
-- require("codecompanion").setup({})

require("gitsigns").setup({
    on_attach = function(bufnr)
        -- vim.fn.system({ "notify-send", "yo john" })
        -- TODO: maybe move hunk binds here
    end
})
