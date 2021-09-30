local li = require("lspinstall")
local lc = require("lspconfig")

-- setup
li.setup({})

-- start servers
local servers = li.installed_servers()
for _, server in pairs(servers) do
    -- The server name must match those found in the table of contents in lspconfig/CONFIG.md

    if server ~= 'java' then -- jdtls does initialization
        if server == 'rust' then
            local conf = require('lspconfig/configs')
            -- 'rust' doesn't match, but 'rust_analyzer' does
            rawset(conf, 'rust_analyzer', conf['rust'])
            lc['rust_analyzer'].setup{}
        else
            lc[server].setup{}
        end
    end
end
