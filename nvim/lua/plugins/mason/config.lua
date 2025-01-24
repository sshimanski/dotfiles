require("mason").setup({
     ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).

-- lsp_installer.on_server_ready(function(server)
--     if server.name ~= 'jdtls' and server.name ~= 'rust_analyzer' then -- jdtls/rust-tools do initialization by itself
--         server:setup({})
--     end
-- end)
