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
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")
map("x", "<Leader>p", "_dP")

map("n", "<leader><leader>c", "<cmd>lua require('hop').hint_char1()<CR>")
map("n", "<leader><leader>l", "<cmd>lua require('hop').hint_lines_skip_whitespaces()<CR>")
map("n", "<leader><leader>p", "<cmd>lua require('hop').hint_patterns()<CR>")
map("n", "<leader><leader>w", "<cmd>lua require('hop').hint_words()<CR>")

map("v", "<leader><leader>c", "<cmd>lua require('hop').hint_char1()<CR>")
map("v", "<leader><leader>l", "<cmd>lua require('hop').hint_lines_skip_whitespaces()<CR>")
map("v", "<leader><leader>p", "<cmd>lua require('hop').hint_patterns()<CR>")
map("v", "<leader><leader>w", "<cmd>lua require('hop').hint_words()<CR>")

map("n", "<Leader>ev", "<cmd>lua require('utils').dotfiles()<CR>")
map("n", "<Leader>sv", ":luafile '~/dotfiles/nvim/init.lua'<CR>")
map("n", "<Leader>k", ":bd<CR>")

-- LSP
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
-- dr = do rename
map("n", "<Leader>dr", "<cmd>lua vim.lsp.buf.rename()<CR>")
-- df = do formatting
map("n", "<Leader>df", "<cmd>lua vim.lsp.buf.formatting()<CR>")
map("v", "<Leader>df", "<cmd>lua vim.lsp.buf.range_formatting()<CR>")
-- dl = do list
map("n", "<Leader>dl", "<cmd>lua vim.lsp.buf.list_workspace_folders()<CR>")

-- Telescope

-- gs = Git Status
map("n", "<Leader>gs", "<cmd>lua require('telescope.builtin').git_status()<CR>")
-- gc = Git Commits
map("n", "<Leader>gc", "<cmd>lua require('telescope.builtin').git_commits()<CR>")
-- gd = Git Diff
map("n", "<Leader>gd", "<cmd>lua require('telescope.builtin').git_bcommits()<CR>")
-- gf = Git Files
map("n", "<Leader>lf", "<cmd>lua require('telescope.builtin').git_files()<CR>")
-- gb = Git blame
map("n", "<Leader>gb", "<cmd>lua require('gitsigns').blame_line(true)<CR>")

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
map("n", "<Leader>lb", "<cmd>lua require('telescope.builtin').buffers()<CR>")
-- lC = List Commands
map("n", "<Leader>lc", "<cmd>lua require('telescope.builtin').commands()<CR>")
-- ld = List Dir (current working dir)
map("n", "<Leader>ld", "<cmd>lua require('telescope.builtin').find_files()<CR>")
-- le = List Errors
map("n", "<Leader>le", "<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>")
map("n", "<Leader>lE", "<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<CR>")
-- lh = list help
map("n", "<Leader>lh", "<cmd>lua require('telescope.builtin').help_tags()<CR>")
-- lq = List Quickfix
map("n", "<Leader>lq", "<cmd>lua require('telescope.builtin').quickfix()<CR>")
-- lr = List Recent
map("n", "<Leader>lr", "<cmd>lua require('telescope.builtin').oldfiles()<CR>")
-- ls = List Symbols; (Ctrl-l) - to filter symbols
map("n", "<Leader>ls", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>")
-- lw = List Workspace
map("n", "<Leader>lw", "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>")

-- tu = to Usages
map("n", "<Leader>tu", "<cmd>lua require('telescope.builtin').lsp_references()<CR>")
-- td = to Definition
map("n", "<Leader>td", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>")
-- tt = to Type
map("n", "<Leader>tt", "<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>")
-- ti = to Implementations
map("n", "<Leader>ti", "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>")
