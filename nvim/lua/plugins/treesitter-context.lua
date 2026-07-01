return {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        max_lines = 3,            -- max sticky context lines
        multiline_threshold = 1,  -- collapse multiline nodes to 1 line
        mode = "cursor",
    },
    keys = {
        { "<leader>lx", function() require("treesitter-context").go_to_context() end, desc = "Jump to context" },
    },
}
