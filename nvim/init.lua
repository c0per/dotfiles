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
vim.keymap.set('n', '<leader>f', function()
    vim.lsp.buf.format {
        filter = function(client) return client.name ~= "ts_ls" end
    }
end
)
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

vim.filetype.add { pattern = { ['openapi.*%.ya?ml'] = 'yaml.openapi' } }

vim.lsp.enable({ 'biome', 'ts_ls', 'tailwindcss', 'rust-analyzer', 'copilot', 'lua_ls' })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

vim.keymap.set({ "n", "v" }, "<Leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })

vim.cmd([[highlight RustLogoBright guibg=#ff7f50]])
vim.cmd([[highlight RustLogoDim guibg=#666666]])

function MyStatusLine()
    local winid = vim.g.statusline_winid
    local buf = vim.api.nvim_win_get_buf(winid)

    local mode = vim.fn.mode()

    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ':~:.')
    local line = vim.fn.line('.', winid)
    local col = vim.fn.col('.', winid)

    local status = require 'sidekick.status'.get()

    local left = string.format('%s|%s|%s|%d:%d', mode, filename, vim.bo.filetype, line, col)

    local right = ""
    if vim.bo.filetype == "rust" then
        local rust_logo = "🦀"
        local clients = vim.lsp.get_clients({ bufnr = buf, name = "rust-analyzer" })

        if #clients > 0 then
            right = "%#RustLogoBright#" .. rust_logo .. "%*|"
        else
            right = "%#RustLogoDim#" .. rust_logo .. "%*|"
        end
    end

    right = right .. (status and status.kind .. '|' .. tostring(status.busy) or 'no copilot')

    return left .. ' %= ' .. right
end

vim.api.nvim_create_autocmd("WinEnter", {
    pattern = "*",
    callback = function()
        vim.o.statusline = '%!v:lua.MyStatusLine()'
    end
})

require("config.lazy")
