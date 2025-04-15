-- Basic options
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = true  -- Show relative line numbers
vim.opt.termguicolors = true   -- Enable true color support
vim.opt.mouse = 'a'            -- Enable mouse support
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard
vim.opt.ignorecase = true      -- Case insensitive search
vim.opt.smartcase = true       -- Unless search contains uppercase
vim.opt.hlsearch = true        -- Highlight search results

vim.g.do_filetype_lua = 1
vim.filetype.add({
  extension = {
    tsx = "typescriptreact",
  },
})
