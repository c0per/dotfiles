return {
    'famiu/bufdelete.nvim',
    config = function()
        vim.keymap.set('n', '<leader>x', require 'bufdelete'.bufdelete)
    end
}
