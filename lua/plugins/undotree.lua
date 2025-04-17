vim.g.undotree_ShortIndicators = 1    -- shortens "n" and "p" to just "N" and "P"
vim.g.undotree_WindowLayout = 2       -- makes the undo diff window appear below the undotree
vim.g.undotree_SetFocusWhenToggle = 1 -- automatically focus the undotree when opening it
vim.g.undotree_SplitWidth = 10

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
        vim.cmd("wincmd H") -- move window to the far left
        vim.cmd("wincmd L") -- then move it to the far right
        vim.api.nvim_set_current_win(cur_win)
        break
      end
    end
  end, 50)
end)
