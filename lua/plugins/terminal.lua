------------------
-- TOGGLETERM   --
-- (Terminal)   --
------------------
local toggleterm = require("toggleterm")

toggleterm.setup({
	size = 100,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "vertical", -- 'horizontal', 'vertical', 'float', 'tab'
	close_on_exit = true,
	shell = vim.o.shell,
	-- Fix: Change from * 10 to * 0.5 for half screen width
	width = function(term)
		if term.direction == "vertical" then
			return vim.o.columns * 0.5 -- Half the screen width
		end
	end,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts) -- <Ctrl-h> to move left from terminal
	vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts) -- <Ctrl-j> to move down from terminal
	vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts) -- <Ctrl-k> to move up from terminal
	vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts) -- <Ctrl-l> to move right from terminal
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

vim.keymap.set("n", "<leader>tt", ":tabnew | term<CR>", { noremap = true, silent = true, desc = "New terminal tab" })

-- Fix: Specify direction and size for t1 and t2
vim.keymap.set("n", "<leader>t1", function()
	require("toggleterm.terminal").Terminal
		:new({
			cmd = "zsh",
			count = 1,
			direction = "vertical",
			size = vim.o.columns * 0.5, -- Explicitly set half screen width
		})
		:toggle()
end, { noremap = true, silent = true, desc = "Toggle Term 1" })

vim.keymap.set("n", "<leader>t2", function()
	require("toggleterm.terminal").Terminal
		:new({
			cmd = "zsh",
			count = 2,
			direction = "vertical",
			size = vim.o.columns * 0.5, -- Explicitly set half screen width
		})
		:toggle()
end, { noremap = true, silent = true, desc = "Toggle Term 2" })

vim.keymap.set(
	"n",
	"<leader>tf",
	":ToggleTerm direction=float<CR>",
	{ noremap = true, silent = true, desc = "Toggle floating terminal" }
)

vim.keymap.set(
	"n",
	"<leader>th",
	":ToggleTerm direction=horizontal<CR>",
	{ noremap = true, silent = true, desc = "Toggle horizontal terminal" }
)

vim.keymap.set(
	"n",
	"<leader>tv",
	":ToggleTerm direction=vertical<CR>",
	{ noremap = true, silent = true, desc = "Toggle vertical terminal" }
)

return toggleterm
