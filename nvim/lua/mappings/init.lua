local map = function(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end

	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "Y", "yg_")
-- centering window when hit n/N
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("x", "<leader>p", "_dP")
-- traversing windows with Alt+Tab
map("n", "<M-Tab>", "<C-w>w")

map("n", "<leader><leader>c", "<cmd>lua require('hop').hint_char1()<CR>")
map("n", "<leader><leader>l", "<cmd>lua require('hop').hint_lines_skip_whitespace()<CR>")
map("n", "<leader><leader>L", "<cmd>lua require('hop').hint_lines()<CR>")
map("n", "<leader><leader>p", "<cmd>lua require('hop').hint_patterns()<CR>")
map("n", "<leader><leader>w", "<cmd>lua require('hop').hint_words()<CR>")

map("v", "<leader><leader>c", "<cmd>lua require('hop').hint_char1()<CR>")
map("v", "<leader><leader>l", "<cmd>lua require('hop').hint_lines_skip_whitespaces()<CR>")
map("v", "<leader><leader>L", "<cmd>lua require('hop').hint_lines()<CR>")
map("v", "<leader><leader>p", "<cmd>lua require('hop').hint_patterns()<CR>")
map("v", "<leader><leader>w", "<cmd>lua require('hop').hint_words()<CR>")

map("n", "<leader>ev", "<cmd>lua require('utils').dotfiles()<CR>")
map("n", "<leader>sv", ":luafile ~/dotfiles/nvim/init.lua<CR>")
map("n", "<leader>k", ":bd<CR>")

-- LSP
map("n", "<M-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
map("i", "<M-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
-- dr = do rename
map("n", "<leader>dr", "<cmd>lua vim.lsp.buf.rename()<CR>")
-- df = do formatting
map("n", "<leader>df", "<cmd>lua vim.lsp.buf.formatting()<CR>")
map("v", "<leader>df", "<cmd>lua vim.lsp.buf.range_formatting()<CR>")
-- dl = do list
map("n", "<leader>dl", "<cmd>lua vim.lsp.buf.list_workspace_folders()<CR>")

-- Telescope

map("n", "<leader>gg", ":Neogit<CR>")
-- gs = Git Status
map("n", "<leader>gs", "<cmd>lua require('telescope.builtin').git_status()<CR>")
-- gc = Git Commits
map("n", "<leader>gc", "<cmd>lua require('telescope.builtin').git_commits()<CR>")
-- gd = Git Diff
map("n", "<leader>gd", "<cmd>lua require('telescope.builtin').git_bcommits()<CR>")
-- lf = List Files
map("n", "<leader>lf", "<cmd>lua require('utils').project_files()<CR>")
-- ga = Git Annotate (blame)
map("n", "<leader>ga", "<cmd>lua require('gitsigns').blame_line({})<CR>")
-- ga = Git branches
map("n", "<leader>gb", "<cmd>lua require('telescope.builtin').git_branches({})<CR>")

-- !!!
map("n", "<leader>b", "<cmd>lua require('telescope.builtin').builtin()<CR>")

-- fb = Fzf Buffer
map("n", "<leader>fb", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>")
-- fp = Fzf Project
map("n", "<leader>fp", "<cmd>lua require('telescope.builtin').live_grep()<CR>")
map("n", "<leader>fw", "<cmd>lua require('telescope.builtin').grep_string { search = vim.fn.expand('<cword>') }<CR>")

-- la = List Actions
map("n", "<leader>la", "<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>")
map("v", "<leader>la", "<cmd>lua require('telescope.builtin').lsp_range_code_actions()<CR>")
-- lb = List Buffers
map("n", "<leader>lb", "<cmd>lua require('telescope.builtin').buffers()<CR>")
-- ld = List Dir (current working dir)
map("n", "<leader>ld", "<cmd>lua require('telescope.builtin').find_files()<CR>")
-- le = List Errors
map("n", "<leader>le", "<cmd>lua require('telescope.builtin').diagnostics()<CR>")
-- lh = list help
map("n", "<leader>lh", "<cmd>lua require('telescope.builtin').help_tags()<CR>")
-- lr = List Recent
map("n", "<leader>lr", "<cmd>lua require('telescope.builtin').oldfiles()<CR>")
-- ls = List Symbols; (Ctrl-l) - to filter symbols
map("n", "<leader>ls", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>")
-- lw = List Workspace
map("n", "<leader>lw", "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>")

-- tu = to Usages
map("n", "<leader>tu", "<cmd>lua require('telescope.builtin').lsp_references()<CR>")
-- td = to Definition
map("n", "<leader>td", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>")
-- tt = to Type
map("n", "<leader>tt", "<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>")
-- ti = to Implementations
map("n", "<leader>ti", "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>")

map("n", "<M-1>", "<cmd>lua require('nvim-tree').toggle(true)<CR>")
map("n", "<leader>z", "<cmd>lua require('nvim-tree').find_files(true)<CR>")
