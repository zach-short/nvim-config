-------------------------
-- TREE-SITTER        --
-- (Syntax Highlight) --
-------------------------

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"vim",
		"vimdoc",
		"query",
		"javascript",
		"typescript",
		"tsx",
		"python",
		"rust",
		"c",
		"cpp",
		"markdown",
		"markdown_inline",
		"bash",
		"fish",
		"json",
		"yaml",
		"toml",
		"html",
		"css",
	},

	sync_install = false,

	auto_install = true,

	ignore_install = {},

	highlight = {
		enable = true,

		disable = {},

		additional_vim_regex_highlighting = false,
	},

	indent = {
		enable = true,
	},

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<leader>ss", -- <Space>ss to start selection
			node_incremental = "<leader>si", -- <Space>si to expand selection
			scope_incremental = "<leader>sc", -- <Space>sc to expand to scope
			node_decremental = "<leader>sd", -- <Space>sd to shrink selection
		},
	},

	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				["ai"] = "@conditional.outer",
				["ii"] = "@conditional.inner",
				["a/"] = "@comment.outer",
				["i/"] = "@comment.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]f"] = "@function.outer",
				["]c"] = "@class.outer",
				["]p"] = "@parameter.outer",
				["]b"] = "@block.outer",
				["]l"] = "@loop.outer",
				["]i"] = "@conditional.outer",
			},
			goto_next_end = {
				["]F"] = "@function.outer",
				["]C"] = "@class.outer",
				["]P"] = "@parameter.outer",
				["]B"] = "@block.outer",
				["]L"] = "@loop.outer",
				["]I"] = "@conditional.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[c"] = "@class.outer",
				["[p"] = "@parameter.outer",
				["[b"] = "@block.outer",
				["[l"] = "@loop.outer",
				["[i"] = "@conditional.outer",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
				["[C"] = "@class.outer",
				["[P"] = "@parameter.outer",
				["[B"] = "@block.outer",
				["[L"] = "@loop.outer",
				["[I"] = "@conditional.outer",
			},
		},
	},
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim-treesitter#foldexpr()"
vim.opt.foldenable = false
