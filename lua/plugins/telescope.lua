return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
			{ "<leader>f?", "<cmd>Telescope help_tags<cr>", desc = "Find help tags" },

			{
				"<leader>fa",
				function()
					require("telescope.builtin").find_files({
						cwd = vim.fn.getcwd() .. "/app",
						prompt_title = "Find in App Directory",
					})
				end,
				desc = "Find files in app/",
			},
            {
				"<leader>ft",
				function()
					require("telescope.builtin").find_files({
						cwd = vim.fn.getcwd() .. "/types",
						prompt_title = "Find in Types Directory",
					})
				end,
				desc = "Find files in types/",
			},

			{
				"<leader>fc",
				function()
					require("telescope.builtin").find_files({
						cwd = vim.fn.getcwd() .. "/components",
						prompt_title = "Find Components",
					})
				end,
				desc = "Find files in components/",
			},

			{
				"<leader>fh",
				function()
					require("telescope.builtin").find_files({
						cwd = vim.fn.getcwd() .. "/hooks",
						prompt_title = "Find Hooks",
					})
				end,
				desc = "Find files in hooks/",
			},

			{
				"<leader>fu",
				function()
					require("telescope.builtin").find_files({
						cwd = vim.fn.getcwd() .. "/utils",
						prompt_title = "Find Utils",
					})
				end,
				desc = "Find files in utils/",
			},

			{
				"<leader>fd",
				function()
					local common_dirs =
						{ "app", "context", "controllers", "components", "hooks", "utils", "lib", "pages" }
					local existing_dirs = {}

					for _, dir in ipairs(common_dirs) do
						local path = vim.fn.getcwd() .. "/" .. dir
						if vim.fn.isdirectory(path) == 1 then
							table.insert(existing_dirs, dir)
						end
					end

					vim.ui.select(existing_dirs, {
						prompt = "Select directory to search:",
					}, function(choice)
						if choice then
							require("telescope.builtin").find_files({
								cwd = vim.fn.getcwd() .. "/" .. choice,
								prompt_title = "Find in " .. choice .. "/",
							})
						end
					end)
				end,
				desc = "Find files in project directories",
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
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

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", function()
				builtin.find_files({ cwd = vim.fn.getcwd() })
			end, { desc = "Find files in current directory" })

			vim.keymap.set("n", "<leader>fg", function()
				builtin.live_grep({ cwd = vim.fn.getcwd() })
			end, { desc = "Live grep in current directory" })

			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })
		end,
	},
}
