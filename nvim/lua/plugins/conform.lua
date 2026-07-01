return {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    keys = {
        {
            "grf",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            mode = { "n", "v" },
            desc = "Format buffer / range",
        },
    },
    opts = {
        formatters_by_ft = {
            python = { "ruff_organize_imports", "ruff_format" },
            java = { "google-java-format" },
            toml = { "taplo" },
            go = { "goimports", "gofmt", stop_after_first = true },
            rust = { "rustfmt" },
            lua = { "stylua" },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            typescript = { "prettierd", "prettier", stop_after_first = true },
            json = { "prettierd", "prettier", stop_after_first = true },
            yaml = { "prettierd", "prettier", stop_after_first = true },
        },
        -- format on save disabled: format manually with <leader>rf
    },
}
