return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "ts_ls", "clangd" },
            })

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    border = "rounded",
                },
            })

            local on_attach = function(client, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }

                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
                vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)
            end

            local lspconfig = require("lspconfig")

            lspconfig.lua_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })

            lspconfig.ts_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            lspconfig.clangd.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end,
    },

    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        build = ":MasonUpdate",
        opts = {
            ensure_installed = {
                -- Language servers
                "lua-language-server",
                "typescript-language-server",
                "clangd",
                
                -- Formatters
                "prettier",
                "black",
                "goimports",
                "stylua",
                "clang-format",
                "shfmt",
                
                -- Linters
                "eslint_d",
                "flake8",
                "golangci-lint",
                "luacheck",
                "markdownlint",
                "yamllint",
                "jsonlint",
                "shellcheck",
            },
        },
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = "mason.nvim",
        opts = {
            ensure_installed = { "lua_ls", "ts_ls", "clangd" },
        },
    },
}
