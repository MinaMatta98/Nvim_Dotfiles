local global_on_attach = function(client, bufnr)
	-- vim.lsp.set_log_level("debug")


	require('git-conflict').setup()
	vim.opt.pumblend = 0

	if client.name == "rust_analyzer" then
		vim.keymap.set("n", "<leader>O", "<cmd>lua require'rust-tools'.open_cargo_toml.open_cargo_toml()<CR>",
			{ buffer = bufnr })
		vim.keymap.set("n", "<leader>R", "<cmd>RustRun<CR>", { buffer = bufnr })
		vim.keymap.set("n", "<leader>A", "<cmd>RustCodeAction<CR>", { buffer = bufnr })
	end

	if client.name == "texlab" then
		require("luasnip-latex-snippets").setup({})
	end

	-- Not equal?
	if client.name ~= "rust_analyzer" then
		vim.keymap.set({ "v", "n" }, "<leader>A", require("actions-preview").code_actions)
	end

	require("nvim-autopairs").setup({})
	require("nvim-dap-virtual-text").setup({
		enabled = true,                  -- enable this plugin (the default)
		enabled_commands = true,         -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
		highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
		highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
		show_stop_reason = true,         -- show stop reason when stopped for exceptions
		commented = false,               -- prefix virtual text with comment string
		only_first_definition = true,    -- only show virtual text at first definition (if there are multiple)
		all_references = false,          -- show virtual text on all all references of the variable (not only definitions)
		filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
		-- experimental features:
		virt_text_pos = "eol",           -- position of virtual text, see `:h nvim_buf_set_extmark()`
		all_frames = false,              -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
		virt_lines = false,              -- show virtual lines instead of virtual text (will flicker!)
		virt_text_win_col = nil,         -- position the virtual text at a fixed window column (starting from the first text column) ,
		-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
	})


	local dap = require("dap")
	local dapui = require("dapui")
	dapui.setup({
		icons = { expanded = "", collapsed = "", current_frame = "" },
		mappings = {
			-- Use a table to apply multiple mappings
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			edit = "e",
			repl = "r",
			toggle = "t",
		},
		-- Use this to override mappings for specific elements
		element_mappings = {
			-- Example:
			-- stacks = {
			--   open = "<CR>",
			--   expand = "o",
			-- }
		},
		-- Expand lines larger than the window
		-- Requires >= 0.7
		expand_lines = vim.fn.has("nvim-0.7") == 1,
		-- Layouts define sections of the screen to place windows.
		-- The position can be "left", "right", "top" or "bottom".
		-- The size specifies the height/width depending on position. It can be an Int
		-- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
		-- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
		-- Elements are the elements shown in the layout (in order).
		-- Layouts are opened in order so that earlier layouts take priority in window sizing.
		layouts = {
			{
				elements = {
					-- Elements can be strings or table with id and size keys.
					{ id = "scopes", size = 0.3 },
					"breakpoints",
					"stacks",
					"watches",
				},
				size = 40, -- 40 columns
				position = "right",
			},
			{
				elements = {
					"repl",
					"console",
				},
				size = 0.25, -- 25% of total lines
				position = "bottom",
			},
		},
		controls = {
			-- Requires Neovim nightly (or 0.8 when released)
			enabled = true,
			-- Display controls in this elementinit
			element = "repl",
			icons = {
				pause = "",
				play = "",
				step_into = "",
				step_over = "",
				step_out = "",
				step_back = "",
				run_last = "",
				terminate = "",
			},
		},
		floating = {
			max_height = nil, -- These can be integers or a float between 0 and 1.
			max_width = nil, -- Floats will be treated as percentage of your screen.
			border = "rounded", -- Border style. Can be "single", "double" or "rounded"
			mappings = {
				close = { "q", "<Esc>" },
			},
		},
		-- windows = { indent = 1 },
		render = {
			max_type_length = nil, -- Can be integer or nil.
			max_value_lines = nil, -- Can be integer or nil.
		},
	})



	dap.listeners.after.event_initialized["dapui_config"] = function()
		-- require('dap').defaults.fallback.exception_breakpoints = {'raised'}
		require('dap').set_exception_breakpoints({ 'all' })
		dapui.open({ reset = true })
	end


	dap.adapters.coreclr = {
		type = 'executable',
		command = '/home/mina/nvim/mason/bin/netcoredbg',
		args = { '--interpreter=vscode' }
	}

	dap.configurations.cs = require("lsp.dotnet")

	require("neogen").setup({
		snippet_engine = "luasnip",
		enabled = true,       --if you want to disable Neogen
		input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
		-- jump_map = "<C-e>"       -- (DROPPED SUPPORT, see [here](#cycle-between-annotations) !) The keymap in order to jump in the annotation fields (in insert mode)
		languages = {
			lua = {
				template = {
					annotation_convention = "ldoc", -- for a full list of annotation_conventions, see supported-languages below,
				},
			},
			cs = {
				template = {
					annotation_convention = "xmldoc", -- for a full list of annotation_conventions, see supported-languages below,
				},
			},
		},
	})

	if client.server_capabilities.documentSymbolProvider then
		require("utilities.navic").attach(client, bufnr)
		-- vim.opt_local.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
	end

	require("lsp_signature").on_attach({
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		handler_opts = {
			border = "rounded",
		},
	}, bufnr)
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }


	local openUrl = function()
		local url = string.match(vim.fn.getline("."), "[a-z]*://[^ >,;():]*")
		if url ~= "" then
			vim.cmd('exec "!firefox \'' .. url .. '\'"')
		else
			vim.cmd('echo "No URI found in line."')
		end
	end

	vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", bufopts)
	vim.keymap.set("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", bufopts)
	vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", bufopts)
	vim.keymap.set("i", "<c-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)
	vim.keymap.set("n", "<c-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)
	vim.keymap.set("n", "gD", "<cmd>lua require('telescope.builtin').diagnostics()<CR>", bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", bufopts)
	vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", bufopts)
	vim.keymap.set("n", "<F2>", "<cmd>lua require'dap'.step_over()<CR>", bufopts)
	vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", bufopts)
	vim.keymap.set("n", "<F1>", "<cmd>lua require'dap'.step_into()<CR>", bufopts)
	vim.keymap.set("n", "<F3>", "<cmd>lua require'dap'.step_out()<CR>", bufopts)
	vim.keymap.set("n", "<leader>de", "<cmd>lua require('dapui').eval()<CR>", bufopts)
	vim.keymap.set("n", "<space>dl", "<cmd>lua require'dapui'.open()<CR>", bufopts)
	vim.keymap.set("n", "<leader>C", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", bufopts)
	vim.keymap.set("n", "<leader>tws", "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>", bufopts)
	vim.keymap.set("n", "<leader>ts", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", bufopts)
	vim.keymap.set("n", "<leader>tr", "<cmd>lua require('neotest').run.run()<CR>", bufopts)
	vim.keymap.set("n", "<leader>tt", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", bufopts)
	vim.keymap.set("n", "<leader>to", "<cmd>lua require('neotest').output.open()<CR>", bufopts)
	vim.keymap.set("n", "<leader>tS", "<cmd>lua require('neotest').summary.toggle()<CR>", bufopts)
	vim.keymap.set("n", "<leader>tn", "<cmd>lua require('neotest').jump.next({status = 'failed'})<CR>", bufopts)
	vim.keymap.set("n", "<leader>tN", "<cmd>lua require('neotest').jump.prev({status = 'failed'})<CR>", bufopts)
	vim.keymap.set("n", "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", bufopts)
	vim.keymap.set("n", "gx", openUrl, { desc = "OpenUrl Undercurword" })
	vim.keymap.set("n", "<leader>B", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint Condition: '))<CR>",
		bufopts)
	vim.keymap.set("x", "<leader>ja", "<cmd>MoltenEvaluateVisual<CR>", bufopts)
	vim.keymap.set("n", "<leader>ji", "<cmd>MoltenInit<CR>", bufopts)
	vim.keymap.set("n", "<leader>jj", "<cmd>MoltenEvaluateLine<CR>", bufopts)
	vim.keymap.set("n", "<leader>jr", "<cmd>MoltenReevaluateCell<CR>", bufopts)
	vim.keymap.set("n", "<leader>js", "<cmd>MoltenShowOutput<CR>", bufopts)
	vim.keymap.set("n", "<leader>jd", "<cmd>MoltenDelete<CR>", bufopts)
	vim.keymap.set("v", "<leader>ds", "<ESC>:lua require('dap-python').debug_selection()<CR>", bufopts)

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

	local builtin = require("telescope.builtin")
	vim.lsp.handlers["textDocument/definition"] = builtin.lsp_definitions
	vim.lsp.handlers["textDocument/declaration"] = builtin.lsp_declarations
	vim.lsp.handlers["textDocument/typeDefinition"] = builtin.lsp_type_definitions
	vim.lsp.handlers["textDocument/references"] = builtin.lsp_references
	vim.lsp.handlers["textDocument/documentSymbol"] = builtin.lsp_document_symbols
	vim.lsp.handlers["workspace/symbol"] = builtin.lsp_workspace_symbols
	vim.lsp.handlers["callHierarchy/incomingCalls"] = builtin.lsp_incoming_calls
	vim.lsp.handlers["callHierarchy/outgoingCalls"] = builtin.lsp_outgoing_calls
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

	local set_namespace = vim.api.nvim__set_hl_ns or vim.api.nvim_set_hl_ns
	local namespace = vim.api.nvim_create_namespace("dap-hlng")
	vim.api.nvim_set_hl(0, "blue", { fg = "#3d59a1" })
	vim.api.nvim_set_hl(0, "green", { fg = "#9ece6a" })
	vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" })
	vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" })

	vim.fn.sign_define(
		"DapBreakpoint",
		{ text = "", texthl = "blue", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
	)
	vim.fn.sign_define(
		"DapBreakpointCondition",
		{ text = "ﳁ", texthl = "blue", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
	)
	vim.fn.sign_define(
		"DapBreakpointRejected",
		{ text = "", texthl = "orange", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
	)
	vim.fn.sign_define(
		"DapStopped",
		{ text = "", texthl = "green", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
	)
	vim.fn.sign_define(
		"DapLogPoint",
		{ text = "", texthl = "yellow", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
	)
end


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
	-- turtle" }
})

return global_on_attach
