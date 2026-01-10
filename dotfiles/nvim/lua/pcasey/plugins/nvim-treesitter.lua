return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup({
                ensure_installed = {
                    "python",
                    "c",
                    "rust",
                    "json",
                    "yaml",
                    "html",
                    "markdown",
                    "bash",
                    "lua",
                    "vim",
                    "dockerfile",
                    "gitignore",
                    "toml",
                    "make",
                    "fish",
                    "css",
                    "asm",
                    "javascript",
                    "typescript",
                },
            })
        end,
    },
}
