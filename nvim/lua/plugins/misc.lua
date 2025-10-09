return {
    -- Tim Pope helper plugins
    { "tpope/vim-repeat" },
    { "tpope/vim-surround" },
    { "tpope/vim-unimpaired" },
    { "tpope/vim-commentary" },

    -- autosave
    {
        "Pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup({})
        end,
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },

    -- parentheses for neovim using tree-sitter
    { "p00f/nvim-ts-rainbow" },

    -- Hop (easy motion successor)
    {
        "phaazon/hop.nvim",
        config = function()
            require("hop").setup({})
        end,
    },

    -- helper lib for other plugins
    { "nvim-lua/plenary.nvim" },

    -- popups
    { "nvim-lua/popup.nvim" },

    -- just for fun
    { "eandrju/cellular-automaton.nvim" },
}
