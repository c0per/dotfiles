return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',

            -- LuaSnip
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip'
        },

        config = function ()
            local cmp = require 'cmp'

            cmp.setup {
                snippet = { expand = function (args) require 'luasnip'.lsp_expand(args.body) end },
                mapping = {
                    ['<C-y>'] = cmp.mapping.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace },
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4)
                },
                sources = cmp.config.sources {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                }
            }

            cmp.setup.cmdline({'/', '?'}, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                  { name = 'buffer' }
                }
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources(
                    { { name = 'path' } },
                    { { name = 'cmdline' } }
                ),
                matching = { disallow_symbol_nonprefix_matching = false }
            })        
        end
    },
    {
        'L3MON4D3/LuaSnip',
        version = "v2.*",
	build = "make install_jsregexp"
    }
}
