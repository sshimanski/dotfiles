-- make friends: nvim-lsp-installer and rust-tools

-- local available, server = require('nvim-lsp-installer.servers').get_server("rust_analyzer")

-- if available then
--     local map = require('utils').buf_set_keymap

--     local on_attach = function(client, bufnr)
--         map(bufnr, 'n', '\\r', '<Cmd>RustRunnables<CR>')
--         map(bufnr, 'n', '\\d', '<Cmd>RustDebuggables<CR>')
--         map(bufnr, 'n', '\\e', '<Cmd>RustExpandMacro<CR>')
--         map(bufnr, 'n', '<leader>pm', '<Cmd>RustParentModule<CR>')
--         -- tc = To Cargo
--         map(bufnr, 'n', '<leader>tc', '<Cmd>RustOpenCargo<CR>')
--     end

--     require('rust-tools').setup({
--         server = {
--             cmd = {server.root_dir .. '/rust-analyzer'},
--             on_attach = on_attach
--         },
--     })
-- end
