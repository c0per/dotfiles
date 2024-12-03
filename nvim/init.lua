vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.termguicolors = true

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set('i', '<C-c>', '<Esc>')

vim.keymap.set('n', '[b', '<Cmd>bprevious<Cr>')
vim.keymap.set('n', ']b', '<Cmd>bnext<Cr>')
vim.keymap.set('n', '[B', '<Cmd>bfirst<Cr>')
vim.keymap.set('n', ']B', '<Cmd>blast<Cr>')

vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)

vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>n', '<Cmd>nohlsearch<Cr>')

vim.diagnostic.config({
    underline = true,
    virtual_text = false,
    float = {
        border = 'rounded',
        source = true,
        update_in_insert = false,
    }
})
vim.opt.updatetime = 200
vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    callback = function()
        for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.api.nvim_win_get_config(winid).zindex then
                return
            end
        end
        vim.diagnostic.open_float({
            scope = "cursor",
            focusable = false,
            close_events = {
                "CursorMoved",
                "CursorMovedI",
                "BufHidden",
                "InsertCharPre",
                "WinLeave",
            },
        })
    end
})

vim.filetype.add { pattern = { ['openapi.*%.ya?ml'] = 'yaml.openapi' } }

require("config.lazy")
