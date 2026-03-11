return {
    'stevearc/conform.nvim',
    config = function ()
        require 'conform'.setup {
            formatters_by_ft = {
                lua = { "lua-language-server" },
                rust = { "rustfmt", lsp_format = "fallback" },
                go = { "goimports", "gofumpt" },
                javascript = { "oxfmt" },
                typescript = { "oxfmt" },
                javascriptreact = { "oxfmt" },
                typescriptreact = { "oxfmt" },
            }
        }
    end,
}
