return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			cpp = { "clang-format" },
			c = { "clang-format" },
			java = { "google-java-format" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback", -- If no dedicated formatter is on the system, ask the LSP to do it
		},
	},
}
