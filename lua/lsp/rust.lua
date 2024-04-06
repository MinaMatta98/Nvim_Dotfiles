local rust_opts = {
	tools = {
		autoSetHints = true,
		executor = require("rust-tools.executors").termopen,
		runnables = {
			use_telescope = true,
		},
		debuggables = {
			use_telescope = true,
		},
		inlay_hints = {
			auto = true,
			only_current_line = false,
			only_current_line_autocmd = "CursorHold",
			show_parameter_hints = true,
			parameter_hints_prefix = "<- ",
			other_hints_prefix = "=> ",
			max_len_align = false,
			max_len_align_padding = 1,
			right_align = false,
			right_align_padding = 7,
			highlight = "Comment",
		},
		hover_actions = {
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
			auto_focus = false,
		},
		crate_graph = {
			backend = "x11",
			output = nil,
			full = true,
		},
	},
	server = {
		on_attach = require("lsp.config"),
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
		standalone = false,
		settings = {
			["rust-analyzer"] = {
				-- enable clippy on save
				checkOnSave = {
					command = "clippy",
					extraArgs = { "--all", "--", "-W", "clippy::all", "-D", "inactive-code" },
				},
				rustfmt = {
					override_command = { "leptosfmt", "--rustfmt" }
				},
				cargo = {
					buildScripts = {
						enable = true,
					},
				},
				procMacro = {
					enable = true,
					ignored = {
						leptos_macro = {
							-- "component",
							"server",
						},
					}
				},
			},
		},
	},
	dap = {
		adapter = {
			type = "executable",
			command = "lldb-vscode",
			name = "rt_lldb",
		},
	},
}

require("rust-tools").setup(rust_opts)
