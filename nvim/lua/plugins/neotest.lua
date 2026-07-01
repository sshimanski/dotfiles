return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",

        -- language adapters (match installed LSP/test stacks)
        "nvim-neotest/neotest-python",
        "fredrikaverpil/neotest-golang",
        "rcasia/neotest-java",
    },
    keys = {
        { "<leader>tn", function() require("neotest").run.run() end,                     desc = "Test: nearest" },
        { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,   desc = "Test: file" },
        { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Test: debug nearest" },
        { "<leader>ts", function() require("neotest").summary.toggle() end,              desc = "Test: summary" },
        { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Test: output" },
        { "<leader>tO", function() require("neotest").output_panel.toggle() end,         desc = "Test: output panel" },
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python")({ dap = { justMyCode = false } }),
                require("neotest-golang")({}),
                require("neotest-java")({}),
            },
        })
    end,
}
