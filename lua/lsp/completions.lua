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
		completion = cmp.config.window.bordered({
			side_padding = 0,
			scrolloff = 0,
			col_offset = 0,
			winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:PmenuSel,Search:None",
		}),
		documentation = cmp.config.window.bordered({
			col_offset = 0,
			side_padding = 0,
			winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:PmenuSbar,Search:None",
		}),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-UP>"] = cmp.mapping.scroll_docs(-4),
		["<C-DOWN>"] = cmp.mapping.scroll_docs(4),
		["<C-Enter>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
				-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
				-- that way you will only jump inside the snippet region
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lsp_code_action" },
		-- { name = 'nvim_lsp_document_symbol' },
		{ name = "nvim_lsp" },
		{ name = 'cmp_buffer' },
		{ name = "path" },
		{ name = "crates" },
		{ name = 'otter' },
		{
			name = "nuget",
			keyword_length = 0,
		},
		-- { name = 'vsnip' }, -- For vsnip users.
		{ name = 'luasnip' },
		-- { name = "luasnip" }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = "buffer" },
	}),
	-- formatting = {
	-- 	fields = { "kind", "abbr", "menu" },
	-- 	format = function(entry, vim_item)
	-- 		-- Kind icons
	-- 		vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
	-- 		-- Source
	-- 		vim_item.menu = ({
	-- 			buffer = "[Buffer]",
	-- 			nvim_lsp = "[LSP]",
	-- 			luasnip = "[LuaSnip]",
	-- 			nvim_lua = "[Lua]",
	-- 			latex_symbols = "[LaTeX]",
	-- 		})[entry.source.name]
	-- 		return vim_item
	-- 	end,
	-- },

	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
			-- Source
			vim_item.menu = ({
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[Lua]",
				latex_symbols = "[LaTeX]",
				nuget = "[NuGet]",
				-- code_action = "[LSP Code Action]"
			})[entry.source.name]
			-- Check if the source is nvim_lsp and set menu accordingly
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

require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
	sources = {
		{ name = "dap" },
	},
})

require("cmp").setup({
	enabled = function()
		return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
			or require("cmp_dap").is_dap_buffer()
	end
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
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

