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
require("startup").setup({ theme = "dashboard" })
require("barbar").setup({
	-- clickable = true,
	-- -- hide = {extensions = true, inactive = false},
	-- highlight_visible = true,

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

		-- Configure the icons on the bufferline based on the visibility of a buffer.
		-- Supports all the base icon options, plus `modified` and `pinned`.
		-- alternate = { filetype = { enabled = false } },
		-- current = { buffer_index = false },
		-- inactive = { button = '×' },
		-- visible = { modified = { buffer_number = false } },
	},
})

-- Define a custom highlight group for the current buffer's sign column

vim.cmd("colorscheme tokyonight")
