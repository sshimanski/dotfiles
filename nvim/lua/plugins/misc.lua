return {
    -- Tim Pope helper plugins
    { "tpope/vim-unimpaired" },
    -- vim-commentary dropped: nvim 0.10+ has built-in `gc`/`gcc` commenting
    -- vim-surround/vim-repeat dropped -> nvim-surround (lua, built-in dot-repeat)
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {},
    },

    -- autosave (okuuva fork; Pocco81 original is archived)
    {
        "okuuva/auto-save.nvim",
        config = function()
            require("auto-save").setup({})
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            -- check_ts: treesitter-aware, don't pair inside strings/comments
            require("nvim-autopairs").setup({ check_ts = true })
        end,
    },
    {
        'HiPhish/rainbow-delimiters.nvim',
        submodules = false, -- Важно для корректной сборки в lazy.nvim
        config = function()
            local rainbow_delimiters = require('rainbow-delimiters')

            vim.g.rainbow_delimiters = {
                strategy = {
                    [''] = rainbow_delimiters.strategy['global'],
                    vim = rainbow_delimiters.strategy['local'],
                },
                query = {
                    [''] = 'rainbow-delimiters',
                    lua = 'rainbow-blocks',
                },
                highlight = {
                    'RainbowDelimiterRed',
                    'RainbowDelimiterYellow',
                    'RainbowDelimiterBlue',
                    'RainbowDelimiterOrange',
                    'RainbowDelimiterGreen',
                    'RainbowDelimiterViolet',
                    'RainbowDelimiterCyan',
                },
            }
        end
    },


    -- flash.nvim (motion; replaces abandoned hop.nvim)
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "o" },      function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    },

    -- helper lib for other plugins
    { "nvim-lua/plenary.nvim" },

    -- just for fun (lazy: only on command)
    { "eandrju/cellular-automaton.nvim", cmd = "CellularAutomaton" },
    -- 1. Красивый рендеринг прямо в Neovim (заголовки, таблицы, списки)
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
        ft = { "markdown" },
        opts = {},
    },
}
