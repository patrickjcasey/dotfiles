return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require('lualine').setup({
            options = {
                theme = "tokyonight-storm",
            },
            --- use relative filename in lualine
            sections = {
                lualine_c = { { 'filename', path = 1 } },
            }
        })
    end,
}
