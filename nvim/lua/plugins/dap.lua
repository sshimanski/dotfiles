return {
    "mfussenegger/nvim-dap",

    dependencies = {
        "mfussenegger/nvim-dap-python",
        "nvim-neotest/nvim-nio",
        -- overrides 'dap' internal ui
        "nvim-telescope/telescope-dap.nvim",
        "rcarriga/nvim-dap-ui",
    },

    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()

        -- Setup Python adapter
        require("dap-python").setup()

        -- Setup Telescope integration
        require("telescope").load_extension("dap")

        -- Event listeners for DAP UI
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end
    end,
}
