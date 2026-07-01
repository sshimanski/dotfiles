local map = function(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    vim.keymap.set(mode, lhs, rhs, options)
end

vim.diagnostic.config({ jump = { float = true } })

-- ── editing / movement ──────────────────────────────────────────────
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("n", "Y", "yg_", { desc = "Yank to line end" })
map("n", "n", "nzzzv", { desc = "Next search (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search (centered)" })
map("x", "<leader>p", "_dP", { desc = "Paste (keep register)" })
map("n", "<M-Tab>", "<C-w>w", { desc = "Cycle windows" })

-- motion: flash.nvim — `s` jump, `S` treesitter (keys defined in plugins/misc.lua)

-- ── config / files ──────────────────────────────────────────────────
map("n", "<leader>L", ":Lazy<CR>", { desc = "Lazy plugin manager" })
map("n", "<leader>cl", ":e ~/.local/state/nvim/lsp.log<CR>", { desc = "Open LSP log" })
map("n", "<leader>ev", "<cmd>lua require('utils').dotfiles()<CR>", { desc = "Edit dotfiles" })
map("n", "<leader>sv", ":luafile ~/dotfiles/nvim/init.lua<CR>", { desc = "Reload init.lua" })
-- <leader>k = close buffer -> now Snacks.bufdelete (plugins/snacks.lua)

-- K (hover) removed: nvim 0.11+ sets buffer-local K = vim.lsp.buf.hover() OOB
--
-- Telescope on the built-in LSP keys (buffer-local, same semantics as the
-- native maps but with a fuzzy picker). grn/gra stay native (no telescope eqv).
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local tb = require("telescope.builtin")
        local function bmap(lhs, fn, desc)
            vim.keymap.set("n", lhs, fn, { buffer = args.buf, desc = desc })
        end
        bmap("gd", tb.lsp_definitions, "Goto definition")        -- enhances native gd
        bmap("grr", tb.lsp_references, "References")             -- overrides native grr
        bmap("gri", tb.lsp_implementations, "Implementations")   -- overrides native gri
        bmap("grt", tb.lsp_type_definitions, "Type definition")  -- overrides native grt
        bmap("gO", tb.lsp_document_symbols, "Document symbols")  -- overrides native gO

        -- CodeLens: enable auto-managed lenses so `grx` (codelens.run) works.
        -- vim.lsp.codelens.enable() handles refresh internally (0.11+).
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method("textDocument/codeLens") then
            vim.lsp.codelens.enable(true, { bufnr = args.buf })
        end
    end,
})

-- rename removed: use built-in `grn` (0.11+)
-- <leader>rf format now owned by conform.nvim (plugins/conform.lua, n+v)
-- visual range-format also via `gq` (LSP formatexpr, 0.11+)

map("n", "<leader>dl", "<cmd>lua vim.lsp.buf.list_workspace_folders()<CR>", { desc = "LSP: workspace folders" })

-- ── Debugger (DAP) ──────────────────────────────────────────────────
map("n", "<F9>", "<Cmd>lua require('dap').continue()<CR>", { desc = 'Debug: continue' })
map("n", "<F7>", "<Cmd>lua require('dap').step_into()<CR>", { desc = 'Debug: step into' })
map("n", "<F8>", "<Cmd>lua require('dap').step_over()<CR>", { desc = 'Debug: step over' })
map("n", "<S-F8>", "<Cmd>lua require('dap').step_out()<CR>", { desc = 'Debug: step out' })
map("n", "<leader>db", "<Cmd>lua require('dap').toggle_breakpoint()<CR>", { desc = 'Debug: toggle breakpoint' })
map("n", "<Leader>dB", "<Cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
    { desc = 'Debug: conditional breakpoint' })
map("n", "<leader>dr", "<Cmd>lua require('dap').repl.toggle()<CR>", { desc = 'Debug: toggle REPL' })
map("n", "<leader>dd", "<Cmd>lua require('dapui').toggle()<CR>", { desc = 'Debug: toggle UI' })
map("n", "<leader>dc", "<Cmd>lua require('telescope').extensions.dap.commands()<CR>", { desc = 'Debug: commands' })
map("n", "<leader>dC", "<Cmd>lua require('telescope').extensions.dap.configurations()<CR>", { desc = 'Debug: configurations' })
map("n", "<leader>dp", "<Cmd>lua require('telescope').extensions.dap.list_breakpoints()<CR>", { desc = 'Debug: list breakpoints' })
map("n", "<leader>df", "<Cmd>lua require('telescope').extensions.dap.frames()<CR>", { desc = 'Debug: frames' })
map("n", "<leader>dv", "<Cmd>lua require('telescope').extensions.dap.variables()<CR>", { desc = 'Debug: variables' })

