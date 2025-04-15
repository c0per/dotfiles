return {
    cmd = { 'biome', 'lsp-proxy' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'json', 'json5', 'jsonc' },

    root_dir = function(bufnr, cb)
        local filename = vim.api.nvim_buf_get_name(bufnr)

        local config_file = vim.fs.find({ 'biome.json' }, {
            path = vim.fs.dirname(filename),
            upward = true,
        })[1]

        local root = config_file and vim.fs.dirname(config_file) or nil
        cb(root)
    end
}
