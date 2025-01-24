return {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    requires = {
        "nvim-treesitter/nvim-treesitter-refactor",
        "nvim-treesitter/nvim-treesitter-textobjects",
        "David-Kunz/treesitter-unit",
    },
    config = function() 
        require("plugins.treesitter.config")
    end,
}
