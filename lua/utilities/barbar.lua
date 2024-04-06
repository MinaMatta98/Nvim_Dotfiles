vim.g.barbar_auto_setup = false -- disable auto-setup

require("barbar").setup({
	-- clickable = true,
	-- -- hide = {extensions = true, inactive = false},
	-- highlight_visible = true,
	animation = true,

	icons = {
		gitsigns = {
			added = { enabled = true, icon = '+' },
			changed = { enabled = true, icon = '~' },
			deleted = { enabled = true, icon = '-' },
		},
		filetype = {
			-- Sets the icon's highlight group.
			-- If false, will use nvim-web-devicons colors
			custom_colors = false,

			-- Requires `nvim-web-devicons` if `true`
			enabled = true,
		},
		separator = { left = '▎', right = '' },

		-- If true, add an additional separator at the end of the buffer list
		separator_at_end = true,

		-- Configure the icons on the bufferline when modified or pinned.
		-- Supports all the base icon options.
		modified = { button = '●' },

		-- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
		preset = 'default',
		-- Set the filetypes which barbar will offset itself for
		sidebar_filetypes = {
			-- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
			NvimTree = true,
			-- Or, specify the text used for the offset:
			undotree = {
				text = 'undotree',
				align = 'center', -- *optionally* specify an alignment (either 'left', 'center', or 'right')
			},
			-- Or, specify the event which the sidebar executes when leaving:
			['neo-tree'] = { event = 'BufWipeout' },
			-- Or, specify all three
			Outline = { event = 'BufWinLeave', text = 'symbols-outline', align = 'right' },
		},

		-- Configure the icons on the bufferline based on the visibility of a buffer.
		-- Supports all the base icon options, plus `modified` and `pinned`.
		-- alternate = { filetype = { enabled = false } },
		-- current = { buffer_index = false },
		-- inactive = { button = '×' },
		-- visible = { modified = { buffer_number = false } },
	},
})
