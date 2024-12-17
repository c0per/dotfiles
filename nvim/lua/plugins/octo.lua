return {
    'pwntester/octo.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require 'octo'.setup {
            mappings = {
                review_diff = {
                    add_review_comment = { lhs = "<leader>ca", desc = "add a new review comment" },
                    add_review_suggestion = { lhs = "<leader>sa", desc = "add a new review suggestion" },
                    toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
                }
            }
        }
    end
}
