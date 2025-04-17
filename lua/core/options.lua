-- Basic options
vim.opt.number = true             -- Show line numbers
vim.opt.relativenumber = true     -- Show relative line numbers
vim.opt.termguicolors = true      -- Enable true color support
vim.opt.mouse = "a"               -- Enable mouse support
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.ignorecase = true         -- Case insensitive search
vim.opt.smartcase = true          -- Unless search contains uppercase
vim.opt.hlsearch = true           -- Highlight search results
vim.opt.tabstop = 2               -- How many columns a tab counts for
vim.opt.shiftwidth = 2            -- How many spaces to use for autoindent
vim.opt.softtabstop = 2           -- How many spaces a <Tab> feels like while editing
vim.opt.expandtab = true          -- Use spaces instead of actual tab characters

vim.g.do_filetype_lua = 1
vim.filetype.add({
	extension = {
		tsx = "typescriptreact",
	},
})
