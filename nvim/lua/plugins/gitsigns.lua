return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require('gitsigns').setup({
            preview_config = {
                border = 'rounded',
                -- show on next row
                row = 1
            },
            on_attach = function(bufnr)
                local gitsigns = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        gitsigns.nav_hunk('next', { preview = true })
                    end
                end, { desc = 'Git: next change' })

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        gitsigns.nav_hunk('prev', { preview = true })
                    end
                end, { desc = 'Git: prev change' })

                -- Actions
                map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Git: hunk - stage' })
                map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Git: hunk - reset' })

                map('v', '<leader>hs', function()
                    gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)

                map('v', '<leader>hr', function()
                    gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)

                map('n', '<leader>hS', gitsigns.stage_buffer)
                map('n', '<leader>hR', gitsigns.reset_buffer)
                map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Git: hunk - preview' })
                map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'Git: hunk - preview inline' })

                -- Blame
                map('n', '<leader>hb', function()
                    gitsigns.blame_line({ full = true })
                end, { desc = 'Git: hunk - blame (line)' })
                map('n', '<leader>hB', gitsigns.blame, { desc = 'Git: hunk blame (ALL)' })

                -- Diff
                map('n', '<leader>hd', gitsigns.diffthis)
                map('n', '<leader>hD', function()
                    gitsigns.diffthis('~')
                end)

                map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
                map('n', '<leader>hq', gitsigns.setqflist)

                -- Toggles
                map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
                map('n', '<leader>tw', gitsigns.toggle_word_diff)

                -- Text object
                map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
            end
        })
    end,
}
