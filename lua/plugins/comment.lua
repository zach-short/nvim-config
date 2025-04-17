return require("Comment").setup({
	padding = true,
	sticky = true,
	toggler = {
		line = "gcc", -- Toggle comment for current line
		block = "gbc", -- Toggle block comment
	},
	opleader = {
		line = "gc", -- Operator for line comments
		block = "gb", -- Operator for block comments
	},
	mappings = {
		basic = true,
		extra = true,
	},
})
