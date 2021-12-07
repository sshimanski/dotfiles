local actions = require('telescope.actions')

require("telescope").setup({
    defaults = {
        prompt_prefix = "❯ ",
        selection_caret = "❯ ",
        layout_strategy = 'horizontal',
        layout_config = {
            width = 0.9,
            horizontal = {
                mirror = false,
                preview_width = 0.65
            }
        },
        path_display = {"smart"},
        mappings = {
            i = {
                ["<ESC>"] = actions.close,
            }
        },
    },
    pickers = {
        file_browser = {
            prompt_prefix = "  ",
            hidden = true,
        },
        buffers = {
            prompt_prefix = " ﬘ ",
            theme = "dropdown",
            previewer = false,
            ignore_current_buffer = true,
            mappings = {
                i = {
                    ["<C-d>"] = actions.delete_buffer
                },
                n = {
                    ["<C-d>"] = actions.delete_buffer
                },
            },
        },
        git_status = {
            layout_config = { width = 0.5 },
            previewer = false,
            git_icons = {
                added = "",
                changed = "",
                copied = "",
                deleted = "",
                renamed = "",
                unmerged = "",
                untracked = "",
            },
        },
    }
})
