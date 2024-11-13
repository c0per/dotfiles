return {
    'akinsho/bufferline.nvim',
    config = function ()
        local bufferline = require 'bufferline'

        bufferline.setup {
            options = {
                style_preset = bufferline.style_preset.minimal,
                diagnostics = 'nvim_lsp',
                show_buffer_close_icons = false,
                always_show_bufferline = true,
                hover = { enabled = false },
            }
        }
    end,
    dependencies = 'nvim-tree/nvim-web-devicons'
}
