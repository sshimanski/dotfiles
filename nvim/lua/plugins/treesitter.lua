return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    dependencies = {
        -- refactor plugin dropped: incompatible with `main`, abandoned upstream.
        -- smart_rename / usage-navigation now handled by the LSP keymaps below.
        { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
        "David-Kunz/treesitter-unit",
    },
    -- run config on every relevant filetype, plus once at startup
    lazy = false,
    config = function()
        -- ── core (main branch: no more `configs.setup` module system) ──
        local ts = require("nvim-treesitter")
        ts.setup()

        -- main-branch `install()` is NOT idempotent like the old
        -- `ensure_installed='all'`: calling it with every parser re-spawns
        -- ~300 downloads on each startup. Install only the missing ones from
        -- a curated list (parsers we actually use).
        local ensure = {
            "lua", "vim", "vimdoc", "query", "bash", "markdown",
            "markdown_inline", "json", "yaml", "toml",
            "java", "go", "gomod", "python", "rust",
            "javascript", "typescript", "tsx", "html", "css",
            "gitcommit", "gitignore", "diff", "dockerfile", "sql", "xml",
        }
        local installed = ts.get_installed()
        local missing = vim.tbl_filter(function(lang)
            return not vim.tbl_contains(installed, lang)
        end, ensure)
        if #missing > 0 then
            ts.install(missing)
        end

        -- ── textobjects (main branch API) ──
        require("nvim-treesitter-textobjects").setup({
            select = {
                lookahead = true,
            },
            move = {
                set_jumps = true,
            },
        })

        -- ── highlight + indent: enabled per-buffer on FileType ──
        -- auto-installs the parser on demand if missing, then enables it.
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local buf = args.buf
                local ft = vim.bo[buf].filetype
                local lang = vim.treesitter.language.get_lang(ft)
                if not lang then
                    return
                end

                local function enable()
                    if not vim.api.nvim_buf_is_valid(buf) then
                        return
                    end
                    pcall(vim.treesitter.start, buf, lang)
                    vim.bo[buf].indentexpr =
                        "v:lua.require'nvim-treesitter'.indentexpr()"
                end

                if vim.tbl_contains(ts.get_installed(), lang) then
                    enable()
                elseif vim.tbl_contains(ts.get_available(), lang) then
                    -- parser exists upstream but not installed: fetch it,
                    -- then enable once the async install finishes.
                    ts.install(lang):await(function()
                        vim.schedule(enable)
                    end)
                end
            end,
        })

        -- ── keymaps ────────────────────────────────────────────────
        local map = vim.keymap.set
        local select = require("nvim-treesitter-textobjects.select")
        local swap = require("nvim-treesitter-textobjects.swap")
        local move = require("nvim-treesitter-textobjects.move")

        -- select textobjects (visual + operator-pending)
        local sel = {
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["ai"] = "@call.outer", -- i = invocation
            ["ii"] = "@call.inner",
        }
        for lhs, query in pairs(sel) do
            map({ "x", "o" }, lhs, function()
                select.select_textobject(query, "textobjects")
            end)
        end

        -- swap parameters
        map("n", "<C-l>", function()
            swap.swap_next("@parameter.inner")
        end)
        map("n", "<C-h>", function()
            swap.swap_previous("@parameter.inner")
        end)

        -- movement
        local function mv(fn, query)
            return function()
                fn(query, "textobjects")
            end
        end
        map({ "n", "x", "o" }, "]m", mv(move.goto_next_start, "@function.outer"))
        map({ "n", "x", "o" }, "]]", mv(move.goto_next_start, "@class.outer"))
        map({ "n", "x", "o" }, "]M", mv(move.goto_next_end, "@function.outer"))
        map({ "n", "x", "o" }, "][", mv(move.goto_next_end, "@class.outer"))
        map({ "n", "x", "o" }, "[m", mv(move.goto_previous_start, "@function.outer"))
        map({ "n", "x", "o" }, "[[", mv(move.goto_previous_start, "@class.outer"))
        map({ "n", "x", "o" }, "[M", mv(move.goto_previous_end, "@function.outer"))
        map({ "n", "x", "o" }, "[]", mv(move.goto_previous_end, "@class.outer"))

        -- old refactor module (smart_rename / goto_usage) dropped:
        -- use built-in `grn` (rename) and `grr` (references) from nvim 0.11+
    end,
}
