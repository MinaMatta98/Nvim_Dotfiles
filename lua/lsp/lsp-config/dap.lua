require("nvim-dap-virtual-text").setup({
	enabled = true,                     -- enable this plugin (the default)
	enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
	highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
	highlight_new_as_changed = false,   -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
	show_stop_reason = true,            -- show stop reason when stopped for exceptions
	commented = false,                  -- prefix virtual text with comment string
	only_first_definition = true,       -- only show virtual text at first definition (if there are multiple)
	all_references = false,             -- show virtual text on all all references of the variable (not only definitions)
	filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
	-- experimental features:
	virt_text_pos = "eol",              -- position of virtual text, see `:h nvim_buf_set_extmark()`
	all_frames = false,                 -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
	virt_lines = false,                 -- show virtual lines instead of virtual text (will flicker!)
	virt_text_win_col = nil,            -- position the virtual text at a fixed window column (starting from the first text column) ,
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


dap.adapters.codelldb = {
	type = 'executable',
	command = 'lldb-vscode',
	cwd = '${workspaceFolder}',
}

dap.configurations.rust = dap.adapters.codelldb

dap.configurations.cs = require("lsp.dotnet")

local mason = require 'mason-registry';


require('dap-vscode-js').setup({
	adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
	-- debugger_path = "/home/mina/nvim/mason/packages/vscode-js-debug",                         -- Path to vscode-js-debug installation.
	debugger_path = mason.get_package('js-debug-adapter'):get_install_path(),                 -- Path to vscode-js-debug installation.
})

-- local dap_status_ok, dap = pcall(require, "dap")
-- if not dap_status_ok then
-- 	return
-- end

-- dap.adapters["pwa-node"] = {
-- 	type = "server",
-- 	host = "localhost",
-- 	port = "${port}", --let both ports be the same for now...
-- 	executable = {
-- 		command = "node",
-- 		-- -- 💀 Make sure to update this path to point to your installation
-- 		args = { "/home/mina/nvim/mason/packages/vscode-js-debug" },
-- 		-- command = "js-debug-adapter",
-- 		-- args = { "${port}" },
-- 	},
-- }

for _, language in ipairs({ "typescript", "javascript" }) do
	dap.configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Laycn Current File (pwa-node with ts-node)",
			cwd = "${workspaceFolder}",
			runtimeArgs = { "--loader", "ts-node/esm" },
			runtimeExecutable = "node",
			args = { "${file}" },
			sourceMaps = true,
			protocol = "inspector",
			skipFiles = { '<node_internals>/**', 'node_modules/**' },
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			}
		},
		-- {
		-- 	type = 'pwa-node',
		-- 	request = 'launch',
		-- 	name = 'Launch Current File (pwa-node)',
		-- 	cwd = "${workspaceFolder}", -- vim.fn.getcwd(),
		-- 	args = { '${file}' },
		-- 	sourceMaps = true,
		-- 	protocol = 'inspector',
		-- 	console = 'integratedTerminal'
		-- },
		{
			type = 'pwa-node',
			request = 'launch',
			name = 'Launch Current File (Typescript)',
			cwd = "${workspaceFolder}",
			runtimeArgs = { '--loader=ts-node/esm' },
			program = "${file}",
			runtimeExecutable = 'node',
			-- args = { '${file}' },
			sourceMaps = true,
			protocol = 'inspector',
			outFiles = { "${workspaceFolder}/**/**/*", "!**/node_modules/**" },
			skipFiles = { '<node_internals>/**', 'node_modules/**' },
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			},
			console = 'integratedTerminal'
		},
		{
			type = "pwa-chrome",
			request = "launch",
			name = "Launch and Debug Chrome",
			url = function()
				local co = coroutine.running()
				return coroutine.create(
					function()
						vim.ui.input({
							prompt = "Enter URL:",
							default = "http://localhost:3000",
						}, function(url)
							if url == nill or url == "" then
								return
							else
								coroutine.resume(co, url)
							end
						end)
					end
				)
			end,
			webroot = "${workspaceFolder}",
			skipFiles = { '<node_internals>/**/*.js' },
			protocol = 'inspector',
			sourceMaps = true,
			useDataDir = false
		},
	}
end

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

local set_namespace = vim.api.nvim__set_hl_ns or vim.api.nvim_set_hl_ns
local namespace = vim.api.nvim_create_namespace("dap-hlng")
vim.api.nvim_set_hl(0, "blue", { fg = "#3d59a1" })
vim.api.nvim_set_hl(0, "green", { fg = "#9ece6a" })
vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" })
vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" })
