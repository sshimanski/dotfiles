-- make friends: nvim-lsp-installer and rust-tools
local available, server = require('nvim-lsp-installer.servers').get_server("rust_analyzer")
if available then
    require('rust-tools').setup({
        server = {cmd = server._default_options.cmd}
    })
end
