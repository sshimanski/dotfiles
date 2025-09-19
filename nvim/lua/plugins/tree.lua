return {
    'nvim-tree/nvim-tree.lua',
    dependecies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('nvim-tree').setup({
            git = {
                enable = true,
            },
            -- buggy
            -- auto_close = true,
            update_focused_file = {
                enable = true,
            },
            view = {
                --hide_root_folder = false,
                width = '25%',
                -- auto_resize = true,
            },
            diagnostics = {
                enable = true,
            }
        })
    end,
}
