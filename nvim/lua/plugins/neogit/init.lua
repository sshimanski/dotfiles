return {
    "NeogitOrg/neogit",
    config = function() 
        require("plugins.neogit.config")
    end,
    requires = {
        'nvim-lua/plenary.nvim',
    },
}
