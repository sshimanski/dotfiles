require("nvim-treesitter.configs").setup({
    ensure_installed = 'maintained', -- all
    highlight = {
        enable = true
    },
    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
    },
    autopairs = {
        enable = true
    },
    indent = {
        enable = true
    },
    refactor = {
        enable = true,
        highlight_definitions = { enable = true },
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "<Leader>dR",
            },
        },
        navigation = {
            enable = true,
            keymaps = {
                goto_next_usage = "<C-J>", -- Ctrl + Shift + j (IdentifierHiglighter)
                goto_previous_usage = "<C-K>", -- Ctrl + Shift + k (IdentifierHiglighter)
            },
        },
    },
    textobjects = {
        enable = true,
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",

                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",

                ["af"] = "@function.outer",
                ["if"] = "@function.inner",

                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",

                -- i = invocation
                ["ai"] = "@call.outer",
                ["ii"] = "@call.inner",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["C-L"] = "@parameter.inner",
            },
            swap_previous = {
                ["C-H"] = "@parameter.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
    },
})
