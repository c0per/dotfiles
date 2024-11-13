return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-fzf-native.nvim' },
        config = function()
            require('telescope').setup {
                extensions = {
                    fzf = {
                        fuzzy = true,                   -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
                        case_mode = "respect_case",     -- or "ignore_case" or "respect_case"
                    }
                }
            }

            require 'telescope'.load_extension 'fzf'

            local builtin = require('telescope.builtin')

            vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Find files' })
            vim.keymap.set('n', '<leader>s/', builtin.live_grep, { desc = 'Live grep' })
            vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'buffers' })
            vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'find help' })
            vim.keymap.set('n', '<leader>sr', builtin.lsp_references, {})
        end
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
}
