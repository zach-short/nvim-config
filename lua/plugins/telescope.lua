--------------------
-- TELESCOPE      --
-- (Fuzzy Finder) --
--------------------

local telescope = require("telescope")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = "move_selection_next",
				["<C-k>"] = "move_selection_previous",
			},
		},
		path_display = { "truncate" },
	},
	pickers = {
		find_files = {
			follow = true,
		},
	},
})

local telescope_loaded, builtin = pcall(require, "telescope.builtin")
if telescope_loaded then
	vim.keymap.set("n", "<leader>ff", function()
		builtin.find_files({ cwd = vim.fn.getcwd() })
	end, { desc = "Find files in current directory" })

	vim.keymap.set("n", "<leader>fg", function()
		builtin.live_grep({ cwd = vim.fn.getcwd() })
	end, { desc = "Live grep in current directory" })

	vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
	vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })

	vim.keymap.set("n", "<leader>fd", function()
		local current_file_dir = vim.fn.expand("%:p:h")
		builtin.find_files({ cwd = current_file_dir })
	end, { desc = "Find files in current file directory" })

	vim.keymap.set("n", "<leader>fp", function()
		local git_dir = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")
		local cwd = vim.fn.getcwd()

		if vim.v.shell_error == 0 and git_dir ~= "" then
			builtin.find_files({ cwd = git_dir })
		else
			builtin.find_files({ cwd = cwd })
		end
	end, { desc = "Find files in project directory" })

	vim.keymap.set("n", "<leader>fr", function()
		local initial_cwd = vim.fn.getcwd(1)
		builtin.find_files({ cwd = initial_cwd })
	end, { desc = "Find files from project root" })

	vim.keymap.set("n", "<leader>fs", function()
		local initial_cwd = vim.fn.getcwd(1)
		builtin.find_files({ cwd = initial_cwd .. "/src" })
	end, { desc = "Find files in src directory" })

	vim.keymap.set("n", "<leader>fa", function()
		local initial_cwd = vim.fn.getcwd(1)
		builtin.find_files({ cwd = initial_cwd .. "/app" })
	end, { desc = "Find files in app directory" })
end

return telescope
