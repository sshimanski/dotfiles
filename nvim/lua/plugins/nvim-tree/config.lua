local opts = {
    -- buggy
    -- auto_close = true,
    update_focused_file = {
        enable      = true,
    },
    view = {
        hide_root_folder = false,
        width = '25%',
        -- auto_resize = true,
    },
    diagnostics = {
        enable = true,
    }
}

require('nvim-tree').setup(opts)
