local function signature(client, bufnr)
	require("lsp_signature").on_attach({
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		handler_opts = {
			border = "rounded",
		},
	}, bufnr)

	local signs = {
		Error = " ",
		Warn = " ",
		Hint = " ",
		Info = " ",
	}

	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers["signature_help"], {
		border = "rounded",
		close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
	})

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		update_in_insert = true,
		border = "rounded",
	})

	vim.diagnostic.config({
		virtual_text = {
			-- source = "always",  -- Or "if_many"
			prefix = "▎", -- Could be '■', '▎', 'x'
		},
		severity_sort = true,
		float = {
			source = "always", -- Or "if_many"
			border = "rounded",
		},
	})

	if client.server_capabilities.documentSymbolProvider then
		require("utilities.navic").attach(client, bufnr)
		-- vim.opt_local.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
	end
end

return signature
