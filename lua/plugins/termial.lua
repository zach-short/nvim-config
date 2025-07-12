return {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
        size = function(term)
            if term.direction == "horizontal" then
                return 15
            elseif term.direction == "vertical" then
                return vim.o.columns * 0.5
            end
        end,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = "vertical",
        close_on_exit = true,
        shell = vim.o.shell,
        auto_scroll = true,
        float_opts = {
            border = "curved",
            winblend = 0,
            highlights = {
                border = "Normal",
                background = "Normal",
            },
            width = math.floor(vim.o.columns * 0.8),
            height = math.floor(vim.o.lines * 0.8),
        },
        winbar = {
            enabled = false,
            name_formatter = function(term)
                return term.name
            end,
        },
    },

    config = function(_, opts)
        require("toggleterm").setup(opts)

        -- Set up terminal keymaps function
        local function set_terminal_keymaps()
            local keymap_opts = { noremap = true, silent = true, buffer = 0 }

            -- Exit terminal mode
            vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], keymap_opts)
            vim.keymap.set("t", "jk", [[<C-\><C-n>]], keymap_opts)

            -- Window navigation from terminal
            vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-W>h]], keymap_opts)
            vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-W>j]], keymap_opts)
            vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-W>k]], keymap_opts)
            vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-W>l]], keymap_opts)

            -- Resize terminal windows
            vim.keymap.set("t", "<C-Up>", [[<C-\><C-n>:resize +2<CR>]], keymap_opts)
            vim.keymap.set("t", "<C-Down>", [[<C-\><C-n>:resize -2<CR>]], keymap_opts)
            vim.keymap.set("t", "<C-Left>", [[<C-\><C-n>:vertical resize -2<CR>]], keymap_opts)
            vim.keymap.set("t", "<C-Right>", [[<C-\><C-n>:vertical resize +2<CR>]], keymap_opts)
        end

        -- Set up autocmd for terminal keymaps
        vim.api.nvim_create_autocmd("TermOpen", {
            pattern = "term://*",
            callback = set_terminal_keymaps,
            desc = "Set terminal keymaps",
        })

        -- Custom terminal functions
        local Terminal = require("toggleterm.terminal").Terminal

        -- Lazygit terminal
        local lazygit = Terminal:new({
            cmd = "lazygit",
            dir = "git_dir",
            direction = "float",
            float_opts = {
                border = "double",
            },
            on_open = function(term)
                vim.cmd("startinsert!")
                vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
            end,
            on_close = function(term)
                vim.cmd("startinsert!")
            end,
        })

        -- Node REPL terminal
        local node = Terminal:new({
            cmd = "node",
            direction = "float",
            float_opts = {
                border = "double",
            },
        })

        -- Python REPL terminal
        local python = Terminal:new({
            cmd = "python3",
            direction = "float",
            float_opts = {
                border = "double",
            },
        })

        -- Htop terminal
        local htop = Terminal:new({
            cmd = "htop",
            direction = "float",
            float_opts = {
                border = "double",
            },
        })

        -- Make custom terminals available globally
        _G.lazygit_toggle = function()
            lazygit:toggle()
        end

        _G.node_toggle = function()
            node:toggle()
        end

        _G.python_toggle = function()
            python:toggle()
        end

        _G.htop_toggle = function()
            htop:toggle()
        end
    end,

    keys = {
        -- Basic toggleterm mappings
        {
            "<C-\\>",
            "<cmd>ToggleTerm<cr>",
            desc = "Toggle terminal",
        },

        -- New terminal tab
        {
            "<leader>tt",
            "<cmd>tabnew | term<cr>",
            desc = "New terminal tab",
        },

        -- Toggle Term 1 (vertical, half screen)
        {
            "<leader>t1",
            function()
                require("toggleterm.terminal").Terminal
                    :new({
                        cmd = "zsh",
                        count = 1,
                        direction = "vertical",
                        size = vim.o.columns * 0.5,
                    })
                    :toggle()
            end,
            desc = "Toggle Term 1",
        },

        -- Toggle Term 2 (vertical, half screen)
        {
            "<leader>t2",
            function()
                require("toggleterm.terminal").Terminal
                    :new({
                        cmd = "zsh",
                        count = 2,
                        direction = "vertical",
                        size = vim.o.columns * 0.5,
                    })
                    :toggle()
            end,
            desc = "Toggle Term 2",
        },

        -- Direction-specific terminals
        {
            "<leader>tf",
            "<cmd>ToggleTerm direction=float<cr>",
            desc = "Toggle floating terminal",
        },
        {
            "<leader>th",
            "<cmd>ToggleTerm direction=horizontal<cr>",
            desc = "Toggle horizontal terminal",
        },
        {
            "<leader>tv",
            "<cmd>ToggleTerm direction=vertical<cr>",
            desc = "Toggle vertical terminal",
        },

        -- Custom application terminals
        {
            "<leader>gg",
            "<cmd>lua lazygit_toggle()<cr>",
            desc = "Toggle Lazygit",
        },
        {
            "<leader>tn",
            "<cmd>lua node_toggle()<cr>",
            desc = "Toggle Node REPL",
        },
        {
            "<leader>tp",
            "<cmd>lua python_toggle()<cr>",
            desc = "Toggle Python REPL",
        },
        {
            "<leader>tm",
            "<cmd>lua htop_toggle()<cr>",
            desc = "Toggle Htop",
        },

        -- Send line/selection to terminal
        {
            "<leader>ts",
            function()
                require("toggleterm").send_lines_to_terminal("single_line", true, { args = vim.v.count })
            end,
            desc = "Send line to terminal",
        },
        {
            "<leader>ts",
            function()
                require("toggleterm").send_lines_to_terminal("visual_lines", true, { args = vim.v.count })
            end,
            mode = "v",
            desc = "Send selection to terminal",
        },
    },
}
