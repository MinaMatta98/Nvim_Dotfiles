local crates = require("crates")
crates.setup()

local bufopts = { noremap = true, silent = true, buffer = bufnr }

vim.api.nvim_create_autocmd("FileType", {
	desc = "Attach keymappings",
	group = vim.api.nvim_create_augroup("toml", { clear = false }),
	pattern = "toml",
	callback = function()
		vim.keymap.set("n", "<leader>ct", crates.toggle, bufopts)
		vim.keymap.set("n", "<leader>cr", crates.reload, bufopts)
		-- vim.keymap.set("n", "K", show_documentation, { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>cc", crates.show_popup, bufopts)
		vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, bufopts)
		vim.keymap.set("n", "<leader>cf", crates.show_features_popup, bufopts)
		vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, bufopts)

		vim.keymap.set("n", "<leader>cu", crates.update_crate, bufopts)
		vim.keymap.set("v", "<leader>cu", crates.update_crates, bufopts)
		vim.keymap.set("n", "<leader>ca", crates.update_all_crates, bufopts)
		vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, bufopts)
		vim.keymap.set("v", "<leader>cU", crates.upgrade_crates, bufopts)
		vim.keymap.set("n", "<leader>cA", crates.upgrade_all_crates, bufopts)

		vim.keymap.set("n", "<leader>cH", crates.open_homepage, bufopts)
		vim.keymap.set("n", "<leader>cR", crates.open_repository, bufopts)
		vim.keymap.set("n", "<leader>cD", crates.open_documentation, bufopts)
		vim.keymap.set("n", "<leader>cC", crates.open_crates_io, bufopts)
	end,
})
