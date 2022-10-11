local dap = require("dap")

dap.adapters.python = {
    type = "executable",
    command = "python",
    args = { "-m", "debugpy.adapter" },
}

-- In addition to launching (possibly) and connecting to a debug adapter, Neovim
-- needs to instruct the debug adapter itself how to launch and connect to the
-- debugee. The debugee is the application you want to debug.

dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
            return "python"
        end,
    },
}
