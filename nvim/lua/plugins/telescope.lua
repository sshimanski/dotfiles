return {
    -- super cool lists and more
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",

        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
        },
        "nvim-telescope/telescope-symbols.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "tom-anders/telescope-vim-bookmarks.nvim",
    },
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')
        local width = 0.95

        telescope.setup({
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
            },
            extensions = {
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                }
            },
        })

        telescope.load_extension('fzf')
        telescope.load_extension("ui-select")
    end,
}
