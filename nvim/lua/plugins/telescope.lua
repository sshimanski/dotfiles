return {
    -- super cool lists and more
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-telescope/telescope-ui-select.nvim",
        -- power extensions
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-telescope/telescope-frecency.nvim",
        "debugloop/telescope-undo.nvim",
        "jvgrootveld/telescope-zoxide",
        "nvim-tree/nvim-web-devicons",
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
                        preview_width = 0.6,
                    },
                },
                path_display = { "smart" },
                mappings = {
                    -- <ESC> now drops to NORMAL mode inside the picker
                    -- (use j/k, q to close). Old <ESC>=close removed.
                    i = {
                        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                    },
                    n = {
                        ["q"] = actions.close,
                    },
                },
            },
            pickers = {
                diagnostics = { previewer = false },
                buffers = {
                    layout_strategy = 'vertical',
                    layout_config = { width = width },
                    previewer = false,
                    ignore_current_buffer = true,
                    mappings = {
                        i = { ["<C-d>"] = actions.delete_buffer },
                        n = { ["<C-d>"] = actions.delete_buffer },
                    },
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                file_browser = {
                    hijack_netrw = true,
                    hidden = { file_browser = true, folder_browser = true },
                    grouped = true,
                },
                frecency = {
                    show_scores = false,
                },
                undo = {
                    side_by_side = true,
                    layout_strategy = "vertical",
                    layout_config = { preview_height = 0.6 },
                },
            },
        })

        telescope.load_extension('fzf')
        telescope.load_extension('ui-select')
        telescope.load_extension('file_browser')
        telescope.load_extension('live_grep_args')
        telescope.load_extension('frecency')
        telescope.load_extension('undo')
        telescope.load_extension('zoxide')
    end,
}
