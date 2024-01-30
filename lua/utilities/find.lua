require("leap").setup({})

vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' }) -- or some grey
vim.api.nvim_set_hl(0, 'LeapMatch', {
	-- For light themes, set to 'black' or similar.
	fg = 'white',
	bold = true,
	nocombine = true,
})

-- Lightspeed colors
-- primary labels: bg = "#f02077" (light theme) or "#ff2f87"  (dark theme)
-- secondary labels: bg = "#399d9f" (light theme) or "#99ddff" (dark theme)
-- shortcuts: bg = "#f00077", fg = "white"
-- You might want to use either the primary label or the shortcut colors
-- for Leap primary labels, depending on your taste.
vim.api.nvim_set_hl(0, 'LeapLabelPrimary', {
	fg = 'red', bold = true, nocombine = true,
})
vim.api.nvim_set_hl(0, 'LeapLabelSecondary', {
	fg = 'blue', bold = true, nocombine = true,
})
-- Try it without this setting first, you might find you don't even miss it.
require('leap').opts.highlight_unlabeled_phase_one_targets = true
require('leap').add_default_mappings()
