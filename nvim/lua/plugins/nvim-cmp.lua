return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',

        -- vsnip
        'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip',
    },

    config = function ()
        local cmp = require 'cmp'

        cmp.setup {
            snippet = { expand = function (args) vim.fn["vsnip#anonymous"](args.body) end },
            mapping = {
                ['<C-y>'] = cmp.mapping.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace },
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-f>'] = cmp.mapping.scroll_docs(4)
            },
            sources = cmp.config.sources {
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'path' },
                { name = 'cmdline' },
                { name = 'vsnip' }
            }
        }
    end
}
