require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"bashls",
		"cssmodules_ls",
		"emmet_ls",
		"clangd",
		"lua_ls",
		"bashls",
		"yamlls",
		"html",
		"tsserver",
		"tailwindcss",
		"vimls",
		"rust_analyzer",
		"typst_lsp",
		"taplo",
		"jsonls",
		"csharp_ls",
		"lemminx",
		"cssls"
	},
})


require("mason-nvim-dap").setup({
	automatic_setup = true,
	ensure_installed = { "stylua", "jq", "debugpy", "clangd", "codelldb" },
})


require("mason-null-ls").setup({
	automatic_setup = true,
	automatic_installation = true,
	ensure_installed = { "stylua", "shellharden", "astyle", "black", "beautysh", "cpptools", "yamlfmt", "flake8", "jedi-language-server", "mypy", "ruff" },
})
