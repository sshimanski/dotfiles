local actions = require('telescope.actions')
local width = 0.95

require("telescope").setup({
    defaults = {
        prompt_prefix = "❯ ",
        selection_caret = "❯ ",
        layout_config = {
            width = width,
            horizontal = {
                mirror = false,
                preview_width = 0.65
            }
        },
        path_display = { "smart" },
        mappings = {
            i = {
                ["<ESC>"] = actions.close,
            },
        },
    },
    pickers = {
        file_browser = {
            prompt_prefix = "  ",
            hidden = true,
        },
        buffers = {
            prompt_prefix = " ﬘ ",
            -- theme = "dropdown",
            layout_strategy = 'vertical',
            layout_config = {
                width = width,
            },
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
        }
    }
})

require('telescope').load_extension('fzf')
require("telescope").load_extension("ui-select")
