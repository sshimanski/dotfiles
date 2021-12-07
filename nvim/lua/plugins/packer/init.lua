local packer = require("packer")

packer.init({
    git = {
        clone_timeout = 180, -- Timeout, in seconds
    },
    profile = {
        enable = true,
        -- integer in milliseconds, plugins which load faster than this
        -- won't be shown in profile output
        threshold = 1,
    },
})

local plugins = {
    -- plugin manager
    {"wbthomason/packer.nvim"},

    -- helper lib for other plugins
    {"nvim-lua/plenary.nvim"},
    -- popups
    {"nvim-lua/popup.nvim"},

    -- config for LSP clients
    {"neovim/nvim-lspconfig"},
    -- easy install LSP servers
    require("plugins.lspinstaller"),

    -- super cool lists and more
    require("plugins.telescope"),
    -- nvim interface for tree-sitter (parser/generator; syntax tree) + textobjects
    require("plugins.treesitter"),

    -- fancy icons (nerd fonts required)
    {
        "kyazdani42/nvim-web-devicons",
        config = require("nvim-web-devicons").setup({})
    },

    -- A completion engine plugin for neovim written in Lua. Completion sources are installed from external repositories and "sourced".
    require("plugins.completion"),

    -- require("plugins.completion"),
    {"L3MON4D3/LuaSnip"},
    {"rafamadriz/friendly-snippets"},

    -- parentheses for neovim using tree-sitter
    {"p00f/nvim-ts-rainbow"},
    -- Hop (easy motion successor)
    {
        "phaazon/hop.nvim",
        config =  require("hop").setup({})
    },

    -- Tim Pope helper plugins
    {"tpope/vim-repeat"},
    {"tpope/vim-surround"},
    {"tpope/vim-unimpaired"},
    {"tpope/vim-commentary"},

    -- rust tools
    require("plugins.rust-tools"),
    -- java tools
    {"mfussenegger/nvim-jdtls"},

    -- colorscheme
    {"arcticicestudio/nord-vim"},

    -- autosave
    {
        "Pocco81/AutoSave.nvim",
        config = require("autosave").setup({})
    },

    -- fancy status line
    require("plugins.lualine"),

    {
        "lewis6991/gitsigns.nvim",
        config = require('gitsigns').setup({})
    },

    require("plugins.neogit"),

    {
        "plasticboy/vim-markdown"
    },

    require("plugins.nvim-tree")
}

-- one more comment
-- do use plugins with configs
packer.startup(function(use)
    for _, plugin in ipairs(plugins) do
        use(plugin)
    end
end)