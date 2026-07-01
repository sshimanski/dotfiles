return {
    "folke/lazydev.nvim",
    ft = "lua", -- only load for lua files
    opts = {
        library = {
            -- complete vim.uv / luv types
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    },
}
