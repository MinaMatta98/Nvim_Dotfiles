local function servers(global_on_attach)
	local flags = {
		allow_incremental_sync = true,
		debounce_text_changes = 200,
	}

	local list =
	{ "vimls", "yamlls", "bashls", "texlab", "lua_ls",
		"cssmodules_ls", "emmet_ls", "lemminx", -- "tailwindcss",
		"jedi_language_server", "taplo", "jsonls", "cssls" }

	for _, server_name in ipairs(list) do
		require("lspconfig")[server_name].setup({
			flags = flags,
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
			on_attach = global_on_attach,
		})
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.offsetEncoding = { "utf-16" }


	-- require("lspconfig").csharp_ls.setup({
	-- 	flags = flags,
	-- 	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	-- 	on_attach = global_on_attach,
	-- 	handlers = {
	-- 		["textDocument/definition"] = require('csharpls_extended').handler,
	-- 		["textDocument/typeDefinition"] = require('csharpls_extended').handler,
	-- 	},
	-- 	enable_editorconfig_support = true,
	-- })

	require("lspconfig").omnisharp.setup({
		flags = flags,
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
		on_attach = global_on_attach,
		handlers = {
			["textDocument/definition"] = require('omnisharp_extended').definition_handler,
			["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
			["textDocument/references"] = require('omnisharp_extended').references_handler,
			["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
		},
		-- Enables support for reading code style, naming convention and analyzer
		-- settings from .editorconfig.
		enable_editorconfig_support = true,


		roslyn_extensions_options = {
			document_analysis_timeout_ms = 30000,
			enable_decompilation_support = true,
			enable_import_completion = true,
			enable_analyzers_support = true,
			diagnostic_workers_thread_count = 32,
			location_paths = {
				"//path_to/code_actions.dll"
			},
			-- inlay_hints_options = {
			-- 	enable_for_parameters = true,
			-- 	for_literal_parameters = true,
			-- 	for_indexer_parameters = true,
			-- 	for_object_creation_parameters = true,
			-- 	for_other_parameters = true,
			-- 	suppress_for_parameters_that_differ_only_by_suffix = false,
			-- 	suppress_for_parameters_that_match_method_intent = false,
			-- 	suppress_for_parameters_that_match_argument_name = false,
			-- 	enable_for_types = true,
			-- 	for_implicit_variable_types = true,
			-- 	for_lambda_parameter_types = true,
			-- 	for_implicit_object_creation = true
			-- }
		},

		-- If true, MSBuild project system will only load projects for files that
		-- were opened in the editor. This setting is useful for big C# codebases
		-- and allows for faster initialization of code navigation features only
		-- for projects that are relevant to code that is being edited. With this
		-- setting enabled OmniSharp may load fewer projects and may thus display
		-- incomplete reference lists for symbols.
		enable_ms_build_load_projects_on_demand = false,

		-- Enables support for roslyn analyzers, code fixes and rulesets.
		-- enable_roslyn_analyzers = true,

		-- Specifies whether 'using' directives should be grouped and sorted during
		-- document formatting.
		organize_imports_on_format = true,

		-- Enables support for showing unimported types and unimported extension
		-- methods in completion lists. When committed, the appropriate using
		-- directive will be added at the top of the current file. This option can
		-- have a negative impact on initial completion responsiveness,
		-- particularly for the first few completion sessions after opening a
		-- solution.
		enable_import_completion = true,

		-- Specifies whether to include preview versions of the .NET SDK when
		-- determining which version to use for project loading.
		sdk_include_prereleases = true,

		-- Only run analyzers against open files when 'enableRoslynAnalyzers' is
		-- true
		analyze_open_documents_only = false,
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


	require("lsp.ts")(global_on_attach)
	-- require("lspconfig").tsserver.setup({
	-- 	require("cmp_nvim_lsp").default_capabilities(),
	-- 	on_attach = global_on_attach,
	-- 	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	-- })
end

return servers
