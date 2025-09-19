local set = vim.opt
local global = vim.g
local fnc = vim.fn
local api = vim.api

global.mapleader = ","

set.backspace = { "indent", "eol", "start" }
-- vim.opt.cc = "80"
set.clipboard = "unnamedplus"
set.completeopt = "menu,menuone,noselect"
set.cursorline = true
set.encoding = "utf-8" -- Set default encoding to UTF-8
set.expandtab = true   -- Use spaces instead of tabs
set.foldenable = false
set.foldmethod = "indent"
set.formatoptions = "l"
set.hidden = true        -- Enable background buffers
set.hlsearch = true      -- Highlight found searches
set.ignorecase = true    -- Ignore case
set.inccommand = "split" -- Get a preview of replacements
set.incsearch = true     -- Shows the match while typing
set.joinspaces = false   -- No double spaces with join
set.linebreak = true     -- Stop words being broken on wrap
set.list = false         -- Show some invisible characters
set.mouse = "a"          -- Enable mouse
set.number = true        -- Show line numbers
set.numberwidth = 4      -- Make the gutter wider by default
set.scrolloff = 4        -- Lines of context
set.shiftround = true    -- Round indent
set.shiftwidth = 4       -- Size of an indent
set.showmode = false     -- Don't display mode
set.sidescrolloff = 8    -- Columns of context
set.signcolumn = "yes:1" -- always show signcolumns
set.smartcase = true     -- Do not ignore case with capitals
set.smartindent = true   -- Insert indents automatically
set.spelllang = "en"
set.splitbelow = true    -- Put new windows below current
set.splitright = true    -- Put new windows right of current
set.tabstop = 4          -- Number of spaces tabs count for

set.termguicolors = true

set.undodir = fnc.stdpath("data") .. "/undo"
set.undofile = true
set.wrap = true

set.syntax = 'on'

api.nvim_exec([[
    augroup HighlightOnYank
        autocmd!
        autocmd TextYankPost * lua vim.highlight.on_yank { higroup = 'IncSearch', timeout = 150, on_visual = true }
    augroup END
]], false)
