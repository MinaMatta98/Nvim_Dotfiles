local global_on_attach = function(client, bufnr)
	-- vim.lsp.set_log_level("debug")
	vim.opt.pumblend = 0
	require('git-conflict').setup()

	require("nvim-autopairs").setup({})

	require("lsp.lsp-config")(client, bufnr)
end

require("lsp.lsp-config.servers")(global_on_attach)

return global_on_attach
