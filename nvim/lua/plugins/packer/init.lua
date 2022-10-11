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

    {
        "goolord/alpha-nvim",
        requires = { "kyazdani42/nvim-web-devicons" },
        config = require'alpha'.setup(require'alpha.themes.startify'.config)
    },

    -- helper lib for other plugins
    {"nvim-lua/plenary.nvim"},
    -- popups
    {"nvim-lua/popup.nvim"},

    -- config for LSP clients
    {"neovim/nvim-lspconfig"},
    -- easy install LSP servers
    require("plugins.lspinstaller"),
    -- deugging
    require("plugins.dap"),
    {
        'rcarriga/nvim-dap-ui',
        config = require("dapui").setup()
    },

    -- super cool lists and more
    require("plugins.telescope"),
    {"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
    {"nvim-telescope/telescope-symbols.nvim"},
    {"nvim-telescope/telescope-ui-select.nvim"},
    {"tom-anders/telescope-vim-bookmarks.nvim"},

    -- nvim interface for tree-sitter (parser/generator; syntax tree) + textobjects
    require("plugins.treesitter"),

    -- fancy icons (nerd fonts required)
    {
        "kyazdani42/nvim-web-devicons",
        config = require("nvim-web-devicons").setup({})
    },

    -- A completion engine plugin for neovim written in Lua. Completion sources are installed from external repositories and "sourced".
    require("plugins.completion"),

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
        "Pocco81/auto-save.nvim",
        config = require("auto-save").setup({})
    },
    {
        "windwp/nvim-autopairs",
        config = require("nvim-autopairs").setup({})
    },

    -- fancy status line
    require("plugins.lualine"),

    -- git
    require("plugins.gitsigns"),
    require("plugins.neogit"),
    {"sindrets/diffview.nvim"},

    require("plugins.nvim-tree"),

    {"plasticboy/vim-markdown"},
    {"hashivim/vim-terraform"}
}

-- one more comment
-- do use plugins with configs
packer.startup(function(use)
    for _, plugin in ipairs(plugins) do
        use(plugin)
    end
end)
