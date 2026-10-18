return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "mfussenegger/nvim-jdtls",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "pyright", -- Python Analyzer
                    "clangd",  -- C & C++ Compiler Server
                    "lua_ls",  -- Lua Language Server
                    "jdtls",   -- Java Language Server Language Pack
                },
            })

            -- Tell the servers that nvim-cmp supports expanded auto-completion windows
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- 1. Initialize Python (Pyright)
            vim.lsp.config("pyright", { capabilities = capabilities })
            vim.lsp.enable("pyright")

            -- 2. Initialize C & C++ (Clangd)
            vim.lsp.config("clangd", { capabilities = capabilities })
            vim.lsp.enable("clangd")

            -- 3. Initialize Lua with custom options
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }, -- Stops the annoying "Undefined global 'vim'" warning
                        },
                    },
                },
            })
            vim.lsp.enable("lua_ls")

            -- 4. Disable auto-start for jdtls so our dedicated java wrapper handles it later
            vim.lsp.config("jdtls", {
                capabilities = capabilities,
                autostart = false,
            })

            -- Create automated shortcuts every time an LSP attaches to a code file
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local opts = { buffer = bufnr }

                    vim.keymap.set("n", "K", function() -- Show documentation
                        vim.lsp.buf.hover({ border = "rounded" })
                    end, { buffer = bufnr, desc = "LSP Hover Documentation" })

                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)     -- Go to source code definition
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)    -- Go to source declaration
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)     -- Find references
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- Smart rename
                end
            })

            -- Automatically attach Java-specific handlers when opening a .java file
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "java",
                callback = function()
                    local config = {
                        cmd = { vim.fn.exepath("jdtls") },
                        root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', 'mvnw', '.git' }, { upward = true })),
                        capabilities = capabilities,
                    }
                    require('jdtls').start_or_attach(config)
                end,
            })
        end,
    },
}
