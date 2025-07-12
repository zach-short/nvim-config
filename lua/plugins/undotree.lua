return {
    "mbbill/undotree",
    config = function()
        -- Undotree configuration
        vim.g.undotree_ShortIndicators = 1
        vim.g.undotree_WindowLayout = 2
        vim.g.undotree_SetFocusWhenToggle = 1
        vim.g.undotree_SplitWidth = 30
        vim.g.undotree_DiffpanelHeight = 10
        vim.g.undotree_DiffAutoOpen = 1
        vim.g.undotree_TreeNodeShape = "*"
        vim.g.undotree_TreeVertShape = "|"
        vim.g.undotree_TreeSplitShape = "/"
        vim.g.undotree_TreeReturnShape = "\\"
        vim.g.undotree_DiffCommand = "diff"
        vim.g.undotree_RelativeTimestamp = 1
        vim.g.undotree_HighlightChangedText = 1
        vim.g.undotree_HighlightSyntaxAdd = "DiffAdd"
        vim.g.undotree_HighlightSyntaxChange = "DiffChange"
        vim.g.undotree_HighlightSyntaxDel = "DiffDelete"

        local function find_undotree_window()
            for _, win in ipairs(vim.api.nvim_list_wins()) do
                local buf = vim.api.nvim_win_get_buf(win)
                local name = vim.api.nvim_buf_get_name(buf)
                if name:match("undotree") then
                    return win
                end
            end
            return nil
        end

        -- Helper function to position undotree window
        local function position_undotree_window(side)
            side = side or "left"
            local undotree_win = find_undotree_window()
            if undotree_win then
                vim.api.nvim_set_current_win(undotree_win)
                if side == "left" then
                    vim.cmd("wincmd H")
                elseif side == "right" then
                    vim.cmd("wincmd L")
                end
            end
        end

        -- Autocmd to auto-position undotree when it opens
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "undotree",
            callback = function()
                vim.opt_local.number = false
                vim.opt_local.relativenumber = false
                vim.opt_local.signcolumn = "no"
                vim.opt_local.foldcolumn = "0"
                vim.opt_local.wrap = false

                -- Auto-position to left side after a short delay
                vim.defer_fn(function()
                    position_undotree_window("left")
                end, 100)
            end,
            desc = "Configure undotree buffer",
        })
    end,

    keys = {
        -- Main undotree toggle
        {
            "<leader>ut",
            function()
                local cur_win = vim.api.nvim_get_current_win()
                vim.cmd.UndotreeToggle()

                -- Return focus to original window after opening
                vim.defer_fn(function()
                    if vim.api.nvim_win_is_valid(cur_win) then
                        vim.api.nvim_set_current_win(cur_win)
                    end
                end, 150)
            end,
            desc = "Toggle Undotree",
        },

        -- Focus undotree window
        {
            "<leader>uf",
            function()
                local undotree_win = nil
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    local buf = vim.api.nvim_win_get_buf(win)
                    local name = vim.api.nvim_buf_get_name(buf)
                    if name:match("undotree") then
                        undotree_win = win
                        break
                    end
                end

                if undotree_win then
                    vim.api.nvim_set_current_win(undotree_win)
                else
                    vim.notify("Undotree is not open", vim.log.levels.WARN)
                end
            end,
            desc = "Focus Undotree window",
        },

        -- Show undotree (without toggle)
        {
            "<leader>us",
            "<cmd>UndotreeShow<cr>",
            desc = "Show Undotree",
        },

        -- Hide undotree
        {
            "<leader>uh",
            "<cmd>UndotreeHide<cr>",
            desc = "Hide Undotree",
        },

        -- Undotree navigation (only works when in undotree window)
        {
            "J",
            function()
                local buf_name = vim.api.nvim_buf_get_name(0)
                if buf_name:match("undotree") then
                    vim.cmd("normal! j")
                else
                    vim.cmd("normal! J")
                end
            end,
            desc = "Next undo state (in undotree) / Join lines (elsewhere)",
        },

        {
            "K",
            function()
                local buf_name = vim.api.nvim_buf_get_name(0)
                if buf_name:match("undotree") then
                    vim.cmd("normal! k")
                else
                    vim.cmd("normal! K")
                end
            end,
            desc = "Previous undo state (in undotree) / Show hover (elsewhere)",
        },
    },

    -- Optional: Add which-key group descriptions
    init = function()
        local wk_ok, wk = pcall(require, "which-key")
        if wk_ok then
            wk.register({
                ["<leader>u"] = { name = "Undo Tree" },
            })
        end
    end,
}
