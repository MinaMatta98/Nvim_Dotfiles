local function keymaps(bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	local openUrl = function()
		local url = string.match(vim.fn.getline("."), "[a-z]*://[^ >,;():]*")
		if url ~= "" then
			vim.cmd('exec "!firefox \'' .. url .. '\'"')
		else
			vim.cmd('echo "No URI found in line."')
		end
	end

	vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", bufopts)
	vim.keymap.set("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", bufopts)
	vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", bufopts)
	vim.keymap.set("i", "<c-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)
	vim.keymap.set("n", "<c-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)
	vim.keymap.set("n", "gD", "<cmd>lua require('telescope.builtin').diagnostics()<CR>", bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", bufopts)
	vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", bufopts)
	vim.keymap.set("n", "<F2>", "<cmd>lua require'dap'.step_over()<CR>", bufopts)
	vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", bufopts)
	vim.keymap.set("n", "<F1>", "<cmd>lua require'dap'.step_into()<CR>", bufopts)
	vim.keymap.set("n", "<F3>", "<cmd>lua require'dap'.step_out()<CR>", bufopts)
	vim.keymap.set("n", "<leader>de", "<cmd>lua require('dapui').eval()<CR>", bufopts)
	vim.keymap.set("n", "<space>dl", "<cmd>lua require'dapui'.open()<CR>", bufopts)
	vim.keymap.set("n", "<leader>C", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", bufopts)
	vim.keymap.set("n", "<leader>tws", "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>", bufopts)
	vim.keymap.set("n", "<leader>ts", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", bufopts)
	vim.keymap.set("n", "<leader>tr", "<cmd>lua require('neotest').run.run()<CR>", bufopts)
	vim.keymap.set("n", "<leader>tt", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", bufopts)
	vim.keymap.set("n", "<leader>to", "<cmd>lua require('neotest').output.open()<CR>", bufopts)
	vim.keymap.set("n", "<leader>tS", "<cmd>lua require('neotest').summary.toggle()<CR>", bufopts)
	vim.keymap.set("n", "<leader>tn", "<cmd>lua require('neotest').jump.next({status = 'failed'})<CR>", bufopts)
	vim.keymap.set("n", "<leader>tN", "<cmd>lua require('neotest').jump.prev({status = 'failed'})<CR>", bufopts)
	vim.keymap.set("n", "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", bufopts)
	vim.keymap.set("n", "gx", openUrl, { desc = "OpenUrl Undercurword" })
	vim.keymap.set("n", "<leader>B", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint Condition: '))<CR>",
		bufopts)
	vim.keymap.set("x", "<leader>ja", "<cmd>MoltenEvaluateVisual<CR>", bufopts)
	vim.keymap.set("n", "<leader>ji", "<cmd>MoltenInit<CR>", bufopts)
	vim.keymap.set("n", "<leader>jj", "<cmd>MoltenEvaluateLine<CR>", bufopts)
	vim.keymap.set("n", "<leader>jr", "<cmd>MoltenReevaluateCell<CR>", bufopts)
	vim.keymap.set("n", "<leader>js", "<cmd>MoltenShowOutput<CR>", bufopts)
	vim.keymap.set("n", "<leader>jd", "<cmd>MoltenDelete<CR>", bufopts)
	vim.keymap.set("v", "<leader>ds", "<ESC>:lua require('dap-python').debug_selection()<CR>", bufopts)
end

return keymaps
