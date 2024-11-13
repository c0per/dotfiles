local function on_attach(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    local git_add = function()
        local node = api.tree.get_node_under_cursor()
        local gs = node.git_status.file or node.git_status.dir.direct[1] or node.git_status.dir.indirect[1]

        local staged_status = { "??", "MM", "AM", " M" }
        local unstaged_status = { "M ", "A " }

        if vim.tbl_contains(staged_status, gs) then
            vim.cmd("silent !git add " .. node.absolute_path)
        elseif vim.tbl_contains(unstaged_status, gs) then
            vim.cmd("silent !git restore --staged " .. node.absolute_path)
        end

        api.tree.reload()
    end

    vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
    vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
    vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
    vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
    vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
    vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))

    vim.keymap.set('n', '<CR>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
    vim.keymap.set('n', 'o', api.node.run.system, opts('Open In System'))

    vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
    vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
    vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
    vim.keymap.set('n', 'yn', api.fs.copy.filename, opts('Copy Name'))
    vim.keymap.set('n', 'ya', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
    vim.keymap.set('n', 'yr', api.fs.copy.relative_path, opts('Copy Relative Path'))
    vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
    vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
    vim.keymap.set('n', 'r', api.fs.rename, opts('Rename: Fullname'))
    vim.keymap.set('n', 'R', api.fs.rename_basename, opts('Rename: Basename'))
    vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
    vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))

    vim.keymap.set('n', '<C-r>', api.tree.reload, opts('Refresh'))
    vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
    vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))

    -- Filter
    vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
    vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
    vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
    vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
    vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle No Buffer'))
    vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Git Clean'))

    vim.keymap.set('n', '[g', api.node.navigate.git.prev, opts('Prev Git'))
    vim.keymap.set('n', ']g', api.node.navigate.git.next, opts('Next Git'))
    vim.keymap.set('n', ']d', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
    vim.keymap.set('n', '[d', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))

    vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
    vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
    vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
    vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))


    vim.keymap.set('n', 'ga', git_add, opts('Git Add'))
end

return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        vim.keymap.set('n', '-',
            function()
                require 'nvim-tree.api'.tree.open({ current_window = true, find_file = true, update_root = true })
            end
        )

        require 'nvim-tree'.setup {
            actions = { change_dir = { enable = false } },
            update_focused_file = { enable = true },
            on_attach = on_attach,
        }
    end
}
