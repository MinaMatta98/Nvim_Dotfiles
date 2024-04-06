require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all"
	playground = {
		enable = true,
		disable = {},
		updatetime = 25,   -- Debounced time for highlighting nodes in the playground from source code
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
	ensure_installed = { "c", "lua", "rust", "cpp", "javascript", "c_sharp", "make", "python", "cpp", "go" },
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

	disable = { "lua" },
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
		max_file_lines = 6000,
		-- disable = { "lua" },
		disable = function(_, bufnr)
			return vim.api.nvim_buf_line_count(bufnr) > 10000
		end,
	},
	rainbow = {
		enable = true,
		disable = { "jsx", "cpp", "rust" },
		-- , list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
})
