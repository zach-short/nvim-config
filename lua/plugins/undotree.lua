vim.g.undotree_ShortIndicators = 1
vim.g.undotree_WindowLayout = 2
vim.g.undotree_SetFocusWhenToggle = 1

vim.keymap.set("n", "<leader>ut", function()
	local undotree_buf_name = "undotree"

	local cur_win = vim.api.nvim_get_current_win()

	vim.cmd.UndotreeToggle()

	vim.defer_fn(function()
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			local buf = vim.api.nvim_win_get_buf(win)
			local name = vim.api.nvim_buf_get_name(buf)
			if name:match(undotree_buf_name) then
				vim.api.nvim_set_current_win(win)
				vim.cmd("wincmd H")
				vim.cmd("wincmd L")
				vim.api.nvim_set_current_win(cur_win)
				break
			end
		end
	end, 50)
end)
