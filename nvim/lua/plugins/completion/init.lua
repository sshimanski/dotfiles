return {
    "hrsh7th/nvim-cmp",
    config = function()
        require("plugins.completion.config")
    end,
    requires = {
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-nvim-lua" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "saadparwaiz1/cmp_luasnip" }, -- luasnip completion source for nvim-cmp
    },
}
