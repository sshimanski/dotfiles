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

map("n", "<leader>cl", ":e ~/.local/state/nvim/lsp.log<CR>")
map("n", "<leader>ev", "<cmd>lua require('utils').dotfiles()<CR>")
map("n", "<leader>sv", ":luafile ~/dotfiles/nvim/init.lua<CR>")
map("n", "<leader>k", ":bd<CR>")

map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
-- map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions({})<CR>")

-- rr = refactor: rename
map("n", "<leader>rr", "<cmd>lua vim.lsp.buf.rename()<CR>")
-- rf = refactor: format
map("n", "<leader>rf", "<cmd>lua vim.lsp.buf.format({async = true})<CR>")
map("v", "<leader>rf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>")

-- TODO
-- dl = do list
map("n", "<leader>dl", "<cmd>lua vim.lsp.buf.list_workspace_folders()<CR>")


-- Debugger
map("n", "<F9>", '<Cmd>:lua require"dap".continue()<CR>')
map("n", "<F7>", '<Cmd>lua require"dap".step_into()<CR>')
map("n", "<F8>", '<Cmd>lua require"dap".step_over()<CR>')
map("n", "<S-F8>", '<Cmd>lua require"dap".step_out()<CR>')
-- db = debug breakpoint
map("n", "<leader>db", '<Cmd>lua require"dap".toggle_breakpoint()<CR>')
map("n", "<Leader>dB", "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
-- db = debug repl
map("n", "<leader>dr", '<Cmd>lua require"dap".repl.toggle()<CR>')
-- db = debug debug
map("n", "<leader>dd", '<Cmd>lua require"dapui".toggle()<CR>')


-- ga = Git Annotate (blame)
map("n", "<leader>ga", "<cmd>lua require('gitsigns').blame_line({})<CR>")
-- ga = Git branches
map("n", "<leader>gb", "<cmd>lua require('telescope.builtin').git_branches({})<CR>")
-- gc = Git Commits
map("n", "<leader>gc", "<cmd>lua require('telescope.builtin').git_commits()<CR>")
-- ga = Git Diff
map("n", "<leader>gd", "<cmd>lua require('gitsigns').preview_hunk({})<CR>")
-- gg = Git Git
map("n", "<leader>gg", ":Neogit<CR>")
-- gd = Git History (Buffer commits)
map("n", "<leader>gh", "<cmd>lua require('telescope.builtin').git_bcommits()<CR>")
-- gs = Git Status
map("n", "<leader>gs", "<cmd>lua require('telescope.builtin').git_status()<CR>")

-- !!!
map("n", "<leader>b", "<cmd>lua require('telescope.builtin').builtin()<CR>")

-- fb = find Buffer
map("n", "<leader>fb", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>")
-- fp = find Project
map("n", "<leader>fp", "<cmd>lua require('telescope.builtin').live_grep()<CR>")
-- fw = find Word
map("n", "<leader>fw", "<cmd>lua require('telescope.builtin').grep_string { search = vim.fn.expand('<cword>') }<CR>")

-- la = List Actions
map("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("v", "<leader>la", "<cmd>lua vim.lsp.buf.range_code_action()<CR>")
-- lb = List Buffers
map("n", "<leader>lb", "<cmd>lua require('telescope.builtin').buffers()<CR>")
-- ld = List Dir (current working dir)
map("n", "<leader>ld", "<cmd>lua require('telescope.builtin').find_files()<CR>")
-- le = List Errors
map("n", "<leader>le", "<cmd>lua require('telescope.builtin').diagnostics()<CR>")
-- lf = List Files
map("n", "<leader>lf", "<cmd>lua require('utils').project_files()<CR>")
-- lh = list help
map("n", "<leader>lh", "<cmd>lua require('telescope.builtin').help_tags()<CR>")
-- lm = list marks
map("n", "<leader>lm", "<cmd>lua require('telescope.builtin').marks()<CR>")
-- lr = List Recent
map("n", "<leader>lr", "<cmd>lua require('telescope.builtin').oldfiles()<CR>")
-- lr = List Registers
map("n", "<leader>lR", "<cmd>lua require('telescope.builtin').registers()<CR>")
-- ls = List Symbols; (Ctrl-l) - to filter symbols
map("n", "<leader>ls", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>")
-- lw = List Workspace
map("n", "<leader>lw", "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>")

-- tu = to Usages
map("n", "<leader>tu", "<cmd>lua require('telescope.builtin').lsp_references()<CR>")
-- tt = to Type
map("n", "<leader>tt", "<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>")
-- ti = to Implementations
map("n", "<leader>ti", "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>")

map("n", "<M-1>", "<cmd>lua require('nvim-tree.api').tree.toggle()<CR>")
map("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
