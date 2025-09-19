return {
    { "folke/tokyonight.nvim" },
    { "shaunsingh/nord.nvim" },
    { "arcticicestudio/nord-vim" },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd([[
            colorscheme gruvbox

            highlight Normal guibg=none
            highlight NonText guibg=none
            highlight Normal ctermbg=none
            highlight NonText ctermbg=none
            ]])
        end,
    },

    -- greeter (startup page)
    {
        "goolord/alpha-nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local startify = require("alpha.themes.startify")
            startify.file_icons.provider = "devicons"
            require('alpha').setup(startify.config)
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "gruvbox"
            }
        },
    }
}
