
-- Core editor shortcuts
vim.g.mapleader = " "
-- Clear search highlights with Escape key
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>ev', ':e ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true, desc = 'Edit init.lua' }) -- <Space>ev to quickly edit config
vim.keymap.set('n', '<leader>sv', function()
    -- Save the current file if it's init.lua
    if vim.fn.expand('%:p') == vim.fn.stdpath('config')..'/init.lua' then
        vim.cmd('write')
    end
    -- Source init.lua
    vim.cmd('source ~/.config/nvim/init.lua')
    print('Neovim configuration reloaded!')
end, { noremap = true, silent = true, desc = 'Source init.lua' }) -- <Space>sv to reload configuration

-- Directory navigation
vim.keymap.set('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>', { noremap = true, silent = false, desc = 'Change working directory to current file' }) -- <Space>cd changes working directory to current file's location
