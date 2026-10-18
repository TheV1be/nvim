return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter", -- Speeds up startup by only loading when you start typing
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- Tells cmp how to fetch options from your LSPs (pyright, clangd, etc)
            "hrsh7th/cmp-buffer", -- Suggests words already typed elsewhere in the active file
            "hrsh7th/cmp-path", -- Suggests directory path routes while typing file paths
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                window = {
                    -- Gives your autocomplete window clean, high-contrast bordered cards
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item(), -- Move UP your completion list with Ctrl+p
                    ["<C-n>"] = cmp.mapping.select_next_item(), -- Move DOWN your completion list with Ctrl+n
                    ["<C-Space>"] = cmp.mapping.complete(),  -- Force trigger the popup window manually
                    ["<C-e>"] = cmp.mapping.abort(),         -- Completely close the suggestion window
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Hit ENTER to confirm and inject the choice
                }),
                -- Prioritize where your autocompletions come from
                sources = cmp.config.sources({
                    { name = "nvim_lsp" }, -- 1st Priority: Smart language engine choices (variables, methods)
                    { name = "buffer" }, -- 2nd Priority: Flat words found in text data
                    { name = "path" }, -- 3rd Priority: Local file directory paths
                }),
            })
        end,
    },
}
