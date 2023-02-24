_G.__luacache_config = {
	chunks = {
		enable = true,
		path = vim.fn.stdpath("cache") .. "/luacache_chunks",
	},
	modpaths = {
		enable = true,
		path = vim.fn.stdpath("cache") .. "/luacache_modpaths",
	},
}
require("impatient")
require("impatient").enable_profile()

-- require("onedark").setup({
-- 	-- Main options --
-- 	style = "dark", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
-- 	transparent = false, -- Show/hide background
-- 	term_colors = true, -- Change terminal color as per the selected theme style
-- 	ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
-- 	cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
-- 	-- toggle theme style ---
-- 	toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
-- 	toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between
-- 	-- Change code style ---
-- 	-- Options are italic, bold, underline, none
-- 	-- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
-- 	code_style = {
-- 		comments = "italic",
-- 		keywords = "none",
-- 		functions = "none",
-- 		strings = "none",
-- 		variables = "none",
-- 	},
-- 	-- Lualine options --
-- 	lualine = {
-- 		transparent = true, -- lualine center bar transparency
-- 	},
-- 	-- Custom Highlights --
-- 	colors = {}, -- Override default colors
-- 	highlights = {}, -- Override highlight groups
-- 	-- Plugins Config --
-- 	diagnostics = {
-- 		darker = true, -- darker colors for diagnostic
-- 		undercurl = false, -- use undercurl instead of underline for diagnostics
-- 		background = true, -- use background color for virtual text
-- 	},
-- })

-- require("onedark").load()
vim.cmd("colorscheme tokyonight-moon")
-- vim.cmd("colorscheme catppuccin-frappe")
require("lualine").setup({
	sections = {
		lualine_e = {
			{
				"mode",
				icons_enabled = true, -- Enables the display of icons alongside the component.
				-- Defines the icon to be displayed in front of the component.
				-- Can be string|table
				-- As table it must contain the icon as first entry and can use
				-- color option to custom color the icon. Example:
				-- {'branch', icon = ''} / {'branch', icon = {'', color={fg='green'}}}

				-- icon position can also be set to the right side from table. Example:
				-- {'branch', icon = {'', align='right', color={fg='green'}}}
				icon = nil,

				separator = nil, -- Determines what separator to use for the component.
				-- Note:
				--  When a string is provided it's treated as component_separator.
				--  When a table is provided it's treated as section_separator.
				--  Passing an empty string disables the separator.
				--
				-- These options can be used to set colored separators
				-- around a component.
				--
				-- The options need to be set as such:
				--   separator = { left = '', right = ''}
				--
				-- Where left will be placed on left side of component,
				-- and right will be placed on its right.
				--

				cond = nil, -- Condition function, the component is loaded when the function returns `true`.

				-- Defines a custom color for the component:
				--
				-- 'highlight_group_name' | { fg = '#rrggbb'|cterm_value(0-255)|'color_name(red)', bg= '#rrggbb', gui='style' } | function
				-- Note:
				--  '|' is synonymous with 'or', meaning a different acceptable format for that placeholder.
				-- color function has to return one of other color types ('highlight_group_name' | { fg = '#rrggbb'|cterm_value(0-255)|'color_name(red)', bg= '#rrggbb', gui='style' })
				-- color functions can be used to have different colors based on state as shown below.
				--
				-- Examples:
				--   color = { fg = '#ffaa88', bg = 'grey', gui='italic,bold' },
				--   color = { fg = 204 }   -- When fg/bg are omitted, they default to the your theme's fg/bg.
				--   color = 'WarningMsg'   -- Highlight groups can also be used.
				--   color = function(section)
				--      return { fg = vim.bo.modified and '#aa3355' or '#33aa88' }
				--   end,
				color = nil, -- The default is your theme's color for that section and mode.

				-- Specify what type a component is, if omitted, lualine will guess it for you.
				--
				-- Available types are:
				--   [format: type_name(example)], mod(branch/filename),
				--   stl(%f/%m), var(g:coc_status/bo:modifiable),
				--   lua_expr(lua expressions), vim_fun(viml function name)
				--
				-- Note:
				-- lua_expr is short for lua-expression and vim_fun is short for vim-function.
				type = nil,

				padding = 1, -- Adds padding to the left and right of components.
				-- Padding can be specified to left or right independently, e.g.:
				--   padding = { left = left_padding, right = right_padding }

				fmt = nil, -- Format function, formats the component's output.
				on_click = nil, -- takes a function that is called when component is clicked with mouse.
				-- the function receives several arguments
				-- - number of clicks incase of multiple clicks
				-- - mouse button used (l(left)/r(right)/m(middle)/...)
				-- - modifiers pressed (s(shift)/c(ctrl)/a(alt)/m(meta)...)
			},
		},
	},
})

