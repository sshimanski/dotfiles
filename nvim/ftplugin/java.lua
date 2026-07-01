local home = os.getenv('HOME')
local java_root = home .. '/.sdkman/candidates/java/21.0.11-tem'
local jdtls_home = home .. '/.local/share/nvim/mason/packages/jdtls'

-- resolve launcher by glob: its version changes on every mason jdtls update
local launcher = vim.fn.glob(jdtls_home .. '/plugins/org.eclipse.equinox.launcher_*.jar')

-- guard against nil root: a missing root produced project_name "v:null",
-- a bogus -data dir and malformed file URIs -> jdtls StackOverflowError.
local root_dir = require('jdtls.setup').find_root({
    '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle', 'settings.gradle',
})
if not root_dir or root_dir == '' then
    root_dir = vim.fn.getcwd()
end
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
        java_root .. '/bin/java',
        '-javaagent:' .. jdtls_home .. '/lombok.jar',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1G',
        -- bigger thread stack: lombok's EclipseWorkspaceBasedFileResolver
        -- recursion overflows the default ~512K stack (StackOverflowError on
        -- textDocument/definition). 16m gives it room.
        '-Xss16m',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', launcher,
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
            -- CodeLens shown above declarations; run with `grx`
            referencesCodeLens = { enabled = true },
            implementationsCodeLens = { enabled = true },
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
                        path = java_root,
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
