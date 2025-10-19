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
vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)

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
vim.api.nvim_create_autocmd('CursorHold', {
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

-- vim.api.nvim_create_autocmd('LspAttach', {
--     callback = function(e)
--         local client = vim.lsp.get_client_by_id(e.data.client_id)
--     end
-- })

vim.filetype.add { pattern = { ['openapi.*%.ya?ml'] = 'yaml.openapi' } }

vim.lsp.enable({ 'biome', 'ts_ls', 'tailwindcss', 'rust-analyzer' })

-- vim.cmd([[
-- augroup folds
-- " Don't screw up folds when inserting text that might affect them, until
-- " leaving insert mode. Foldmethod is local to the window. Protect against
-- " screwing up folding when switching between windows.
-- autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
-- autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
-- augroup END
-- ]])

-- -- Switch to 'manual' foldmethod when entering Insert mode
-- vim.api.nvim_create_autocmd("InsertEnter", {
--   callback = function()
--     -- Save the current foldmethod only if we haven't already
--     if not vim.w.last_fdm then
--       vim.w.last_fdm = vim.opt_local.foldmethod:get()
--     end
--     vim.opt_local.foldmethod = "manual"
--     vim.opt_local.foldenable = false
--   end,
-- })
--
-- -- Restore the original foldmethod when leaving Insert mode
-- vim.api.nvim_create_autocmd({"InsertLeave", "WinLeave"}, {
--   callback = function()
--     -- Check if we have a saved state to restore
--     if vim.w.last_fdm then
--       vim.opt_local.foldmethod = vim.w.last_fdm
--       vim.w.last_fdm = nil -- Clear the saved state
--       vim.opt_local.foldenable = true
--     end
--   end,
-- })

require("config.lazy")
