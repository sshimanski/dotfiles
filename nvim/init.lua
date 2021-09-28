local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end

	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Plugins
require('packer').startup( function(use)
    -- plugin manager
	use "wbthomason/packer.nvim"
    -- config for LSP clients
	use "neovim/nvim-lspconfig"
	-- easy install LSP servers
	use "kabouzeid/nvim-lspinstall"
    -- helper lib for other plugins
	use "nvim-lua/plenary.nvim"
    -- popups
	use "nvim-lua/popup.nvim"
    -- super cool lists and more
    use "nvim-telescope/telescope.nvim"
    -- nvim interface for tree-sitter (parser/generator; syntax tree)
	use "nvim-treesitter/nvim-treesitter"
    -- nice info line
	use "kyazdani42/nvim-web-devicons" -- nerd fonts required
    -- completion tool
	use "hrsh7th/nvim-cmp"
    -- git signs
    use "lewis6991/gitsigns.nvim"

	-- cmp sources
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/cmp-vsnip"
	use "hrsh7th/cmp-path"
	use "hrsh7th/cmp-buffer"

    -- V(SCode) Snip(pet) like plugin.
	use "hrsh7th/vim-vsnip"
    -- parentheses for neovim using tree-sitter
	use "p00f/nvim-ts-rainbow"
    -- quick jump
	use "phaazon/hop.nvim"

    -- Tim Pope helper plugins
	use "tpope/vim-repeat"
	use "tpope/vim-surround"
	use "tpope/vim-unimpaired"
    use "tpope/vim-commentary"

    -- rust tools
	use "simrat39/rust-tools.nvim"
    -- java tools (TODO: unable to configure)
    use "mfussenegger/nvim-jdtls"

	-- colorscheme
	use "arcticicestudio/nord-vim"

    -- autosave
    use "Pocco81/AutoSave.nvim"

    -- TODO
	-- use "hoob3rt/lualine.nvim"
    use "shadmansaleh/lualine.nvim"

    use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
    use {'sindrets/diffview.nvim'}
end)

vim.g.mapleader = ","

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
vim.opt.hidden = true -- Enable background buffers
vim.opt.hlsearch = true -- Highlight found searches
vim.opt.ignorecase = true -- Ignore case
vim.opt.inccommand = "split" -- Get a preview of replacements
vim.opt.incsearch = true -- Shows the match while typing
vim.opt.joinspaces = false -- No double spaces with join
vim.opt.linebreak = true -- Stop words being broken on wrap
vim.opt.list = false -- Show some invisible characters
vim.opt.mouse = "a" -- Enable mouse
vim.opt.number = true -- Show line numbers
vim.opt.numberwidth = 4 -- Make the gutter wider by default
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

vim.opt.termguicolors = true -- 

vim.opt.undodir = vim.fn.stdpath("config") .. "/undo"
vim.opt.undofile = true
vim.opt.wrap = true

vim.opt.syntax = 'on'

vim.cmd([[ colorscheme nord ]])

map("n", "<leader><leader>c", "<cmd>lua require('hop').hint_char1()<CR>")
map("n", "<leader><leader>l", "<cmd>lua require('hop').hint_lines()<CR>")
map("n", "<leader><leader>w", "<cmd>lua require('hop').hint_words()<CR>")
map("n", "<leader><leader>p", "<cmd>lua require('hop').hint_patterns()<CR>")

map("v", "<leader><leader>c", "<cmd>lua require('hop').hint_char1()<CR>")
map("v", "<leader><leader>l", "<cmd>lua require('hop').hint_lines()<CR>")
map("v", "<leader><leader>w", "<cmd>lua require('hop').hint_words()<CR>")
map("v", "<leader><leader>p", "<cmd>lua require('hop').hint_patterns()<CR>")


map("n", "<Leader>ev", "<cmd>e $MYVIMRC<CR>")
map("n", "<Leader>sv", ":luafile %<CR>")
map("n", "<Leader>k", ":bd<CR>")

