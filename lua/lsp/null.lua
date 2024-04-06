local null_ls = require("null-ls");

null_ls.setup({
	-- debug = false,
	sources = {
		-- null_ls.builtins.diagnostics.pylint,
		-- null_ls.builtins.diagnostics.eslintd,
		-- null_ls.builtins.completion.spell,
		null_ls.builtins.diagnostics.ruff,
		null_ls.builtins.diagnostics.mypy,
		null_ls.builtins.formatting.black,
	},
})
