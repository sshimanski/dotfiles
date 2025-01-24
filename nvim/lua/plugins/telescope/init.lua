return {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
        require("plugins.telescope.config")
    end,
}
