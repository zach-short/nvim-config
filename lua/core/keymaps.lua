vim.g.mapleader = " "

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { noremap = true, silent = true, desc = "clear search highlights" })
vim.keymap.set("n", "<leader><leader>", ":w<CR>", { noremap = true, silent = true, desc = "quick save" })

vim.cmd([[
  cnoreabbrev <expr> % (getcmdtype() == ':' && getcmdline() == '%') ? 'w' : '%'
]])

vim.cmd([[
  cnoreabbrev <expr> # (getcmdtype() == ':' && getcmdline() == '#') ? 'q' : '#'
]])

vim.api.nvim_create_user_command("TabNewHere", function()
    local cwd = vim.fn.expand("%:p") ~= "" and vim.fn.expand("%:p:h") or vim.fn.getcwd()
    vim.cmd("tabnew")
    vim.cmd("tcd " .. cwd)
end, {})

vim.keymap.set("n", "<leader>pdf", function()
    local file = vim.fn.expand("%:p")
    vim.fn.jobstart({ "open", file }, { detach = true })
end, { desc = "Open current file in Preview" })

vim.keymap.set(
    "n",
    "<leader>nt",
    "<cmd>TabNewHere<CR>",
    { noremap = true, silent = true, desc = "open new tab instance" }
)

vim.keymap.set(
    "n",
    "<leader>init",
    ":e ~/.config/nvim/init.lua<CR>",
    { noremap = true, silent = true, desc = "edit init.lua" }
)

vim.keymap.set("n", "<leader>cd", function()
    local root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")
    if vim.v.shell_error ~= 0 or root == "" then
        root = vim.fn.expand("%:p:h")
    end
    vim.cmd("cd " .. root)
    vim.cmd("pwd")
end, { noremap = true, silent = false, desc = "Smart project root cd" })

vim.keymap.set("n", "<leader>cj", function()
    local current_file_dir = vim.fn.expand("%:p:h")
    vim.cmd("cd " .. current_file_dir)
    vim.cmd("pwd")
end, { noremap = true, silent = false, desc = "Change to current file's directory" })

vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, silent = true, desc = "save file" })

vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true, silent = true, desc = "close buffer" })

vim.keymap.set("n", "<leader>d", vim.cmd.Ex, { desc = "Open built-in file explorer" })

vim.keymap.set(
    "n",
    "<leader>ts",
    ":split | terminal<CR>",
    { noremap = true, silent = true, desc = "open terminal in split" }
)

-- toggleterm keymaps
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle floating terminal" })
vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Toggle horizontal terminal" })
vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Toggle vertical terminal" })

-- ============================
-- Window Navigation & Management
-- ============================

-- Move between splits
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, desc = "Move to left split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, desc = "Move to right split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, desc = "Move to bottom split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, desc = "Move to top split" })

vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { noremap = true, silent = true, desc = "vertical split" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { noremap = true, silent = true, desc = "horizontal split" })

vim.keymap.set("n", "j", "jzz", { noremap = true })
vim.keymap.set("n", "k", "kzz", { noremap = true })
vim.keymap.set("n", "n", "nzz", { noremap = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true })
vim.keymap.set("n", "*", "*zz", { noremap = true })
vim.keymap.set("n", "#", "#zz", { noremap = true })
vim.keymap.set("n", "g*", "g*zz", { noremap = true })
vim.keymap.set("n", "g#", "g#zz", { noremap = true })
vim.keymap.set("n", "{", "{zz", { noremap = true })
vim.keymap.set("n", "}", "}zz", { noremap = true })
vim.keymap.set("n", "[[", "[[zz", { noremap = true })
vim.keymap.set("n", "]]", "]]zz", { noremap = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set("n", "gg", "ggzz", { noremap = true })
vim.keymap.set("n", "G", "Gzz", { noremap = true })

vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, desc = "show documentation" })

vim.keymap.set("n", "<leader>jb", "<C-o>zz", { noremap = true, silent = true, desc = "jump back in jumplist" })
vim.keymap.set("n", "<leader>jf", function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })

    if #clients > 0 then
        print("LSP active, jumping to definition...")
        vim.lsp.buf.definition()
    else
        print("No LSP active. Filetype:", vim.bo.filetype)
        print("File:", vim.fn.expand("%:t"))

        local ok = pcall(vim.cmd, "normal! gd")
        if ok then
            vim.cmd("normal! zz")
        else
            print("No definition found")
        end
    end
end, { noremap = true, silent = false, desc = "jump to definition" })

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>l", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

vim.keymap.set(
    "n",
    "<leader>ur",
    "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { desc = "Redraw / clear hlsearch / diff update" }
)

vim.keymap.set("x", "*", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]])

vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "Delete Other Buffers" })

vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
