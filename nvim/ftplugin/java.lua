local home = os.getenv('HOME')

local jdtls_home = home .. '/.local/share/nvim/mason/packages/jdtls'
local launcher = 'org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar'

local root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' })
local project_name = vim.fn.fnamemodify(root_dir, ':t')

local on_attach = function(_, bufnr)
    local map = require('utils').buf_set_keymap

    require('jdtls').jol_path = home .. '/work/apps/jol/jol-cli/target/jol-cli.jar'

    map(bufnr, 'n', '<leader>ri', "<Cmd>lua require('jdtls').organize_imports()<CR>")

    map(bufnr, 'v', '<leader>ic', "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>")
    map(bufnr, 'n', '<leader>ic', "<Cmd>lua require('jdtls').extract_constant()<CR>")

    map(bufnr, 'v', '<leader>iv', "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>")
    map(bufnr, 'n', '<leader>iv', "<Cmd>lua require('jdtls').extract_variable()<CR>")

    map(bufnr, 'v', '<leader>em', "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>")

    -- TODO: dap
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    -- map(bufnr, 'n', '<leader>dc', "<Cmd>lua require('jdtls').test_class()<CR>")
    -- map(bufnr, 'n', '<leader>dm', "<Cmd>lua require('jdtls').test_nearest_method()<CR>")
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {

    -- The command that starts the language server (bypassing 'jdtls' wrapper in $PATH)
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {
        -- The language server requires a runtime environment of Java 21 (at a minimum) to run.
        home .. '/.sdkman/candidates/java/21.0.2-open/bin/java',
        '-javaagent:' .. jdtls_home .. '/lombok.jar',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1G',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', jdtls_home .. '/plugins/' .. launcher,
        '-configuration', jdtls_home .. '/config_linux',
        '-data', home .. '/.local/share/nvim/WORKSPACES/' .. project_name
    },

    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir,

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options

    settings = {
        java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' },
            completion = {
                favoriteStaticMembers = {
                    'org.hamcrest.MatcherAssert.assertThat',
                    'org.hamcrest.Matchers.*',
                    'org.hamcrest.CoreMatchers.*',
                    'org.junit.jupiter.api.Assertions.*',
                    'java.util.Objects.requireNonNull',
                    'java.util.Objects.requireNonNullElse',
                    'org.mockito.Mockito.*'
                },
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            configuration = {
                runtimes = {
                    {
                        name = 'JavaSE-11',
                        path = home .. '/.sdkman/candidates/java/11.0.12-open',
                        default = true
                    },
                    {
                        name = 'JavaSE-17',
                        path = home .. '/.sdkman/candidates/java/17.0.12-oracle',
                        default = false
                    },
                    {
                        name = 'JavaSE-21',
                        path = home .. '/.sdkman/candidates/java/21.0.2-open',
                        default = false
                    }
                },
            },
        },
    },

    on_attach = on_attach,
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
