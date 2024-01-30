require("telescope").setup({
	defaults = {
		theme = "dropdown",
	},
	pickers = {
		find_files = {
			theme = "dropdown",
		},
	},
	extensions = {
		-- ...
	},
})

require("telescope").load_extension("notify")
