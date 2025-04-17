vim.keymap.set("n", "<leader>d", vim.cmd.Ex)

-- === Centered Cursor Movement Keymaps ===

-- Keep cursor centered when moving up/down
vim.keymap.set("n", "j", "jzz", { noremap = true })
vim.keymap.set("n", "k", "kzz", { noremap = true })

-- Center screen when searching
vim.keymap.set("n", "n", "nzz", { noremap = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true })
vim.keymap.set("n", "*", "*zz", { noremap = true })
vim.keymap.set("n", "#", "#zz", { noremap = true })
vim.keymap.set("n", "g*", "g*zz", { noremap = true })
vim.keymap.set("n", "g#", "g#zz", { noremap = true })

-- Center screen when jumping paragraphs
vim.keymap.set("n", "{", "{zz", { noremap = true })
vim.keymap.set("n", "}", "}zz", { noremap = true })

-- Center when jumping to next/previous code block
vim.keymap.set("n", "[[", "[[zz", { noremap = true })
vim.keymap.set("n", "]]", "]]zz", { noremap = true })

-- Center when jumping to marks
vim.keymap.set("n", "'", "'zz", { noremap = true })
vim.keymap.set("n", "`", "`zz", { noremap = true })

-- Center when jumping half-page up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })

-- Center when jumping to beginning/end of file
vim.keymap.set("n", "gg", "ggzz", { noremap = true })
vim.keymap.set("n", "G", "Gzz", { noremap = true })
