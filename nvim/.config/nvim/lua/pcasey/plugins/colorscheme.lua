return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        config = function()
            vim.cmd([[colorscheme catppuccin-macchiato]])
        end,
    }
}
