local function config(client, bufnr)
	require("lsp.lsp-config.dap")
	require("lsp.lsp-config.telescope")
	require("lsp.lsp-config.neogen")
	require("lsp.lsp-config.symbols")(client, bufnr)
	require("lsp.lsp-config.keymaps")(bufnr)
	require("lsp.lsp-config.clients")(client, bufnr)
end

return config
