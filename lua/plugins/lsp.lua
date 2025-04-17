-------------------------
-- LSP CONFIGURATION   --
-- (Language Servers)  --
-------------------------

local M = {}

M.setup = function()
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
		ensure_installed = { "lua_ls" }, -- We'll handle TS server separately
	})
	vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
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

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})

	local on_attach = function(bufnr)
		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, desc = "show documentation" })

		vim.keymap.set(
			"n",
			"<C-k>",
			vim.lsp.buf.signature_help,
			{ noremap = true, silent = true, desc = "show signature help" }
		)

		vim.keymap.set(
			"n",
			"<leader>wa",
			vim.lsp.buf.add_workspace_folder,
			{ noremap = true, silent = true, desc = "add workspace folder" }
		)

		vim.keymap.set(
			"n",
			"<leader>wr",
			vim.lsp.buf.remove_workspace_folder,
			{ noremap = true, silent = true, desc = "remove workspace folder" }
		)

		vim.keymap.set("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, { noremap = true, silent = true, desc = "list workspace folders" })

		vim.keymap.set(
			"n",
			"<leader>D",
			vim.lsp.buf.type_definition,
			{ noremap = true, silent = true, desc = "go to type definition" }
		)

		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "rename symbol" })

		vim.keymap.set(
			"n",
			"<leader>ca",
			vim.lsp.buf.code_action,
			{ noremap = true, silent = true, desc = "code action" }
		)

		vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true, desc = "go to references" })

		vim.keymap.set(
			"n",
			"<leader>jg",
			vim.lsp.buf.declaration,
			{ desc = "Jump to global declaration", buffer = bufnr }
		)
		vim.keymap.set("n", "<leader>jf", vim.lsp.buf.definition, { desc = "Jump to local definition", buffer = bufnr })
		vim.keymap.set(
			"n",
			"<leader>jp",
			"<cmd>Lspsaga peek_definition<CR>",
			{ desc = "Peek definition", buffer = bufnr }
		)
		vim.keymap.set("n", "<leader>jb", "<C-o>", { desc = "Jump back in jumplist", buffer = bufnr })
		vim.keymap.set("n", "<leader>jn", "<C-i>", { desc = "Jump forward in jumplist", buffer = bufnr })

		vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
		vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
		vim.keymap.set("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, bufopts)
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, bufopts)

		vim.keymap.set("n", "<Esc>", function()
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				local config = vim.api.nvim_win_get_config(win)
				if config.relative ~= "" then
					vim.api.nvim_win_close(win, false)
					return
				end
			end
			vim.cmd("nohlsearch")
		end, bufopts)
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

	local ts_ok = pcall(function()
		lspconfig.ts_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end)

	if not ts_ok then
		pcall(function()
			lspconfig.tsserver.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end)
	end

	pcall(function()
		lspconfig.tailwindcss.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end)
end

return M
