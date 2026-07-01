return {
    -- Themes (alternates: lazy, loaded only if selected)
    { "folke/tokyonight.nvim", lazy = true },
    { "shaunsingh/nord.nvim",  lazy = true },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,    -- main colorscheme: load at startup
        priority = 1000, -- before all other start plugins
        opts = {
            transparent_mode = true, -- no bg (replaces manual highlight overrides)
        },
        config = function(_, opts)
            require("gruvbox").setup(opts)
            vim.cmd.colorscheme("gruvbox")
        end,
    },

    -- greeter: now provided by snacks.dashboard (plugins/snacks.lua)

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "gruvbox",
                globalstatus = true, -- single statusline for all splits
            },
            extensions = { "nvim-tree", "toggleterm", "lazy", "mason" },
        },
    }
}
