require("vgit").setup({
	settings = {
		git = {
			cmd = 'git', -- optional setting, not really required
			fallback_cwd = vim.fn.expand(vim.fn.getcwd()),
		},
	}
})
