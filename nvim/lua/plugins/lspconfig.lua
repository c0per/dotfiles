local map_code_action = function (bufnr) 
    vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, { noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { noremap = true, silent = true, buffer = bufnr })
end

return {
    'neovim/nvim-lspconfig',
    config = function () 
        local lsp = require 'lspconfig'

        lsp.rust_analyzer.setup {
            on_attach = function (client, bufnr)
                map_code_action(bufnr)
            end
        }

        lsp.tailwindcss.setup {}

        -- lsp from vscode typescript
        -- lsp.vtsls.setup {}
        lsp.ts_ls.setup {
            on_attach = function (client, bufnr)
                map_code_action(bufnr)
            end
        }

        lsp.biome.setup {
            cmd = { 'npm', 'exec', 'biome', 'lsp-proxy' },
            on_attach = function (client, bufnr)
                map_code_action(bufnr)
            end
        }
    end
}
