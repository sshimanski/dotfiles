return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")

        -- only linters NOT already covered by an LSP (ruff-LSP lints Python).
        lint.linters_by_ft = {
            go = { "golangcilint" },
            sh = { "shellcheck" },
            bash = { "shellcheck" },
            dockerfile = { "hadolint" },
        }

        local group = vim.api.nvim_create_augroup("nvim_lint", { clear = true })
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
            group = group,
            callback = function()
                -- run only if the linter binary exists; ignore otherwise
                require("lint").try_lint(nil, { ignore_errors = true })
            end,
        })
    end,
}
