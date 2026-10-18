return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
            "jay-babu/mason-nvim-dap.nvim",
        },
        keys = {
            -- 🕹️ The Essential Debugger Keyboard Controls
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Code Breakpoint" },
            { "<leader>dc", function() require("dap").continue() end,          desc = "Start/Continue Debugging" },
            { "<leader>do", function() require("dap").step_over() end,         desc = "Step Over Line" },
            { "<leader>di", function() require("dap").step_into() end,         desc = "Step Into Function" },
            { "<leader>dt", function() require("dap").terminate() end,         desc = "Terminate Debug Session" },
            { "<leader>du", function() require("dapui").toggle() end,          desc = "Toggle Debug UI Window Layout" },
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            -- Initialize your automated debug package installer layers
            require("mason-nvim-dap").setup({
                -- State exactly what backend debugger packages you want downloaded automatically
                ensure_installed = {
                    "debugpy",  -- Python Debug Engine
                    "codelldb", -- Lightning fast C / C++ Debugger
                },
                automatic_installation = true,
                handlers = {}, -- Automatically assigns basic runtime triggers for you
            })

            -- Initialize your visual grid overlay panel structures
            dapui.setup()

            -- 🤖 INTERACTIVE AUTOMATION HOOKS
            -- These event listeners tell Neovim to open your debugger panels automatically
            -- the exact moment a session initializes, and closes them when you quit.
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
    },
}
