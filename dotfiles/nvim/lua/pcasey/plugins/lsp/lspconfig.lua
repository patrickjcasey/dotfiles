 return {
     "neovim/nvim-lspconfig",
     event = { "BufReadPre", "BufNewFile" },
     dependencies = {
         "hrsh7th/cmp-nvim-lsp",
         { "antosha417/nvim-lsp-file-operations", config = true },
     },
     config = function()
         -- import cmp-nvim-lsp plugin
         local cmp_nvim_lsp = require("cmp_nvim_lsp")

         local keymap = vim.keymap -- for conciseness

         local opts = { noremap = true, silent = true }
         local on_attach = function(client, bufnr)
             opts.buffer = bufnr

             -- set keybinds
             opts.desc = "Show LSP references"
             keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

             opts.desc = "Go to declaration"
             keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

             opts.desc = "Show LSP definitions"
             keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

             opts.desc = "Show LSP implementations"
             keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

             opts.desc = "Show LSP type definitions"
             keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

             opts.desc = "See available code actions"
             keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

             opts.desc = "Smart rename"
             keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

             opts.desc = "Show buffer diagnostics"
             keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

             opts.desc = "Show line diagnostics"
             keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

             opts.desc = "Show documentation for what is under cursor"
             keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

             opts.desc = "Restart LSP"
             keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

             -- enable inlay hints
             if vim.lsp.inlay_hint then
                 vim.lsp.inlay_hint.enable(true, { 0 })
             end
         end

         -- used to enable autocompletion (assign to every lsp server config)
         local capabilities = cmp_nvim_lsp.default_capabilities()

          -- Change the Diagnostic symbols in the sign column (gutter)
          -- (not in youtube nvim video)
          vim.diagnostic.config({
              signs = {
                  text = {
                      [vim.diagnostic.severity.ERROR] = " ",
                      [vim.diagnostic.severity.WARN] = " ",
                      [vim.diagnostic.severity.HINT] = "󰠠 ",
                      [vim.diagnostic.severity.INFO] = " ",
                  },
              },
          })

         -- Set global defaults for all LSP servers
         vim.lsp.config('*', {
             on_attach = on_attach,
             capabilities = capabilities,
         })

         -- configure html server
         vim.lsp.enable('html')

         -- configure bash server
         vim.lsp.enable('bashls')

         -- configure json server
         vim.lsp.enable('jsonls')

         -- configure clangd
         vim.lsp.config('clangd', {
             filetypes = {
                 "c", "cpp", "objc", "objcpp", "cuda"
             }
         })
         vim.lsp.enable('clangd')

          -- configure rust analyzer
          vim.lsp.config('rust_analyzer', {
              settings = {
                  ["rust-analyzer"] = {
                      check = {
                          command = "clippy"
                      }
                  }
              }
          })
         vim.lsp.enable('rust_analyzer')

         -- configure eslint LSP
         vim.lsp.enable('eslint')

         -- configure typescript LSP
         vim.lsp.enable('ts_ls')

         vim.lsp.enable('tailwindcss')

          -- configure python server
          vim.lsp.enable('pyright')

          -- configure yaml server
          vim.lsp.enable('yamlls')

          -- configure markdown server
          vim.lsp.enable('marksman')

          -- configure toml server
          vim.lsp.enable('taplo')

          -- configure nix server
          vim.lsp.enable('nil_ls')

          -- configure lua server (with special settings)
         vim.lsp.config('lua_ls', {
             settings = { -- custom settings for lua
                 Lua = {
                     -- make the language server recognize "vim" global
                     diagnostics = {
                         globals = { "vim" },
                     },
                     workspace = {
                         -- make language server aware of runtime files
                         library = {
                             [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                             [vim.fn.stdpath("config") .. "/lua"] = true,
                         },
                     },
                 },
             },
         })
         vim.lsp.enable('lua_ls')
     end,
 }