local on_attach = function(client, bufnr)
	-- require("lsp-inlayhints").setup()
	-- vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
	-- vim.api.nvim_create_autocmd("LspAttach", {
	-- 	group = "LspAttach_inlayhints",
	-- 	callback = function(args)
	-- 		if not (args.data and args.data.client_id) then
	-- 			return
	-- 		end

	-- 		local bufnr = args.buf
	-- 		local client = vim.lsp.get_client_by_id(args.data.client_id)
	-- 		require("lsp-inlayhints").on_attach(client, bufnr)
	-- 	end,
	-- })
	-- if client.server_capabilities.code_lens then
	--     local codelens = vim.api.nvim_create_augroup(
	--       'LSPCodeLens',
	--       { clear = true }
	--     )
	--     vim.api.nvim_create_autocmd({ 'BufEnter' }, {
	--       group = codelens,
	--       callback = function()
	--         vim.lsp.codelens.refresh()
	--       end,
	--       buffer = bufnr,
	--       once = true,
	--     })
	--     vim.api.nvim_create_autocmd({ 'BufWritePost', 'CursorHold' }, {
	--       group = codelens,
	--       callback = function()
	--         vim.lsp.codelens.refresh()
	--       end,
	--       buffer = bufnr,
	--     })
	--   end
	-- Enable completion triggered by <c-x><c-o>

	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	if client.name == "texlab" then
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip-latex-snippets").setup({})
	end

	if client.name == "rust_analyzer" then
		require("rust-tools").setup({
			{
				tools = { -- rust-tools options
					-- Automatically set inlay hints (type hints)
					autoSetHints = true,
					executor = require("rust-tools.executors").termopen,
					-- Whether to show hover actions inside the hover window
					-- This overrides the default hover handler
					hover_with_actions = true,

					runnables = {
						-- whether to use telescope for selection menu or not
						use_telescope = true,

						-- rest of the opts are forwarded to telescope
					},

					debuggables = {
						-- whether to use telescope for selection menu or not
						use_telescope = true,

						-- rest of the opts are forwarded to telescope
					},

					-- These apply to the default RustSetInlayHints command
					inlay_hints = {
						auto = true,
						-- Only show inlay hints for the current line
						only_current_line = false,

						-- Event which triggers a refersh of the inlay hints.
						-- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
						-- not that this may cause  higher CPU usage.
						-- This option is only respected when only_current_line and
						-- autoSetHints both are true.
						only_current_line_autocmd = "CursorHold",

						-- wheter to show parameter hints with the inlay hints or not
						show_parameter_hints = true,

						-- prefix for parameter hints
						parameter_hints_prefix = "<- ",

						-- prefix for all the other hints (type, chaining)
						other_hints_prefix = "=> ",

						-- whether to align to the length of the longest line in the file
						max_len_align = false,

						-- padding from the left if max_len_align is true
						max_len_align_padding = 1,

						-- whether to align to the extreme right or not
						right_align = false,

						-- padding from the right if right_align is true
						right_align_padding = 7,

						-- The color of the hints
						highlight = "Comment",
					},

					hover_actions = {
						-- the border that is used for the hover window
						-- see vim.api.nvim_open_win()
						border = {
							{ "╭", "FloatBorder" },
							{ "─", "FloatBorder" },
							{ "╮", "FloatBorder" },
							{ "│", "FloatBorder" },
							{ "╯", "FloatBorder" },
							{ "─", "FloatBorder" },
							{ "╰", "FloatBorder" },
							{ "│", "FloatBorder" },
						},

						-- whether the hover action window gets automatically focused
						auto_focus = false,
					},

					-- settings for showing the crate graph based on graphviz and the dot
					-- command
					crate_graph = {
						-- Backend used for displaying the graph
						-- see: https://graphviz.org/docs/outputs/
						-- default: x11
						backend = "x11",
						-- where to store the output, nil for no output stored (relative
						-- path from pwd)
						-- default: nil
						output = nil,
						-- true for all crates.io and external crates, false only the local
						-- crates
						-- default: true
						full = true,
					},
				},

				-- all the opts to send to nvim-lspconfig
				-- these override the defaults set by rust-tools.nvim
				-- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
				server = {
					on_attach = function()
						-- Hover actions
						vim.keymap.set("n", "<C-g>", rt.hover_actions.hover_actions, { buffer = bufnr })
						-- Code action groups
						vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
					end,
				},
				dap = {
					adapter = {
						type = "executable",
						command = "lldb-vscode",
						name = "rt_lldb",
					},
				},
			},
		})
	end
	require("nvim-autopairs").setup({})

	require("nvim-dap-virtual-text").setup({
		enabled = true, -- enable this plugin (the default)
		enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
		highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
		highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
		show_stop_reason = true, -- show stop reason when stopped for exceptions
		commented = false, -- prefix virtual text with comment string
		only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
		all_references = false, -- show virtual text on all all references of the variable (not only definitions)
		filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
		-- experimental features:
		virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
		all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
		virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
		virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
		-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
	})
	require("dapui").setup({
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
			-- Display controls in this element
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

	local dap = require("dap")
	local dapui = require("dapui")
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open({ reset = true })
	end
	-- default configuration
	require("illuminate").configure({
		-- providers: provider used to get references in the buffer, ordered by priority
		providers = {
			"lsp",
			"treesitter",
			"regex",
		},
		-- delay: delay in milliseconds
		delay = 100,
		-- filetype_overrides: filetype specific overrides.
		-- The keys are strings to represent the filetype while the values are tables that
		-- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist

		filetype_overrides = {},
		-- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
		filetypes_denylist = {
			"dirvish",
			"fugitive",
			"ttl",
		},
		-- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
		filetypes_allowlist = {},
		-- modes_denylist: modes to not illuminate, this overrides modes_allowlist
		-- See `:help mode()` for possible values
		modes_denylist = {},
		-- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
		-- See `:help mode()` for possible values
		modes_allowlist = {},
		-- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
		-- Only applies to the 'regex' provider
		-- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
		providers_regex_syntax_denylist = {},
		-- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
		-- Only applies to the 'regex' provider
		-- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
		providers_regex_syntax_allowlist = {},
		-- under_cursor: whether or not to illuminate under the cursor
		under_cursor = true,
		-- large_file_cutoff: number of lines at which to use large_file_config
		-- The `under_cursor` option is disabled when this cutoff is hit
		large_file_cutoff = 2000,
		-- large_file_config: config to use for large files (based on large_file_cutoff).
		-- Supports the same keys passed to .configure
		-- If nil, vim-illuminate will be disabled for large files.
		large_file_overrides = {
			providers = { "regex" },
			delay = 500,
			modes_allowlist = { "n" },
		},
		-- min_count_to_highlight: minimum number of matches required to perform highlighting
		min_count_to_highlight = 1,
	})

	require("neogen").setup({
		snippet_engine = "luasnip",
		enabled = true, --if you want to disable Neogen
		input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
		-- jump_map = "<C-e>"       -- (DROPPED SUPPORT, see [here](#cycle-between-annotations) !) The keymap in order to jump in the annotation fields (in insert mode)
		languages = {
			lua = {
				template = {
					annotation_convention = "ldoc", -- for a full list of annotation_conventions, see supported-languages below,
				},
			},
		},
	})

	if client.server_capabilities.documentSymbolProvider then
		require("nvim-navic").attach(client, bufnr)
		vim.opt_local.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
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

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("i", "<c-s>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<c-s>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "gD", "<cmd>lua require('telescope.builtin').diagnostics()<CR>", bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<F2>", "<cmd>lua require'dap'.step_over()<CR>", bufopts)
	vim.keymap.set("n", "<F1>", "<cmd>lua require'dap'.step_into()<CR>", bufopts)
	vim.keymap.set("n", "<F3>", "<cmd>lua require'dap'.step_out()<CR>", bufopts)
	vim.keymap.set("n", "<space>dl", "<cmd>lua require'dapui'.open()<CR>", bufopts)
	vim.keymap.set("n", "<leader>C", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", bufopts)
	vim.keymap.set(
		"n",
		"<leader>B",
		"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint Condition: '))<CR>",
		bufopts
	)
	vim.keymap.set("x", "<leader>ja", "<cmd>MagmaEvaluateVisual<CR>", bufopts)
	vim.keymap.set("n", "<leader>ji", "<cmd>MagmaInit<CR>", bufopts)
	vim.keymap.set("n", "<leader>jj", "<cmd>MagmaEvaluateLine<CR>", bufopts)
	vim.keymap.set("n", "<leader>jr", "<cmd>MagmaReevaluateCell<CR>", bufopts)
	vim.keymap.set("n", "<leader>js", "<cmd>MagmaShowOutput<CR>", bufopts)
	vim.keymap.set("n", "<leader>jd", "<cmd>MagmaDelete<CR>", bufopts)
	vim.keymap.set("v", "<leader>ds", "<ESC>:lua require('dap-python').debug_selection()<CR>", bufopts)

	if client.name == "rust_analyzer" then
		vim.keymap.set(
			"n",
			"<leader>O",
			"<cmd>lua require'rust-tools'.open_cargo_toml.open_cargo_toml()<CR>",
			{ buffer = bufnr }
		)
		vim.keymap.set("n", "<leader>R", "<cmd>RustRun<CR>", { buffer = bufnr })
		vim.keymap.set("n", "<leader>A", "<cmd>RustCodeAction<CR>", { buffer = bufnr })
	end

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

	-- vim.fn.sign_define("DiagnosticSignError", { text = "✗", texthl = "DiagnosticSignError" })
	-- vim.fn.sign_define("DiagnosticSignWarn", { text = "!", texthl = "DiagnosticSignWarn" })
	-- vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "DiagnosticSignInfo" })
	-- vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers["signature_help"], {
		border = "rounded",
		close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
	})
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
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
	vim.lsp.handlers["textDocument/implementation"] = builtin.lsp_implementation
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

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup()
require("mason-nvim-dap").setup({
	automatic_setup = true,
})

require("mason-nvim-dap").setup({
	ensure_installed = { "stylua", "jq", "debugpy", "clangd" },
})

local dap = require("dap")
require("mason-nvim-dap").setup_handlers({
	function(source_name)
		-- all sources with no handler get passed here

		-- Keep original functionality of `automatic_setup = true`
		require("mason-nvim-dap.automatic_setup")(source_name)
	end,
	python = function(source_name)
		dap.adapters.python = {
			type = "executable",
			command = "/usr/bin/python3",
			args = {
				"-m",
				"debugpy.adapter",
			},
		}

		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				justMyCode = false,
				name = "Launch file",
				program = "${file}", -- This configuration will launch the current file if used.
			},
		}

		dap.adapters.cpp = {
			type = "executable",
			command = "lldb-vscode",
			env = {
				LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
			},
			stopAtEntry = true,
			name = "lldb",
		}
		dap.configurations.cpp = {
			{
				name = "Launch",
				type = "cpp",
				request = "launch",
				-- processId = require('dap.utils').pick_process,
				mode = "local",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/" .. vim.fn.expand("%:t:r"))
				end,
				cwd = "${workspaceFolder}",
				args = {},
				setupCommands = {
					{
						text = "-enable-pretty-printing",
						description = "enable pretty printing",
						ignoreFailures = false,
					},
				},
			},
			-- {
			-- name = 'Attach to gdbserver :1234',
			-- type = 'cpp',
			-- request = 'launch',
			-- MIMode = 'gdb',
			-- miDebuggerServerAddress = 'localhost:1234',
			-- miDebuggerPath = '/usr/bin/gdb',
			-- cwd = '${workspaceFolder}',
			-- program = function()
			-- return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
			-- end,
			-- stopAtEntry = true,
			-- },
		}
		dap.configurations.c = dap.configurations.cpp
	end,
})
require("mason-null-ls").setup({
	automatic_setup = true,
	automatic_installation = true,
})
require("mason-null-ls").setup_handlers()
local kind_icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "ﴯ",
	Interface = "",
	Module = "",
	Property = "ﰠ",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}
