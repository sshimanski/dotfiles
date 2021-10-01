return {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = require("plugins.treesitter.config"),
    requires = {
        "nvim-treesitter/nvim-treesitter-refactor",
        "nvim-treesitter/nvim-treesitter-textobjects",
        "David-Kunz/treesitter-unit",
    },
}
