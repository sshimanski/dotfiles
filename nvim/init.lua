local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end

  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Map leader to space
vim.g.mapleader = ","

-- Bootstrap Paq when needed
local install_path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({ "git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", install_path })
end

-- Plugins
require("paq-nvim")({
  "savq/paq-nvim",

  "neovim/nvim-lspconfig",
  "kabouzeid/nvim-lspinstall",

  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
  "nvim-telescope/telescope.nvim",
  "nvim-treesitter/nvim-treesitter",

  "glepnir/lspsaga.nvim",
  "hoob3rt/lualine.nvim",
  "kyazdani42/nvim-web-devicons",
  "ryanoasis/vim-devicons",

  "hrsh7th/nvim-cmp",
  -- cmp sources
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-buffer",

  "hrsh7th/vim-vsnip",

  "onsails/lspkind-nvim",
  "p00f/nvim-ts-rainbow",
  "phaazon/hop.nvim",
  "tpope/vim-repeat",
  "tpope/vim-surround",

  "simrat39/rust-tools.nvim",
  "arcticicestudio/nord-vim",
})

require("nvim-treesitter.configs").setup({
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  },
})

-- lspkind Icon setup
require("lspkind").init({})

require("lspinstall").setup() -- important

local servers = require("lspinstall").installed_servers()
for _, server in pairs(servers) do
    if server == 'rust' then
        local configs = require'lspconfig/configs'
        rawset(configs, 'rust_analyzer', configs['rust'])
    end

    require("lspconfig")[server].setup{}
end

require("rust-tools").setup({})

require("lspsaga").init_lsp_saga({})

vim.opt.backspace = { "indent", "eol", "start" }
-- vim.opt.cc = "80"
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.cursorline = true
vim.opt.encoding = "utf-8" -- Set default encoding to UTF-8
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.foldenable = false
vim.opt.foldmethod = "indent"
vim.opt.formatoptions = "l"
vim.opt.hidden = true
vim.opt.hidden = true -- Enable background buffers
vim.opt.hlsearch = true -- Highlight found searches
vim.opt.ignorecase = true -- Ignore case
vim.opt.inccommand = "split" -- Get a preview of replacements
vim.opt.incsearch = true -- Shows the match while typing
vim.opt.joinspaces = false -- No double spaces with join
vim.opt.linebreak = true -- Stop words being broken on wrap
vim.opt.list = false -- Show some invisible characters
vim.opt.mouse = "a"
vim.opt.number = true -- Show line numbers
vim.opt.numberwidth = 5 -- Make the gutter wider by default
vim.opt.scrolloff = 4 -- Lines of context
vim.opt.shiftround = true -- Round indent
vim.opt.shiftwidth = 4 -- Size of an indent
vim.opt.showmode = false -- Don't display mode
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.signcolumn = "yes:1" -- always show signcolumns
vim.opt.smartcase = true -- Do not ignore case with capitals
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.spelllang = "en"
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.tabstop = 4 -- Number of spaces tabs count for
--vim.opt.termguicolors = true -- You will have bad experience for diagnostic messages when it's default 4000.
vim.opt.undodir = vim.fn.stdpath("config") .. "/undo"
vim.opt.undofile = true
vim.opt.wrap = true

vim.cmd('colorscheme nord')

require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = "nord",
    },
    tabline = {
        lualine_a = {},
        lualine_b = {'branch'},
        lualine_c = {'filename'},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    }
})

-- Hop
require("hop").setup()
map("n", "<leader>h", "<cmd>lua require'hop'.hint_char2()<cr>")
map("n", "<leader>l", "<cmd>lua require'hop'.hint_lines()<cr>")
map("v", "<leader>h", "<cmd>lua require'hop'.hint_char2()<cr>")
map("v", "<leader>l", "<cmd>lua require'hop'.hint_lines()<cr>")

map("n", "<Leader>ev", "<cmd>e $MYVIMRC<CR>")
map("n", "<Leader>sv", ":luafile %<CR>")

local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args) vim.fn["vsnip#anonymous"](args.body) end
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'buffer' },
      { name = 'path' },
    }
})
