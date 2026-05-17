-- local basedpyright = require "lspconfig.configs.basedpyright"
return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "lua",
                "python",
                "bash",
                "rust",
                "cpp",

                "astro",
                "html",
                "javascript",
                "css",
                "scss",
                "json",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            autoformat = false,
            -- inlay_hints = { enabled = false },
            servers = {
                lua_ls = {},
                cssls = {},
                -- ruff = {},
                -- pyright = { enabled = false },
                basedpyright = {
                    settings = {basedpyright = {analysis = {
                        typeCheckingMode = "basic"
                    }}}
                },
                clangd = {},
                rust_analyzer = {},
                astro = {},
                nil_ls = {},
                qmlls = {
                    enabled = true,
                    -- filetypes = { "qml" },
                    settings = {
                        qmlls = {
                            lint = {
                                ignoreWarnings = { "uncreatable-type" },
                            },
                        }
                    },
                    -- root_dir = function(fname)
                    --     return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
                    -- end,
                    single_file_support = true,
                },
            },
            -- setup = function(_, _)
            --    require("lspconfig").qmlls.setup({ cmd = { "qmlls", "-E" } })
            -- end,
        },
    },
    {
        "mason-org/mason.nvim",
        enabled = false,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        enabled = false,
    },
}
