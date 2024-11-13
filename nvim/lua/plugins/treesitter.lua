return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
        vim.opt.foldmethod = 'expr'
        vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "c", "cpp", "css", "csv", "fish",
                "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
                "html", "javascript", "json", "lua", "markdown", "markdown_inline",
                "nginx", "rust", "sql", "toml", "tsx", "typescript", "typst", "yaml"
            },
            sync_install = false,

            highlight = { enable = true },
            indent = { enable = true },  
        })
    end
}
