return {
    -- { "L3MON4D3/LuaSnip", enabled = false },
    { "ThePrimeagen/vim-be-good" },
    { "folke/noice.nvim", enabled = false },
    { "mfussenegger/nvim-lint", enabled = false },

    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function(_, opts)
            opts.sections.lualine_z = {}
        end,
    },
    {
        "saghen/blink.cmp",
        -- enabled = false,
        opts = {
            enabled = function() return not vim.tbl_contains({ "lua", "markdown" }, vim.bo.filetype) end,
        },
    },
}