-- ── Git ─────────────────────────────────────────────────────────────
map("n", "<leader>gb", "<cmd>lua require('telescope.builtin').git_branches({})<CR>", { desc = 'Git: branches' })
map("n", "<leader>gc", "<cmd>lua require('telescope.builtin').git_commits()<CR>", { desc = 'Git: commits' })
map("n", "<leader>gg", ":Gitsigns<CR>", { desc = "Git: menu" })
map("n", "<leader>gh", "<cmd>lua require('telescope.builtin').git_bcommits()<CR>", { desc = 'Git: buffer history' })
map("n", "<leader>gs", "<cmd>lua require('telescope.builtin').git_status()<CR>", { desc = 'Git: status' })

-- ── Find (f*) ───────────────────────────────────────────────────────
map("n", "<leader>b", "<cmd>lua require('telescope.builtin').builtin()<CR>", { desc = "Telescope: builtins" })
map("n", "<leader>fb", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", { desc = "Find: in buffer" })
map("n", "<leader>fp", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = "Find: grep (with args)" })
map("n", "<leader>fw", "<cmd>lua require('telescope.builtin').grep_string { search = vim.fn.expand('<cword>') }<CR>", { desc = "Find: word under cursor" })
map("n", "<leader>ff", "<cmd>lua require('telescope').extensions.frecency.frecency({ workspace = 'CWD' })<CR>", { desc = "Find: frecency files" })
map("n", "<leader>fe", "<cmd>lua require('telescope').extensions.file_browser.file_browser({ path = '%:p:h', select_buffer = true })<CR>", { desc = "Find: file browser" })
map("n", "<leader>fz", "<cmd>lua require('telescope').extensions.zoxide.list()<CR>", { desc = "Find: zoxide dirs" })
map("n", "<leader>ll", "<cmd>lua require('telescope.builtin').resume()<CR>", { desc = "List: resume last picker" })
map("n", "<leader>u", "<cmd>lua require('telescope').extensions.undo.undo()<CR>", { desc = "Undo history" })

-- ── List (l*) ───────────────────────────────────────────────────────
map("n", "<leader>lb", "<cmd>lua require('telescope.builtin').buffers()<CR>", { desc = "List: buffers" })
map("n", "<leader>ld", "<cmd>lua require('telescope.builtin').find_files()<CR>", { desc = "List: files (cwd)" })
map("n", "<leader>lc", "<cmd>lua require('telescope.builtin').find_files({search_file = '*.java', prompt_title = 'Java Classes'})<CR>", { desc = "List: java classes" })
map("n", "<leader>le", "<cmd>lua require('telescope.builtin').diagnostics()<CR>", { desc = "List: diagnostics" })
map("n", "<leader>lf", "<cmd>lua require('utils').project_files()<CR>", { desc = "List: project files" })
map("n", "<leader>lh", "<cmd>lua require('telescope.builtin').help_tags()<CR>", { desc = "List: help tags" })
map("n", "<leader>lk", "<cmd>lua require('telescope.builtin').keymaps()<CR>", { desc = "List: keymaps" })
map("n", "<leader>lm", "<cmd>lua require('telescope.builtin').marks()<CR>", { desc = "List: marks" })
map("n", "<leader>lr", "<cmd>lua require('telescope.builtin').oldfiles()<CR>", { desc = "List: recent files" })
map("n", "<leader>lR", "<cmd>lua require('telescope.builtin').registers()<CR>", { desc = "List: registers" })
map("n", "<leader>lw", "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>", { desc = "List: workspace symbols" })
map("n", "<leader>:", "<cmd>lua require('telescope.builtin').command_history()<CR>", { desc = "List: command history" })

-- <leader>tu/tt/ti removed -> built-in `grr`/`grt`/`gri` (telescope, see LspAttach)

map("n", "<M-1>", "<cmd>lua require('nvim-tree.api').tree.toggle()<CR>", { desc = "Toggle file tree" })

-- signature help removed: use built-in insert-mode `<C-s>` (0.11+)
