local function clients(client, bufnr)
	if client.name == "rust_analyzer" then
		vim.keymap.set("n", "<leader>O", "<cmd>lua require'rust-tools'.open_cargo_toml.open_cargo_toml()<CR>",
			{ buffer = bufnr })
		vim.keymap.set("n", "<leader>R", "<cmd>RustRun<CR>", { buffer = bufnr })
		vim.keymap.set("n", "<leader>A", "<cmd>RustCodeAction<CR>", { buffer = bufnr })
	end

	if client.name == "texlab" then
		require("luasnip-latex-snippets").setup({})
	end

	-- Not equal?
	if client.name ~= "rust_analyzer" then
		vim.keymap.set({ "v", "n" }, "<leader>A", require("actions-preview").code_actions)
	end
end

return clients
