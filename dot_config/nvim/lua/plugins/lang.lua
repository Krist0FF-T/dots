
local lsp_specs = {
    basedpyright = {},
    clangd = {},
    qmlls = {},
    astro = {},
}

for name, opts in pairs(lsp_specs) do
    vim.lsp.enable(name)
    vim.lsp.config(name, opts)
end

