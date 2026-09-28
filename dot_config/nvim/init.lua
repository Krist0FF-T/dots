
-- TODO:
-- - undo tree
-- - snippets w luasnip or some other
-- - completion w blink.cmp or nvim-cmp
-- - LSP - symbol rename, docs

vim.pack.add({

    "https://github.com/tanvirtin/monokai.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/folke/snacks.nvim",
    "https://github.com/folke/which-key.nvim",
    -- "https://github.com/christoomey/vim-tmux-navigator",
    "https://github.com/akinsho/bufferline.nvim",
    "https://github.com/folke/trouble.nvim",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/jiaoshijie/undotree",

    --- mini.nvim
    "https://github.com/nvim-mini/mini.icons", -- icons
    "https://github.com/nvim-mini/mini.ai", -- `daf` and stuff
    -- "https://github.com/nvim-mini/mini.surround", -- conflicts w "s" ("xi")

    --- ai (fun to mess around with sometimes)
    -- "https://github.com/zbirenbaum/copilot.lua",
    -- "https://github.com/olimorris/codecompanion.nvim",
    -- "https://github.com/nvim-lua/plenary.nvim", -- codecompanion dependency
})

require("config.options")
require("config.keymaps")
require("config.plugins")
require("config.exobrain")

