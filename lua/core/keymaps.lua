-- ============================
-- Core Editor Shortcuts
-- ============================

vim.g.mapleader = " "

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { noremap = true, silent = true, desc = "clear search highlights" })

-- quickly edit the init.lua configuration with <leader>ev
vim.keymap.set(
  "n",
  "<leader>ev",
  ":e ~/.config/nvim/init.lua<CR>",
  { noremap = true, silent = true, desc = "edit init.lua" }
)

-- reload nvim config with <leader>save
vim.keymap.set("n", "<leader>save", function()
  if vim.fn.expand("%:p") == vim.fn.stdpath("config") .. "/init.lua" then
    vim.cmd("write")
  end
  vim.cmd("source ~/.config/nvim/init.lua")
  print("neovim configuration reloaded!")
end, { noremap = true, silent = true, desc = "source init.lua" })

-- ============================
-- Directory Navigation
-- ============================

-- change the working directory to the current file's directory with <leader>cd
vim.keymap.set("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>", {
  noremap = true,
  silent = false,
  desc = "change working directory to current file",
})

-- ============================
-- Terminal Keymaps
-- ============================

-- open terminal in split
vim.keymap.set(
  "n",
  "<leader>t",
  ":split | terminal<CR>",
  { noremap = true, silent = true, desc = "open terminal in split" }
)

-- ============================
-- Miscellaneous Keymaps
-- ============================

-- save the current file
vim.keymap.set("n", "<leader>s", ":w<CR>", { noremap = true, silent = true, desc = "save file" })

-- close the current buffer
vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true, silent = true, desc = "close buffer" })

-- toggle nerdtree file explorer
vim.keymap.set("n", "<leader>n", ":NERDTreeToggle<CR>", { noremap = true, silent = true, desc = "toggle nerdtree" })

vim.keymap.set("n", "<leader>d", vim.cmd.Ex)

-- ============================
-- Centered Cursor Movement Keymaps
-- ============================

-- keep cursor centered when moving up/down
vim.keymap.set("n", "j", "jzz", { noremap = true })
vim.keymap.set("n", "k", "kzz", { noremap = true })

-- center screen when searching
vim.keymap.set("n", "n", "nzz", { noremap = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true })
vim.keymap.set("n", "*", "*zz", { noremap = true })
vim.keymap.set("n", "#", "#zz", { noremap = true })
vim.keymap.set("n", "g*", "g*zz", { noremap = true })
vim.keymap.set("n", "g#", "g#zz", { noremap = true })

-- center screen when jumping paragraphs
vim.keymap.set("n", "{", "{zz", { noremap = true })
vim.keymap.set("n", "}", "}zz", { noremap = true })

-- center when jumping to next/previous code block
vim.keymap.set("n", "[[", "[[zz", { noremap = true })
vim.keymap.set("n", "]]", "]]zz", { noremap = true })

-- center when jumping to marks
vim.keymap.set("n", "'", "'zz", { noremap = true })
vim.keymap.set("n", "`", "`zz", { noremap = true })

-- center when jumping half-page up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })

-- center when jumping to beginning/end of file
vim.keymap.set("n", "gg", "ggzz", { noremap = true })
vim.keymap.set("n", "G", "Gzz", { noremap = true })

-- hover (show documentation)
vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, desc = "show documentation" })

-- show signature help (function signatures)
vim.keymap.set(
  "n",
  "<C-k>",
  vim.lsp.buf.signature_help,
  { noremap = true, silent = true, desc = "show signature help" }
)

-- add a workspace folder
vim.keymap.set(
  "n",
  "<leader>wa",
  vim.lsp.buf.add_workspace_folder,
  { noremap = true, silent = true, desc = "add workspace folder" }
)

-- remove a workspace folder
vim.keymap.set(
  "n",
  "<leader>wr",
  vim.lsp.buf.remove_workspace_folder,
  { noremap = true, silent = true, desc = "remove workspace folder" }
)

-- list workspace folders
vim.keymap.set("n", "<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { noremap = true, silent = true, desc = "list workspace folders" })

-- go to type definition
vim.keymap.set(
  "n",
  "<leader>D",
  vim.lsp.buf.type_definition,
  { noremap = true, silent = true, desc = "go to type definition" }
)

-- rename symbol
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "rename symbol" })

-- code action (quick fixes)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "code action" })

-- go to references
vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true, desc = "go to references" })

-- format code (lsp)
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end, { noremap = true, silent = true, desc = "format code" })

-- ============================
-- Jumping Keymaps
-- ============================

-- jump back in jumplist
vim.keymap.set("n", "<leader>jb", "<C-o>zz", { noremap = true, silent = true, desc = "jump back in jumplist" })

-- jump forward in jumplist
vim.keymap.set("n", "<leader>jn", "<C-i>zz", { noremap = true, silent = true, desc = "jump forward in jumplist" })

vim.keymap.set("n", "<leader>h", "<C-w>h", { noremap = true, desc = "Move to left split" })
vim.keymap.set("n", "<leader>l", "<C-w>l", { noremap = true, desc = "Move to right split" })

-- open terminal
vim.keymap.set("n", "<leader>sv", ":vsplit", { noremap = true, silent = true, desc = "edit init.lua" })
