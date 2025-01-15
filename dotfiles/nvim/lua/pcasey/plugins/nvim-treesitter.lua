return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        build = ":TSUpdate",
        config = function()
            -- import nvim-treesitter plugin
            local treesitter = require("nvim-treesitter.configs")

            -- configure treesitter
            treesitter.setup({ -- enable syntax highlighting
                highlight = {
                    enable = true,
                },
                -- enable indentation
                indent = { enable = true },
                -- enable autotagging (w/ nvim-ts-autotag plugin)
                autotag = { enable = true },
                -- ensure these language parsers are installed
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
                    "make",
                    "css",
                    "asm",
                    "javascript",
                    "typescript",
                },
                -- auto install above language parsers
                auto_install = true,
            })
        end,
    },
}
