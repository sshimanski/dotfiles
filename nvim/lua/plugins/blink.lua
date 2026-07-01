return {
    "saghen/blink.cmp",
    -- use a release tag so the prebuilt Rust fuzzy binary is downloaded
    -- (no local `cargo build` needed).
    version = "1.*",
    dependencies = {
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- use LuaSnip as the snippet engine (keeps friendly-snippets + the
        -- custom luasnip keymaps in plugins/snippets.lua working).
        snippets = { preset = "luasnip" },

        -- keymap mirrors the previous nvim-cmp setup
        keymap = {
            preset = "none",
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-e>"] = { "hide" },
            ["<C-y>"] = { "select_and_accept" },
            ["<CR>"] = { "accept", "fallback" },
            ["<C-p>"] = { "select_prev", "fallback" },
            ["<C-n>"] = { "select_next", "fallback" },
            ["<C-d>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },
            ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        },

        appearance = { nerd_font_variant = "mono" },

        completion = {
            documentation = { auto_show = true },
            -- auto-insert () for functions/methods (replaces cmp+autopairs hook)
            accept = { auto_brackets = { enabled = true } },
        },

        sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
                -- lazydev: vim API completion in lua config; high priority,
                -- and skip LSP when lazydev returns results (fallback = false)
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
            },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
