return {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
        { [[<C-\>]],     desc = "Toggle terminal" },
        { "<leader>tF", "<cmd>ToggleTerm direction=float<cr>",      desc = "Terminal: float" },
        { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal: horizontal" },
    },
    opts = {
        open_mapping = [[<C-\>]],
        direction = "float",
        float_opts = { border = "rounded" },
        size = function(term)
            if term.direction == "horizontal" then
                return 15
            end
        end,
    },
}
