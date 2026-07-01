return {
    "mfussenegger/nvim-dap",

    dependencies = {
        "mfussenegger/nvim-dap-python",
        "nvim-neotest/nvim-nio",
        -- overrides 'dap' internal ui
        "nvim-telescope/telescope-dap.nvim",
        "rcarriga/nvim-dap-ui",
        -- inline variable values while debugging
        "theHamsta/nvim-dap-virtual-text",
    },

    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()
        require("nvim-dap-virtual-text").setup()

        -- Setup Python adapter (python3 on PATH; needs debugpy installed)
        require("dap-python").setup("python3")

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
