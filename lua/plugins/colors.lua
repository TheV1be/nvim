return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,                      -- Forces the theme to load first before other plugin components draw
        config = function()
            vim.cmd.colorscheme("catppuccin-mocha") -- Options: latte, frappe, macchiato, mocha
        end
    }
}