-- LSP
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "<Leader>dr", "<cmd>lua vim.lsp.buf.rename()<CR>")
map("n", "<Leader>df", "<cmd>lua vim.lsp.buf.formatting()<CR>")
map("v", "<Leader>df", "<cmd>lua vim.lsp.buf.range_formatting()<CR>")
map("v", "<Leader>dl", "<cmd>lua vim.lsp.buf.list_workspace_folders()<CR>")

-- Telescope

-- gs = Git Status
map("n", "<Leader>gs", "<cmd>lua require('telescope.builtin').git_status()<CR>")
-- gc = Git Commits
map("n", "<Leader>gc", "<cmd>lua require('telescope.builtin').git_commits()<CR>")
-- gd = Git Diff
map("n", "<Leader>gd", "<cmd>lua require('telescope.builtin').git_bcommits()<CR>")
-- gf = Git Files
map("n", "<Leader>gf", "<cmd>lua require('telescope.builtin').git_files({path_display={'shorten'}})<CR>")
-- gb = Git blame
map("n", "<Leader>gb", "<cmd>lua require('gitsigns').blame_line()<CR>")

-- sb = Search Buffer
map("n", "<Leader>sb", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>")
-- sd = Search Directory
map("n", "<Leader>sd", "<cmd>lua require('telescope.builtin').live_grep()<CR>")

-- Lists files and folders in your current working directory, open files,
-- navigate your filesystem, and create new files and folders
-- e = Explorer
map("n", "<Leader>e", "<cmd>lua require('telescope.builtin').file_browser()<CR>")

-- la = List Actions
map("n", "<Leader>la", "<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>")
map("v", "<Leader>la", "<cmd>lua require('telescope.builtin').lsp_range_code_actions()<CR>")
-- lb = List Buffers
map("n", "<Leader>lb", "<cmd>lua require('telescope.builtin').buffers({path_display={'tail'}})<CR>")
-- lC = List Commands
map("n", "<Leader>lc", "<cmd>lua require('telescope.builtin').commands()<CR>")
-- Lists files in current working directory, respects .gitignore
-- ld = List Files (in current working dir)
map("n", "<Leader>lf", "<cmd>lua require('telescope.builtin').find_files({path_display={'tail'}})<CR>")
-- le = List Errors
map("n", "<Leader>le", "<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>")
-- lq = List Quickfix
map("n", "<Leader>lq", "<cmd>lua require('telescope.builtin').quickfix()<CR>")
-- ls = List Symbols; (Ctrl-l) - to filter symbols
map("n", "<Leader>ls", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>")
-- lr = List Recent
map("n", "<Leader>lr", "<cmd>lua require('telescope.builtin').oldfiles()<CR>")
-- lw = List Workspace
map("n", "<Leader>lw", "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>")

-- lu = to Usages
map("n", "<Leader>tu", "<cmd>lua require('telescope.builtin').lsp_references()<CR>")
-- td = to Definition
map("n", "<Leader>td", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>")
-- tt = to Type
map("n", "<Leader>tt", "<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>")
-- ti = to Implementations
map("n", "<Leader>ti", "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>")

require('lualine').setup({
	options = { theme = "nord" }
})

-- Hop (quick jump)
require("hop").setup()

require("nvim-treesitter.configs").setup({
    highlight = {enable = true},
	rainbow = {
		enable = true,
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
	},
    autopairs = {enable = true}
})

require("lspinstall").setup() -- important

local servers = require("lspinstall").installed_servers()
for _, server in pairs(servers) do
    -- The server name must match those found in the table of contents in lspconfig/CONFIG.md
    if server ~= 'java' then
        local configs = require'lspconfig/configs'
        if server == 'rust' then
            -- 'rust' doesn't match, but 'rust_analyzer' does
            rawset(configs, 'rust_analyzer', configs['rust'])
            require("lspconfig")['rust_analyzer'].setup{}
        elseif server == 'lua' then
            -- 'lua' doesn't match, but 'sumneko_lua' does
            rawset(configs, 'sumneko_lua', configs['lua'])
            require("lspconfig")['sumneko_lua'].setup({})
        else
            require("lspconfig")[server].setup{}
        end
    end
end

require("rust-tools").setup({})

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

require("telescope").setup({})

require("nvim-web-devicons").setup({})

require('gitsigns').setup({})

require('diffview').setup({})
