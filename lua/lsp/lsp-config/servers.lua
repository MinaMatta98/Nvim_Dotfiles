local function servers(global_on_attach)
	local flags = {
		allow_incremental_sync = true,
		debounce_text_changes = 200,
	}

	local list =
	{ "vimls", "yamlls", "bashls", "texlab", "lua_ls", "cssmodules_ls", "emmet_ls", "lemminx",
		-- "tailwindcss",

		"jedi_language_server", "taplo", "jsonls" }

	for _, server_name in ipairs(list) do
		require("lspconfig")[server_name].setup({
			flags = flags,
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
			on_attach = global_on_attach,
		})
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.offsetEncoding = { "utf-16" }


	require("lspconfig").csharp_ls.setup({
		flags = flags,
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
		on_attach = global_on_attach,
		handlers = {
			["textDocument/definition"] = require('csharpls_extended').handler,
			["textDocument/typeDefinition"] = require('csharpls_extended').handler,
		},
		enable_editorconfig_support = true,
	})

	require("lspconfig").clangd.setup({
		require("cmp_nvim_lsp").default_capabilities(),
		on_attach = global_on_attach,
		capabilities = capabilities,

	})

	require 'lspconfig'.typst_lsp.setup {
		settings = {
			exportPdf = "onSave", -- Choose onType, onSave or never.
			-- serverPath = "" -- Normally, there is no need to uncomment it.
			filetypes = "typst, typ"
		}
	}

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	require("lspconfig").html.setup({
		require("cmp_nvim_lsp").default_capabilities(),
		on_attach = global_on_attach,
		capabilities = capabilities,
	})

	require("lspconfig").tsserver.setup({
		require("cmp_nvim_lsp").default_capabilities(),
		on_attach = global_on_attach,
		filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	})
end

return servers
