return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        -- completion engine (provides LSP capabilities)
        "saghen/blink.cmp",

        -- UI for notifications and LSP progress messages.
        "j-hui/fidget.nvim",
    },

    config = function()
        require("fidget").setup({
            window = {
                winblend = 90
            }
        })

        -- nvim 0.11 native LSP: configure with vim.lsp.config(), enable with
        -- vim.lsp.enable(). mason-lspconfig v2 auto-enables installed servers
        -- (`automatic_enable`), so no more per-server `handlers`.

        -- shared capabilities for every server (blink.cmp completion bits)
        vim.lsp.config("*", {
            capabilities = require("blink.cmp").get_lsp_capabilities(),
        })

        -- per-server overrides (merged on top of lspconfig's lsp/ defaults)
        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    runtime = { version = "Lua 5.1" },
                    diagnostics = { globals = { "vim" } },
                },
            },
        })

        -- mason.setup() lives in plugins/mason.lua (loaded first as a dependency)
        require("mason-lspconfig").setup({
            ensure_installed = {
                "gopls",
                "jdtls",
                "lua_ls",
                "pyright",
                "vtsls",
                "rust_analyzer",
            },
            -- jdtls is started by nvim-jdtls (ftplugin/java.lua); keep
            -- mason-lspconfig from auto-enabling it (would double-attach).
            automatic_enable = { exclude = { "jdtls" } },
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
