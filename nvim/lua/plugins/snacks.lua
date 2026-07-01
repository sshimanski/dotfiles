return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },      -- disable heavy features on huge files
        quickfile = { enabled = true },    -- render file before plugins load (fast open)
        indent = { enabled = true },       -- indent guides + scope
        scope = { enabled = true },        -- scope detection / textobjects
        notifier = { enabled = true },     -- pretty vim.notify replacement
        statuscolumn = { enabled = true }, -- numbers + signs + folds column
        words = { enabled = true },        -- highlight references of word under cursor
        dashboard = { enabled = true },    -- start screen (replaces alpha-nvim)
        input = { enabled = true },        -- nicer vim.ui.input
    },
    keys = {
        { "<leader>lg", function() Snacks.lazygit() end,                desc = "LazyGit" },
        { "<leader>k", function()
            -- fixed windows (gitsigns blame, nvim-tree...) set winfixbuf:
            -- bufdelete can't switch buffer there -> just close the window.
            if vim.wo.winfixbuf then
                pcall(vim.cmd.close)
                return
            end
            Snacks.bufdelete()
        end, desc = "Close buffer / fixed window" },
        { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification history" },
        { "<leader>un", function() Snacks.notifier.hide() end,         desc = "Dismiss notifications" },
    },
}
