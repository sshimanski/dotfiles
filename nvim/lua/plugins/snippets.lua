
return {
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",

        dependencies = { "rafamadriz/friendly-snippets" },

        config = function()
            local ls = require("luasnip")
            -- load friendly-snippets (vscode-style) into luasnip
            require("luasnip.loaders.from_vscode").lazy_load()
            ls.filetype_extend("javascript", { "jsdoc" })

            -- Snippet expand & jump are handled by blink.cmp (Tab / S-Tab).
            -- The old <C-s>e/;/, maps are removed: they shadowed the native
            -- <C-s> signature-help (made it a laggy prefix). Keep only
            -- choice-node cycling, on <C-l> (avoids blink's <C-e> = hide).
            vim.keymap.set({ "i", "s" }, "<C-l>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, { silent = true, desc = "LuaSnip: next choice" })
        end,
    }
}