local cmp = require("cmp")
cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-UP>"] = cmp.mapping.scroll_docs( -4),
		["<C-DOWN>"] = cmp.mapping.scroll_docs(4),
		["<C-Enter>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		-- { name = 'vsnip' }, -- For vsnip users.
		{ name = "luasnip" }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = "buffer" },
	}),
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			-- Source
			vim_item.menu = ({
					buffer = "[Buffer]",
					nvim_lsp = "[LSP]",
					luasnip = "[LuaSnip]",
					nvim_lua = "[Lua]",
					latex_symbols = "[LaTeX]",
				})[entry.source.name]
			return vim_item
		end,
	},
	vim.keymap.set("n", "<leader>dt", "<cmd>lua require'dap'.continue()<CR>", bufopts),
	vim.keymap.set("n", "<space>du", "<cmd>lua require'dapui'.close()<CR>", bufopts),
})
-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it. }, {
		{ name = "buffer" },
	}),
})
require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
-- nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>
-- nnoremap <silent> <leader>df :lua require('dap-python').test_class()<CR>
-- vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>
local lib = require("nvim-tree.lib")
local view = require("nvim-tree.view")

local function collapse_all()
	require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
end

local function edit_or_open()
	-- open as vsplit on current node
	local action = "edit"
	local node = lib.get_node_at_cursor()

	-- Just copy what's done normally with vsplit
	if node.link_to and not node.nodes then
		require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
		view.close() -- Close the tree if file was opened
	elseif node.nodes ~= nil then
		lib.expand_or_collapse(node)
	else
		require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
		view.close() -- Close the tree if file was opened
	end
