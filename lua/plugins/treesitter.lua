return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function(_, opts)
        -- In the new version of treesitter, we initialize the main module directly
        require("nvim-treesitter").setup(opts)
    end,
    opts = {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
            "lua",
            "c",
            "cpp",
            "python",
            "java",
            "vim",
            "vimdoc",
            "markdown",
            "markdown_inline",
            "query"
        },
        auto_install = true,
    },
}
