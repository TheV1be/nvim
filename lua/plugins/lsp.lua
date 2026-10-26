return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"mfussenegger/nvim-jdtls",
		},
		config = function()
			-- 1. Initialize Mason package manager
			require("mason").setup()

			-- 2. Pull down default autocomplete completion capabilities
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- 3. Centralized Diagnostics Config (Handles error display rules)
			vim.diagnostic.config({
				virtual_text = {
					spacing = 4,
					prefix = "●", -- Elegant dot indicator for error lines
				},
				underline = true, -- Squiggly underlines under broken code
				signs = true, -- Shows symbols in the left gutter column
				update_in_insert = false, -- Don't yell at you while you are actively typing
				severity_sort = true, -- Prioritize showing errors over minor warnings
			})

			-- 4. Setup Mason-LSPConfig with modern automatic enablement
			require("mason-lspconfig").setup({
				ensure_installed = {
					"pyright",
					"clangd",
					"lua_ls",
					"jdtls",
					"ts_ls",
				},
				-- Automatically activates vim.lsp.enable() for installed servers
				-- but skips jdtls so nvim-jdtls can handle it via FileType instead.
				automatic_enable = {
					exclude = { "jdtls" },
				},
			})

			-- 5. Native Declarative Configuration Overrides (Neovim 0.11+)

			-- Base defaults applied globally to all servers
			vim.lsp.config("*", { capabilities = capabilities })

			-- Custom tweaks specifically for Lua (Fixes the "Undefined global 'vim'" warning)
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT", -- Matches Neovim execution context
						},
						diagnostics = {
							globals = { "vim" }, -- Injects 'vim' as a recognized global constant
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
					},
				},
			})

			-- 6. Create automated shortcuts every time an LSP attaches to a code file
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local opts = { buffer = bufnr }

					-- Navigation & Documentation mappings
					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover({ border = "rounded" })
					end, { buffer = bufnr, desc = "LSP Hover Documentation" })

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

					-- Diagnostic Explanation mappings (Opens the error trace window)
					vim.keymap.set("n", "gl", function()
						vim.diagnostic.open_float({ border = "rounded", scope = "line" })
					end, { buffer = bufnr, desc = "Show Line Error Explanation" })
				end,
			})

			-- 7. Automatically attach Java-specific handlers when opening a .java file
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "java",
				callback = function()
					local config = {
						cmd = { vim.fn.exepath("jdtls") },
						root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", "mvnw", ".git" }, { upward = true })[1]),
						capabilities = capabilities,
					}
					require("jdtls").start_or_attach(config)
				end,
			})
		end,
	},
}
