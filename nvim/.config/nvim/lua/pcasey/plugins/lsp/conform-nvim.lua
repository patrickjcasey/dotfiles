return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
        formatters_by_ft = {
            python = { "black" },
            rust = { "rustfmt" },
            c = { "clang-format" },
        },
        format_on_save = { timeout_ms = 500, lsp_fallback = true },
    }
}