end

local swap_then_open_tab = function()
	local node = lib.get_node_at_cursor()
	vim.cmd("wincmd l")
	api.node.open.tab(node)
end
local function vsplit_preview()
	-- open as vsplit on current node
	local action = "vsplit"
	local node = lib.get_node_at_cursor()

	-- Just copy what's done normally with vsplit
	if node.link_to and not node.nodes then
		require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
	elseif node.nodes ~= nil then
		lib.expand_or_collapse(node)
	else
		require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
	end

	-- Finally refocus on tree if it was lost
	view.focus()
end

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
	view = {
		mappings = {
			custom_only = false,
			list = {
				{ key = "l", action = "edit",           action_cb = edit_or_open },
				{ key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
				{ key = "h", action = "close_node" },
				{ key = "H", action = "collapse_all",   action_cb = collapse_all },
			},
		},
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
vim.api.nvim_set_keymap("n", "<C-f>", ":NvimTreeToggle<cr>", { silent = true, noremap = true })
require("nvim-tree").setup(treeconfig)

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

require("nvim-navic").setup({
	icons = {
		File = " ",
		Module = " ",
		Namespace = " ",
		Package = " ",
		Class = " ",
		Method = " ",
		Property = " ",
		Field = " ",
		Constructor = " ",
		Enum = "練",
		Interface = "練",
		Function = " ",
		Variable = " ",
		Constant = " ",
		String = " ",
		Number = " ",
		Boolean = "◩ ",
		Array = " ",
		Object = " ",
		Key = " ",
		Null = "ﳠ ",
		EnumMember = " ",
		Struct = " ",
		Event = " ",
		Operator = " ",
		TypeParameter = " ",
	},
	highlight = true,
	separator = " > ",
	depth_limit = 0,
	depth_limit_indicator = "..",
	safe_output = false,
})

require("lspconfig").vimls.setup({
	require("cmp_nvim_lsp").default_capabilities(),
	on_attach = on_attach,
})

require("lspconfig").yamlls.setup({
	require("cmp_nvim_lsp").default_capabilities(),
	on_attach = on_attach,
})

require("lspconfig").rome.setup({
	require("cmp_nvim_lsp").default_capabilities(),
	on_attach = on_attach,
})

require("lspconfig").bashls.setup({
	require("cmp_nvim_lsp").default_capabilities(),
	on_attach = on_attach,
})

require("lspconfig").texlab.setup({
	require("cmp_nvim_lsp").default_capabilities(),
	on_attach = on_attach,
})

-- require("lspconfig").turtle_ls.setup({
-- 	require("cmp_nvim_lsp").default_capabilities(),
-- 	on_attach = on_attach,
-- })

require("lspconfig").lua_ls.setup({
	require("cmp_nvim_lsp").default_capabilities(),
	on_attach = on_attach,
})

require("lspconfig").cssmodules_ls.setup({
	require("cmp_nvim_lsp").default_capabilities(),
	on_attach = on_attach,
})

require("lspconfig").pyright.setup({
	require("cmp_nvim_lsp").default_capabilities(),
	on_attach = on_attach,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }

require("lspconfig").clangd.setup({
	require("cmp_nvim_lsp").default_capabilities(),
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").emmet_ls.setup({
	require("cmp_nvim_lsp").default_capabilities(),
	on_attach = on_attach,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").html.setup({
	require("cmp_nvim_lsp").default_capabilities(),
	on_attach = on_attach,
	capabilities = capabilities,
})
require("lspconfig").phpactor.setup({
	require("cmp_nvim_lsp").default_capabilities(),
	on_attach = on_attach,
})

require("lspconfig")["rust_analyzer"].setup({
	require("cmp_nvim_lsp").default_capabilities(),
	on_attach = on_attach,
})

require("lspconfig").lemminx.setup({
	require("cmp_nvim_lsp").default_capabilities(),
	on_attach = on_attach,
})
require("lspconfig").tsserver.setup({
	require("cmp_nvim_lsp").default_capabilities(),
	on_attach = on_attach,
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	-- turtle" }
})

require("startup").setup({ theme = "dashboard" })

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

-- dap.listeners.before.event_terminated["dapui_config"] = function()
-- 	dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
-- 	dapui.close()
-- end

require("nvim-web-devicons").setup({
	default = true,
	-- your personnal icons can go here (to override)
	-- you can specify color or cterm_color instead of specifying both of them
	-- DevIcon will be appended to `name`
	override = {
		zsh = {
			icon = "",
			color = "#428850",
			cterm_color = "65",
			name = "Zsh",
		},
	},
	-- globally enable different highlight colors per icon (default to true)
	-- if set to false all icons will have the default icon's color
	color_icons = true,
	-- globally enable default icons (default to false)
	-- will get overriden by `get_icons` option
})
require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all"
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		is_supported = function()
			if vim.fn.strwidth(vim.fn.getline(".")) > 300 or vim.fn.getfsize(vim.fn.expand("%")) > 1024 * 1024 then
				return false
			else
				return true
			end
		end,
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},
	ensure_installed = { "c", "lua", "rust", "cpp" },
	matchup = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,
	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,
	-- List of parsers to ignore installing (for "all")
	ignore_install = { "javascript" },
	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
		-- the name of the parser)
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
		max_file_lines = 10000,
		disable = function(_, bufnr)
			return vim.api.nvim_buf_line_count(bufnr) > 10000
		end,
	},
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
})

