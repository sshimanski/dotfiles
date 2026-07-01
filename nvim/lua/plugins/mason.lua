return {
    { "williamboman/mason-lspconfig.nvim" },

    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end,
    },

    -- auto-install formatters/linters/dap adapters used by conform & nvim-lint
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    -- formatters (conform)
                    "stylua",
                    "prettierd",
                    "goimports",
                    -- linters (nvim-lint)
                    "golangci-lint",
                    "shellcheck",
                    "hadolint",
                    -- java debug/test bundles (neotest-java debug)
                    "java-debug-adapter",
                    "java-test",
                },
                run_on_start = true,
            })
        end,
    }
}
