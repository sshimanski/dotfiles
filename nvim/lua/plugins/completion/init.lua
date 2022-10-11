return {
    "hrsh7th/nvim-cmp",
    config = require("plugins.completion.config"),
    requires = {
        { "hrsh7th/cmp-buffer"},
        { "hrsh7th/cmp-path"},
        { "hrsh7th/cmp-nvim-lua"},
        { "hrsh7th/cmp-nvim-lsp"},
        { "saadparwaiz1/cmp_luasnip"}, -- luasnip completion source for nvim-cmp
    },
}
