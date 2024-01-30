local treeconfig = {
	sort_by = "case_sensitive",
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = false,
	},
	git = {
		enable = true,
		timeout = 50,
	},
	actions = {
		open_file = {
			quit_on_open = false,
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
}

require("nvim-tree").setup(treeconfig)
require("nvim-tree.lib")
require("nvim-tree.view")

vim.api.nvim_set_keymap("n", "<C-f>", ":NvimTreeToggle<cr>", { silent = true, noremap = true })
