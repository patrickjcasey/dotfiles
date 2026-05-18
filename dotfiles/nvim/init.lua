--------------------------------------------------------------------------------
-- options
--------------------------------------------------------------------------------
local opt = vim.opt

opt.relativenumber = true
opt.number = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

opt.swapfile = false

--------------------------------------------------------------------------------
-- keymaps
--------------------------------------------------------------------------------
vim.g.mapleader = " "

local keymap = vim.keymap

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })

-- better ctrl u/d
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center cursor after moving up half a page" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center cursor after moving down half a page" })

--------------------------------------------------------------------------------
-- packages (vim.pack)
--------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("PackChanged", {
    group = vim.api.nvim_create_augroup("pcasey-pack-build", { clear = true }),
    callback = function(args)
        local data = args.data
        if data.kind ~= "install" and data.kind ~= "update" then
            return
        end
        local name = data.spec.name
        if name == "telescope-fzf-native.nvim" then
            vim.notify("Building telescope-fzf-native...", vim.log.levels.INFO)
            vim.system({ "make" }, { cwd = data.path }):wait()
        elseif name == "nvim-treesitter" then
            vim.notify("Updating treesitter parsers...", vim.log.levels.INFO)
            pcall(vim.cmd, "TSUpdate")
        end
    end,
})

vim.pack.add({
    -- colorscheme
    { src = "https://github.com/folke/tokyonight.nvim" },

    -- shared deps
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/echasnovski/mini.icons" },

    -- telescope
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },

    -- treesitter (track main branch — has the new async/setup API)
    { src = "https://github.com/nvim-treesitter/nvim-treesitter",         version = "main" },

    -- LSP
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
    { src = "https://github.com/antosha417/nvim-lsp-file-operations" },

    -- completion / snippets
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-buffer" },
    { src = "https://github.com/hrsh7th/cmp-path" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/onsails/lspkind.nvim" },

    -- formatting
    { src = "https://github.com/stevearc/conform.nvim" },

    -- file tree
    { src = "https://github.com/nvim-tree/nvim-tree.lua" },

    -- ui
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/folke/trouble.nvim" },
    { src = "https://github.com/folke/todo-comments.nvim" },
    { src = "https://github.com/j-hui/fidget.nvim" },

})

--------------------------------------------------------------------------------
-- colorscheme
--------------------------------------------------------------------------------
vim.cmd.colorscheme("tokyonight-storm")

--------------------------------------------------------------------------------
-- mini.icons
--------------------------------------------------------------------------------
require("mini.icons").setup()

--------------------------------------------------------------------------------
-- mason
--------------------------------------------------------------------------------
require("mason").setup({
    PATH = "append",
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})

require("mason-lspconfig").setup({
    ensure_installed = {
        "html",
        "lua_ls",
        "pyright",
        "yamlls",
        "jsonls",
        "bashls",
        "marksman",
        "taplo",
        "ts_ls",
        "tailwindcss",
        "eslint",
        "clangd",
        -- handled by rustup w/ `rustup component add rust-analyzer`
        -- "rust_analyzer",
    },
    automatic_installation = true,
})

--------------------------------------------------------------------------------
-- lsp
--------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(ev)
        local opts = { buffer = ev.buf, noremap = true, silent = true }

        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

        if vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { 0 })
        end
    end,
})

require("lsp-file-operations").setup()

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = "󰠠 ",
            [vim.diagnostic.severity.INFO] = " ",
        },
    },
})

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.enable("html")
vim.lsp.enable("bashls")
vim.lsp.enable("jsonls")

vim.lsp.config("clangd", {
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
})
vim.lsp.enable("clangd")

vim.lsp.config("rust_analyzer", {
    settings = {
        ["rust-analyzer"] = {
            check = { command = "clippy" },
        },
    },
})
vim.lsp.enable("rust_analyzer")

vim.lsp.enable("eslint")
vim.lsp.enable("ts_ls")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("pyright")
vim.lsp.enable("yamlls")
vim.lsp.enable("marksman")
vim.lsp.enable("taplo")

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
            },
        },
    },
})
vim.lsp.enable("lua_ls")

--------------------------------------------------------------------------------
-- conform (formatting)
--------------------------------------------------------------------------------
require("conform").setup({
    formatters_by_ft = {
        python = { "black" },
        rust = { "rustfmt" },
        c = { "clang-format" },
        html = { "prettierd" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        markdown = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
    },
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
})

--------------------------------------------------------------------------------
-- nvim-cmp
--------------------------------------------------------------------------------
local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    completion = {
        completeopt = "menu,menuone,preview,noselect",
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }),
    formatting = {
        format = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
        }),
    },
})

--------------------------------------------------------------------------------
-- telescope
--------------------------------------------------------------------------------
local telescope = require("telescope")
local telescope_actions = require("telescope.actions")

telescope.setup({
    defaults = {
        path_display = { "truncate " },
        mappings = {
            i = {
                ["<C-k>"] = telescope_actions.move_selection_previous,
                ["<C-j>"] = telescope_actions.move_selection_next,
                ["<C-q>"] = telescope_actions.send_selected_to_qflist + telescope_actions.open_qflist,
            },
        },
    },
})

telescope.load_extension("fzf")

local builtin = require("telescope.builtin")
keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Search [G]it [F]iles" })
keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })

--------------------------------------------------------------------------------
-- nvim-tree
--------------------------------------------------------------------------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

require("nvim-tree").setup({
    view = {
        width = 35,
        relativenumber = true,
    },
    renderer = {
        indent_markers = { enable = true },
        icons = {
            glyphs = {
                folder = {
                    arrow_closed = "",
                    arrow_open = "",
                },
            },
        },
    },
    actions = {
        open_file = {
            window_picker = { enable = false },
        },
    },
    filters = {
        custom = { ".DS_Store" },
    },
    git = { ignore = false },
})

keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })

--------------------------------------------------------------------------------
-- treesitter
--------------------------------------------------------------------------------
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

--------------------------------------------------------------------------------
-- lualine
--------------------------------------------------------------------------------
require("lualine").setup({
    options = {
        theme = "tokyonight-storm",
    },
    sections = {
        lualine_c = { { "filename", path = 1 } },
    },
})

--------------------------------------------------------------------------------
-- trouble
--------------------------------------------------------------------------------
require("trouble").setup()

--------------------------------------------------------------------------------
-- todo-comments
--------------------------------------------------------------------------------
require("todo-comments").setup()

--------------------------------------------------------------------------------
-- fidget
--------------------------------------------------------------------------------
require("fidget").setup()

--------------------------------------------------------------------------------
-- which-key
--------------------------------------------------------------------------------
require("which-key").setup()
