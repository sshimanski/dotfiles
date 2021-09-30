return {
    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = require("plugins.treesitter.config"),
    },
    {
        "nvim-treesitter/nvim-treesitter-refactor",
        after = "nvim-treesitter",
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
    },
}