local null_ls = require("null-ls")

null_ls.setup({
	debug = false,
	sources = {
		null_ls.builtins.formatting.stylua,
		-- null_ls.builtins.diagnostics.eslintd,
		-- null_ls.builtins.completion.spell,
		null_ls.builtins.formatting.shellharden,
		null_ls.builtins.formatting.astyle,
		null_ls.builtins.formatting.black,
	},
})

require("notify").setup({
	-- Animation style (see below for details)
	stages = "fade_in_slide_out",
	-- Function called when a new window is opened, use for changing win settings/config
	on_open = nil,
	-- Function called when a window is closed
	on_close = nil,
	-- Render function for notifications. See notify-render()
	render = "default",
	-- Default timeout for notifications
	timeout = 5000,
	-- For stages that change opacity this is treated as the highlight behind the window
	-- Set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
	background_colour = "Normal",
	-- Minimum width for notification windows
	minimum_width = 50,
	-- Icons for the different levels
	icons = {
		ERROR = "",
		WARN = "",
		INFO = "",
		DEBUG = "",
		TRACE = "✎",
	},
})

require("telescope").load_extension("notify")
vim.notify = require("notify")

-- Set barbar's options
require("bufferline").setup({
	-- Enable/disable animations
	animation = true,
	-- Enable/disable auto-hiding the tab bar when there is a single buffer
	auto_hide = true,
	-- Enable/disable current/total tabpages indicator (top right corner)
	tabpages = true,
	-- Enable/disable close button
	closable = false,
	-- Enables/disable clickable tabs
	--  - left-click: go to buffer
	--  - middle-click: delete buffer
	clickable = true,
	-- Enables / disables diagnostic symbols
	diagnostics = {
		-- you can use a list
		{ enabled = false, icon = "ﬀ" }, -- ERROR
		{ enabled = false }, -- WARN
		{ enabled = false }, -- INFO
		{ enabled = false }, -- HINT

		-- OR `vim.diagnostic.severity`
		[vim.diagnostic.severity.ERROR] = { enabled = false, icon = "ﬀ" },
		[vim.diagnostic.severity.WARN] = { enabled = false },
		[vim.diagnostic.severity.INFO] = { enabled = false },
		[vim.diagnostic.severity.HINT] = { enabled = false },
	},
	-- Excludes buffers from the tabline
	exclude_ft = { "javascript" },
	exclude_name = { "package.json" },
	-- -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
	-- hide = {extensions = true, inactive = true},

	-- Disable highlighting alternate buffers
	highlight_alternate = false,
	-- Enable highlighting visible buffers
	highlight_visible = true,
	-- Enable/disable icons
	-- if set to 'numbers', will show buffer index in the tabline
	-- if set to 'both', will show buffer index and icons in the tabline
	icons = true,
	-- If set, the icon color will follow its corresponding buffer
	-- highlight group. By default, the Buffer*Icon group is linked to the
	-- Buffer* group (see Highlighting below). Otherwise, it will take its
	-- default value as defined by devicons.
	icon_custom_colors = false,
	-- Configure icons on the bufferline.
	icon_separator_active = "▎",
	icon_separator_inactive = "",
	icon_close_tab = "",
	icon_close_tab_modified = "●",
	icon_pinned = "車",
	-- If true, new buffers will be inserted at the start/end of the list.
	-- Default is to insert after current buffer.
	insert_at_end = false,
	insert_at_start = false,
	-- Sets the maximum padding width with which to surround each tab
	maximum_padding = 1,
	-- Sets the minimum padding width with which to surround each tab
	minimum_padding = 1,
	-- Sets the maximum buffer name length.
	maximum_length = 30,
	-- If set, the letters for each buffer in buffer-pick mode will be
	-- assigned based on their name. Otherwise or in case all letters are
	-- already assigned, the behavior is to assign letters in order of
	-- usability (see order below)
	semantic_letters = true,
	-- New buffer letters are assigned in this order. This order is
	-- optimal for the qwerty keyboard layout but might need adjustement
	-- for other layouts.
	letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
	-- Sets the name of unnamed buffers. By default format is "[Buffer X]"
	-- where X is the buffer number. But only a static string is accepted here.
	no_name_title = nil,
})

require("indent_blankline").setup({
	-- for example, context is off by default, use this to turn it on
	show_current_context = true,
	show_current_context_start = false,
	space_char_highlight_list = { "IndentBLHi1", "IndentBLHi2" },
	space_char_blankline_highlight_list = { "IndentBLHi1", "IndentBLHi2" },
})

vim.cmd([[ autocmd FileType * highlight rainbowcol1 guifg=#61AFEF gui=bold ]])
vim.g.magma_image_provider = "ueberzug"
require("colorizer").setup({
	"*",
})
-- -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
--
require("vgit").setup()
