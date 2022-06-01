require("luasnip.loaders.from_vscode").load {}

local cmp = require("cmp")
local luasnip = require("luasnip")
local fn = vim.fn
local api = vim.api


cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    window = {
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = function(fallback)
            if fn.pumvisible() == 1 then
                fn.feedkeys(api.nvim_replace_termcodes("<C-n>", true, true, true), "n")
            elseif luasnip.expand_or_jumpable() then
                fn.feedkeys(api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if fn.pumvisible() == 1 then
                fn.feedkeys(api.nvim_replace_termcodes("<C-p>", true, true, true), "n")
            elseif luasnip.jumpable(-1) then
                fn.feedkeys(api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            else
                fallback()
            end
        end,
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    })
})
