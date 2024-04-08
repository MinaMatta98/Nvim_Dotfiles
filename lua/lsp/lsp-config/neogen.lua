require("neogen").setup({
	snippet_engine = "luasnip",
	enabled = true,           --if you want to disable Neogen
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
