return {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
        require('plugins.nvim-tree.config')
    end,
}
